class PaymentMethods
  include Ruby::Enum

  define :TRANSFER, 'transfer'
  define :WEBPAY, 'webpay'
end
