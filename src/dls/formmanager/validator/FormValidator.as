﻿/* * This file is part of the FormManager package. * * @author (c) Tim Shelburne <tim@dontlookstudios.com> * * For the full copyright and license information, please view the LICENSE * file that was distributed with this source code. */ package dls.formmanager.validator {	 	import dls.debugger.Debug;	 	import dls.formmanager.form.IForm;	import dls.formmanager.form.IFormElement;	import dls.formmanager.validator.IFormValidator;	import dls.formmanager.validator.constraints.IConstraint;	import dls.formmanager.validator.errors.IValidationError;		/*	 * A class to handle basic validation of forms.	 */	public class FormValidator implements IFormValidator {				/*=========================================================*		 * PROPERTIES		 *=========================================================*/				private var _debugOptions:Object = { "source" : "FormManager (FormValidator)" };		 		private var _constraints:Vector.<IConstraint>;				/*=========================================================*		 * FUNCTIONS		 *=========================================================*/		public function FormValidator(constraints:Vector.<IConstraint>) {			_constraints = constraints;		}				/**		 * loop through the validation rules of the element and test it against the list of constraints 		 * available in the manager		 */		public function validateElement(element:IFormElement):Vector.<IValidationError> {			var errors:Vector.<IValidationError> = new <IValidationError>[];						for (var rule:String in element.validationRules) {				Debug.out("Validating element " + element.name + " with " + rule + " rule...", Debug.DEBUG, _debugOptions);				var constraintFound:Boolean = false;				for each (var constraint:IConstraint in _constraints) {					if (constraint.shouldHandle(rule)) {						constraintFound = true;						errors = errors.concat(constraint.validate(element));						break;					}				}								if (!constraintFound) {					throw new Error("There is no '" + rule + "' constraint available.");				}			}						return errors;		}				/**		 * loop through all elements in the form and validate them individually		 */		public function validateForm(form:IForm):Vector.<IValidationError> {			var errors:Vector.<IValidationError> = new <IValidationError>[];						for each (var element:IFormElement in form.allElements) {				errors = errors.concat(validateElement(element));			}						return errors;		}	}	}