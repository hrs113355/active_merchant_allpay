require File.dirname(__FILE__) + '/allpay/helper.rb'
require File.dirname(__FILE__) + '/allpay/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Allpay
        autoload :Helper, 'active_merchant/billing/integrations/allpay/helper.rb'
        autoload :Notification, 'active_merchant/billing/integrations/allpay/notification.rb'

        PAYMENT_CREDIT_CARD = 'Credit'
        PAYMENT_ATM         = 'ATM'
        PAYMENT_CVS         = 'CVS'
        PAYMENT_ALIPAY      = 'Alipay'
        PAYMENT_BARCODE     = 'BARCODE'

        SUBPAYMENT_ATM_TAISHIN      = 'TAISHIN'
        SUBPAYMENT_ATM_ESUN         = 'ESUN'
        SUBPAYMENT_ATM_HUANAN       = 'HUANAN'
        SUBPAYMENT_ATM_BOT          = 'BOT'
        SUBPAYMENT_ATM_FUBON        = 'FUBON'
        SUBPAYMENT_ATM_CHINATRUST   = 'CHINATRUST'
        SUBPAYMENT_ATM_FIRST        = 'FIRST'

        SUBPAYMENT_CVS_CVS    = 'CVS'
        SUBPAYMENT_CVS_OK     = 'OK'
        SUBPAYMENT_CVS_FAMILY = 'FAMILY'
        SUBPAYMENT_CVS_HILIFE = 'HILIFE'
        SUBPAYMENT_CVS_IBON   = 'IBON'

        PAYMENT_TYPE        = 'aio'

        mattr_accessor :service_url
        mattr_accessor :merchant_id
        mattr_accessor :hash_key
        mattr_accessor :hash_iv
        mattr_accessor :debug

        def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
            when :production
              'https://payment.ecpay.com.tw/Cashier/AioCheckOut'
            when :development
              'https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut'
            when :test
              'https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut'
            else
              raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end

        def self.notification(post)
          Notification.new(post)
        end

        def self.setup
          yield(self)
        end

      end
    end
  end
end
