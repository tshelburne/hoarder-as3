/*
* This file is part of the FormManager package.
*
* @author (c) Tim Shelburne <tim@dontlookstudios.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/
package dls.formmanager.validator.constraints {
	
	import dls.formmanager.form.IFormElement;
	import dls.formmanager.validator.errors.IValidationError;
	import dls.formmanager.validator.errors.ValidationError;
	
	
	/*
	* checks that a form element's value contains only alpha characters
	*/
	public class AlphaConstraint implements IConstraint {
		
		public function shouldHandle(klass:String):Boolean{
			return klass == "alpha";
		}
		
		public function validate(element:IFormElement):Vector.<IValidationError> {
			var errors:Vector.<IValidationError> = new <IValidationError>[];
			
			if (element.value is String) {
				if (!(element.value as String).match(/^[a-zA-Z]*$/)) {
					errors.push(new ValidationError(element, "Only characters (A-Z) are allowed for this field."));
				}
			}
			else {
				errors.push(new ValidationError(element, "Value must be a string."));
			}
			
			return errors;
		}
	}
}