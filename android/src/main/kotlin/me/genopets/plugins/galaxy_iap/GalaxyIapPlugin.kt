package me.genopets.plugins.galaxy_iap

import com.samsung.android.sdk.iap.lib.listener.OnConsumePurchasedItemsListener
import com.samsung.android.sdk.iap.lib.listener.OnGetOwnedListListener
import com.samsung.android.sdk.iap.lib.listener.OnGetProductsDetailsListener
import com.samsung.android.sdk.iap.lib.vo.*

import org.json.JSONObject
import android.content.Context
import android.util.Log
import com.samsung.android.sdk.iap.lib.helper.HelperDefine
import com.samsung.android.sdk.iap.lib.helper.IapHelper
import com.samsung.android.sdk.iap.lib.listener.OnPaymentListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GalaxyIapPlugin */
class GalaxyIapPlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var context: Context
    private val TAG = "IAP-Samsung"

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "galaxy_iap")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "getPurchasableItems" -> {
                val arguments = call.arguments as? Map<String, Any>
                val productId = arguments?.get("productId") as String
                val operationMode = getOperationMode(arguments?.get("operationMode") as? String)
                getProductDetails(productId, result, operationMode)
            }
            "purchaseItem" -> {
                val arguments = call.arguments as? Map<String, Any>
                val productId = arguments?.get("productId") as String
                val passThroughParam = arguments?.get("passThroughParam") as String
                val operationMode = getOperationMode(arguments?.get("operationMode") as? String)
                purchaseItem(productId, passThroughParam?:"na", result, operationMode)
            }
            "consumePurchasedItem" -> {
                val arguments = call.arguments as? Map<String, Any>
                val purchaseId = arguments?.get("purchaseId") as String
                val operationMode = getOperationMode(arguments?.get("operationMode") as? String)
                consumePurchasedItem(purchaseId, result, operationMode)
            }
            "getUserOwnedItems" -> {
                val arguments = call.arguments as? Map<String, Any>
                val productType = arguments?.get("productType") as String
                val operationMode = getOperationMode(arguments?.get("operationMode") as? String)
                getUserOwnedItems(productType, result, operationMode)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getProductDetails(productId: String, result: Result, operationMode: HelperDefine.OperationMode) {
        val iapHelper: IapHelper = IapHelper.getInstance(context)
        iapHelper.setOperationMode(operationMode)
        iapHelper.getProductsDetails(productId, object : OnGetProductsDetailsListener {
            override fun onGetProducts(errorVo: ErrorVo?, productList: ArrayList<ProductVo>?) {
                if (errorVo == null) return

                if (errorVo.errorCode == IapHelper.IAP_ERROR_NONE) {
                    if (productList == null) return
                    val itemsJsonArray = productList.map { it.jsonString }
                    result.success(itemsJsonArray.toString())
                } else {
                    Log.e(TAG, "onGetProducts > ErrorCode [${errorVo.errorCode}]")
                    Log.e(TAG, "onGetProducts > ErrorString [${errorVo.errorString ?: ""}]")
                    result.error(errorVo.errorCode.toString(), errorVo.errorString, null)
                }
            }
        })
    }

    private fun purchaseItem(productId: String, passThroughParam: String, result: Result, operationMode: HelperDefine.OperationMode) {
        val iapHelper: IapHelper = IapHelper.getInstance(context)
        iapHelper.setOperationMode(operationMode)

        iapHelper.startPayment(productId, passThroughParam
        ) { errorVo, purchaseVo ->
            if (purchaseVo !=null) {
                // Purchase successful
                result.success(purchaseVo.jsonString)
            } else {
                // Purchase failed
                Log.e(TAG, "onPayment > ErrorCode [${errorVo?.errorCode}]")
                Log.e(TAG, "onPayment > ErrorString [${errorVo?.errorString ?: ""}]")
                result.error(errorVo?.errorCode.toString(), errorVo?.errorString, null)
            }
        }
    }

    private fun consumePurchasedItem(purchaseId: String, result: Result, operationMode: HelperDefine.OperationMode) {
        val iapHelper: IapHelper = IapHelper.getInstance(context)
        iapHelper.setOperationMode(operationMode)
        iapHelper.consumePurchasedItems(purchaseId, object : OnConsumePurchasedItemsListener {
            override fun onConsumePurchasedItems(errorVo: ErrorVo?, consumeList: ArrayList<ConsumeVo>?) {
                if (errorVo == null) return

                if (errorVo.errorCode == IapHelper.IAP_ERROR_NONE) {
                    if (consumeList == null) return
                    val consumedItems = consumeList.map { it.jsonString }
                    result.success(consumedItems.toString())
                } else {
                    Log.e(TAG, "onConsumePurchasedItems > ErrorCode [${errorVo.errorCode}]")
                    Log.e(TAG, "onConsumePurchasedItems > ErrorString [${errorVo.errorString ?: ""}]")
                    result.error(errorVo.errorCode.toString(), errorVo.errorString, null)
                }
            }
        })
    }

    private fun getUserOwnedItems(productType: String,result: Result, operationMode: HelperDefine.OperationMode) {
        val iapHelper: IapHelper = IapHelper.getInstance(context)
        iapHelper.setOperationMode(operationMode)
        iapHelper.getOwnedList(productType) { errorVo: ErrorVo?, ownedList: ArrayList<OwnedProductVo>? ->
                if (errorVo == null) return@getOwnedList

                if (errorVo.errorCode == IapHelper.IAP_ERROR_NONE) {
                    if (ownedList == null) return@getOwnedList
                    val ownedItems = ownedList.map {ownedProduct->
                        val jsonObject = JSONObject(ownedProduct.jsonString)
                        jsonObject.put("isConsumable", ownedProduct.isConsumable)
                        jsonObject.toString()
                    }

                    result.success(ownedItems.toString())
                } else {
                    Log.e(TAG, "onGetOwnedList > ErrorCode [${errorVo.errorCode}]")
                    Log.e(TAG, "onGetOwnedList > ErrorString [${errorVo.errorString ?: ""}]")
                    result.error(errorVo.errorCode.toString(), errorVo.errorString, null)
                }
        }
    }

    private fun getOperationMode(operationMode: String?): HelperDefine.OperationMode {
        return when (operationMode) {
            "OPERATION_MODE_PRODUCTION" -> HelperDefine.OperationMode.OPERATION_MODE_PRODUCTION
            "OPERATION_MODE_TEST" -> HelperDefine.OperationMode.OPERATION_MODE_TEST
            "OPERATION_MODE_TEST_FAILURE" -> HelperDefine.OperationMode.OPERATION_MODE_TEST_FAILURE
            else -> HelperDefine.OperationMode.OPERATION_MODE_TEST
        }
    }
}
