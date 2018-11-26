/**
 * This function checks if the values of the attributes and confirm-attributes are same.
 *
 * @return {boolean} Returns true if everything is ok. Otherwise, returns false.
 */
function confirmUserInfo() {
    let element = document.getElementById('hidden_div').childNodes[0];

    if (element) {
        document.getElementById('hidden_div').removeChild(element);
    }

    let password = document.getElementById('password').value;
    let confirmedPassword = document.getElementById('confirm-password').value;

    if (password !== confirmedPassword) {

        makeNewElement('Please recheck the password and confirm-password.', 'passwordDiv');
        return false;

    }

    let birthday = document.getElementById('birthday').value;
    const alertMessage = 'Birthday format: YYYY-MM-DD';

    if (birthday.includes('-')) {
        birthday = birthday.split('-');

        if (birthday.length != 3) {
            alert(alertMessage);
            return false;
        } else {
            if (birthday[0].length != 4 || birthday[1].length != 2 || birthday[2].length != 2) {
                alert(alertMessage);
                return false;
            }
        }
    } else {
        alert(alertMessage);
        return false;
    }

    return true;
}

/**
 * This function makes the new div tag to display the warning message, and appends it to the register page.
 *
 * @param text The warning message to display on the web page
 */
function makeNewElement(text) {
    if (document.getElementById(id)) {
        return;
    }
    let newDiv = document.createElement('div');
    newDiv.innerText = text;
    newDiv.style.color = 'red';
    newDiv.style.fontSize = '3vmin';

    document.getElementById('hidden_div').appendChild(newDiv);
}