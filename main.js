const password = document.getElementById("enterPassword");

function setFormMessage(formElement, type, message) {
    const messageElement = formElement.querySelector(".form__message");

    messageElement.textContent = message;
    messageElement.classList.remove("form__message--success", "form__message--error");
    messageElement.classList.add(`form__message--${type}`);
}

function setInputError(inputElement, message){
    inputElement.classList.add("form__input--error");
    inputElement.parentElement.querySelector(".form__input-error-message").textContent = message;
}

function clearInputError(inputElement) {
    inputElement.classList.remove("form__input--error");
    inputElement.parentElement.querySelector(".form__input-error-message").textContent = "";
}

//setFormMessage(loginForm, "success", "You're logged in!");

document.addEventListener("DOMContentLoaded", () =>{
    const loginForm = document.querySelector("#login");
    const createAccountForm = document.querySelector("#createAccount");

    document.querySelector("#linkCreateAccount").addEventListener("click", e => {
        e.preventDefault();
        loginForm.classList.add("form--hidden");
        createAccountForm.classList.remove("form--hidden");

    })

    document.querySelector("#linkLogin").addEventListener("click", e => {
        e.preventDefault();
        loginForm.classList.remove("form--hidden");
        createAccountForm.classList.add("form--hidden");

    })

    loginForm.addEventListener("submit", e => {
        e.preventDefault();

        // Perform AJAX/Fetch login here

        setFormMessage(loginForm, "error", "Invalid username/password comnbination");
    })

    document.querySelectorAll(".form__input").forEach(inputElement =>{

        inputElement.addEventListener("blur", e =>{
            if (e.target.id === "signupUsername" && e.target.value.length > 0 && e.target.value.length < 6){
                setInputError(inputElement, "Username must be at least 6 characters in length");
            }
        });

        inputElement.addEventListener("blur", e => {
            if(e.target.id === "emailAddress" && !e.target.value.includes("@")){
                setInputError(inputElement, "Enter a valid email");
            }
        })

        inputElement.addEventListener("blur", e => {
            if(e.target.id === "enterPassword") {
                const password = e.target.value;
                const minLength = 8;
                const hasNumber = /\d/;
                const hasSpecialChar = /[!@#$%^&*()<>,.?":{}|]/;
                const hasCapitalLetter = /[A-Z]/;

                if (password.length >= minLength &&
                    hasNumber.test(password) &&
                    hasCapitalLetter.test(password)&&
                    hasSpecialChar.test(password)) {
                        console.log("Password is valid!")
                    } else {
                        setInputError(inputElement, "Password must have a capital letter, special character and a number");
                    }
            }
        })

        inputElement.addEventListener("blur", e => {
            if (e.target.id === "confirmPassword"){
                if(e.target.value !== password.value)
                    setInputError(inputElement, "Password does not match");
            }
        })

        inputElement.addEventListener("input", e => {
            clearInputError(inputElement);
        })
    });

// Send the contact us form to our email
    document.addEventListener("DOMContentLoaded", function() {
        const contactForm = document.querySelector("#contact-form");
        if (contactForm){
            contactForm.addEventListener("submit", handleSubmit);
        }
    });

    function validateForm() {
        const name = document.querySelector("#contact-form input[name='name']").value.trim();
        const email = document.querySelector("#contact-form input[name='email']").value.trim();
        const message = document.querySelector("#contact-form textarea[name='message']").value.trim();
    
        if (!name || !email || !message) {
            return false;
        }
        return true;
    }

    function handleSubmit (event) {
        event.preventDefault();

        if (!validateForm()) {
            displayErrorMessage("Please fill in all fields.");
            return;
        }

        const name = document.querySelector("#contact-form input[name='name']").value;
        const email = document.querySelector("#contact-form input[name='email']").value;
        const message = document.querySelector("#contact-form textarea[name='message']").value;

        sendEmail(name, email, message);
    }

    function displayErrorMessage(message) {
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.textContent = message;
        errorDiv.style.color = 'red';
        errorDiv.style.marginBottom = '10px';
    
        const form = document.querySelector("#contact-form");
        form.insertBefore(errorDiv, form.firstChild);
    
        // Remove the error message after 3 seconds
        setTimeout(() => {
            errorDiv.remove();
        }, 3000);
    }

    function sendEmail(name, email, message) {
    // ISend this data to a server
    // For demonstration, I am a mock API call
        fetch('/api/send-email', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                name: name,
                email: email,
                message: message,
                to: "furreverhome@gmail.com"
            }),
        })
        .then(response => response.json())
        .then(data => {
            alert('Message sent successfully!');
            document.querySelector("#contact-form").reset();
        })
        .catch((error) => {
            console.error('Error:', error);
            alert('An error occurred. Please try again later.');
        });
    }
});
