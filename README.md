Form Manager
============

This is a library to mimic the functionality of HTML forms in ActionScript 3 projects. 

Features
--------

The following classes / components are included:

* FormManager (dls.formmanager.FormManager) -- An instance of the FormManager class can be use to auto-handle form validation, submission, and response.
* Form (dls.formmanager.form.Form) -- A class to mimic an HTML form, containing a list of input elements, hidden elements, action and method type attributes, a submit button, and a submit type.
* IFormSubmitter (dls.formmanager.submitters.IFormSubmitter) -- An interface whose implementations are used to submit and relay responses for a given form.
* FormValidator (dls.formmanager.validator.FormValidator) -- A mini-library which can handle and relay responses regarding form validation, inspired in part by jQuery validate. It contains a default set of constraints which form elements can be tested against.


Usage
-----

Import the necessary classes:

    import dls.formmanager.FormManager;
    import dls.formmanager.IFormManager;
    import dls.formmanager.submitter.IFormSubmitter;
    import dls.formmanager.submitter.PollingSubmitter;
    import dls.formmanager.submitter.SimpleSubmitter;
    import dls.formmanager.validator.FormValidator;

Initialize the FormManager:

    var submitters:Vector.<IFormSubmitter> = new <IFormSubmitter>[
      new SimpleSubmitter(),
      new PollingSubmitter('http://mydomain.com/polling-endpoint', 2000)
    ];
    var formValidator:FormValidator = new FormValidator();
    var formManager = new FormManager(submitters, formValidator);

Build a form:
    
    // all are implementations of IFormElement
    public var emailAddress:MyTextInput;
    public var shippingMethod:MyDropdown;
    public var creditCardNumber:MyTextInput;
    public var expMonth:MyDropdown;
    public var expYear:MyDropdown;
    
    // implementation of IFormButton
    public var submitOrder:MyFormButton;
    
    var paymentForm:Form = new Form("http://mydomain.com/form-submit-endpoint", new <String>["customer", "order", "shipping", "payment"], submitOrder);
    paymentForm.addElement(emailAddress, "customer");
    paymentForm.addElement(shippingMethod, "shipping");    
    paymentForm.addElements(new <IFormElement>[ creditCardNumber, expMonth, expYear], "payment");
    paymentForm.addHiddenElements(
      new <Object>[ 
        { "name":"id", "value":"" },
        { "name":"subtotal", "value":0 },
        { "name":"taxTotal", "value":0 },
        { "name":"feeTotal", "value":0 },
        { "name":"shippingTotal", "value":0 },
        { "name":"total", "value":0 },
      ], "order");

Manage a form, and listen for responses:

    formManager.success.add(submitSuccess);
    formManager.submissionError.add(submitError);
    formManager.validationError.add(submitInvalid);
    formManager.manageForm(paymentForm);
    
    private function submitSuccess(form:IForm, data:String):void {
      var response:Object = JSON.decode(data);
    }
    
    private function submitError(form:IForm, error:String):void {
      trace (error);
    }
    		
    private function submitInvalid(errors:Vector.<IValidationError>):void {
      for each (var error:IValidationError in errors) {
        trace (error.message);
      }
    }