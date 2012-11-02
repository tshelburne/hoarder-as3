﻿/* * This file is part of the FormManager package. * * @author (c) Tim Shelburne <tim@dontlookstudios.com> * * For the full copyright and license information, please view the LICENSE * file that was distributed with this source code. */package dls.formmanager.validator {		import dls.formmanager.form.IForm;	import dls.formmanager.form.IFormElement;	import dls.formmanager.validator.errors.IValidationError;		public interface IFormValidator {		function validateElement(element:IFormElement):Vector.<IValidationError>;				function validateForm(form:IForm):Vector.<IValidationError>;			}	}