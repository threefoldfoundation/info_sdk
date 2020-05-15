# Chat bot

Chat now is a part of webinterface package.

- `static/chat`: has the static assets for the chat
- `templates/chat`: templates used by bottle server to generate the UI


## Available actors


### Getting available chatflows

[chatbot actor](https://github.com/threefoldtech/jumpscaleX_threebot/blob/development/ThreeBotPackages/zerobot/webinterface/actors/chatbot.py) is available as part of base actors

```python


def _get_chatflows():
    gedis_client = j.clients.gedis.get("chat", port=8901, package_name="zerobot.webinterface")
    chatflows = gedis_client.actors.chatbot.chatflows_list()
    return [chatflow.decode() for chatflow in chatflows]
```


### Creating a new session

For every chatflow `topic` you need to create a session using `session_new` actor command and it returns a session id

### Getting questions from the chatbot

Retrieving the current active question from chatbot is done using `work_get` on a session to get a question dict


### Pushing answers
Pushing answers to chatbot on the last question is done using `work_report`





### GedisChatBot
Has all of the implementation details of getting questions, pushing questions, queues, also it's responsible for the primitive question types `int_ask`, `string_ask`, `captcha_ask`, `multi_choice`, `single_choice`, `drop_down_choice` , `autocomplete_drop_down`.</br>
These question types are used to allow for taking different types of input from the user going through the chatflow.

Example for chatflow:

```python
def chat(bot):
    res = {}

    country = bot.drop_down_country("where do you want to eat?")
    food = bot.string_ask("What do you need to eat?")
    amount = bot.int_ask("Enter the amount you need to eat from %s in grams:" % food)
    sides = bot.multi_choice("Choose your side dishes: ", ["rice", "fries", "saute", "mashed potato"])
    drink = bot.single_choice("Choose your Drink: ", ["tea", "coffee", "lemon"])

    res = """
    # country {{country}}

    # You have ordered:
    - {{amount}} grams,sides {{sides}} and {{drink}} drink
    ### Click next
    for the final step which will redirect you to threefold.me
    """
    bot.template_render(res, **locals())
```

#### Validation

Some validations can be applied on the input taken from the user so that they are warned. This is helpful to validate certain restrictions before processing the data itself in the server. Here's an example of validations required for a string input

```python
    email = bot.string_ask("Enter email", validate={"required": True, "email": True}).strip()
```

### Implementing another question type

- add the new question to `GedisChatBot.py`
- update `bot_client.js`


#### Example: Adding captcha question

##### Step 1 : Updating GedisChatBot.py

```python
    def captcha_ask(self, error=False, **kwargs):
        """
        helper method to generate a captcha and verify that the user entered the right answer.
        :param error: if True indicates that the previous captcha attempt failed
        :return: a bool indicating if the user entered the right answer or not
        """
        image = ImageCaptcha()
        captcha = j.data.idgenerator.generateXCharID(4)
        # this log is for development purposes so we can use the redis client
        self._log_info("generated captcha:%s" % captcha)
        data = image.generate(captcha)
        self.q_out.put(
            {
                "cat": "captcha_ask",
                "captcha": base64.b64encode(data.read()).decode(),
                "msg": "Are you human?",
                "label": "Please enter a valid captcha" if error else "",
                "kwargs": kwargs,
            }
        )
        return self.q_in.get() == captcha
```

#### Step 2: Write Content Generator Function

Now that when we get the `captcha question dict` from the previous step we would want to render it. So let's define the content generator for captcha

```javascript

var captchaContentGenerate = function (message, captcha, label, kwargs) {
    return `
    <h4>${message}</h4>
    <img src="data:image/png;base64,${captcha}"/>
    <div class="form-group">
        <input type="text" placeholder="Captcha" class="form-control" id="value">
    </div>
    <label class="captcha-error">${label}</label>`
}
```

#### Step 3: Update generateSlide
in the last step we will have to render the incoming question dict using our content renderer function `captchaContentGenerate`

```javascript

var generateSlide = function (res) {
    // CODE OMITTED...
    let contents = "";
    switch (res['cat']) {
        // CODE OMITTED
        case "captcha_ask":
            contents = captchaContentGenerate(res['msg'], res['captcha'], res['label'], res['kwargs']);
            break;

```



## How GedisChatBot Works

[GedisChatBot](https://github.com/threefoldtech/jumpscaleX_core/blob/development/JumpscaleCore/servers/gedis/GedisChatBot.py) is the one responsible for creating sessions and keeping track of them and of the loaded chatflows, and also for getting questions to a certain session by `session_id` `session_work_get` and receiving user's answer and giving it to a certain session by `session_id`

### Session

Every session object maintains two queues
- queue input: to push responses from the user (typically the browser)
- queue out: to push questions to the user (typically the browser)

Also, session contains helpers to properly format `question dict` to be pushed in questions queue


#### Question Dict format

Here's an example for asking for a password

```python
    def secret_ask(self, msg, **kwargs):
        """
        helper method to generate a question that expects a password answer.
        html generated in the client side will use `<input type="password"/>`
        :param msg: the question message
        :param kwargs: dict of possible extra options like (validate, reset, ...etc)
        :return: the user answer for the question
        """
        self.q_out.put({"cat": "secret_ask", "msg": msg, "kwargs": kwargs})
        return self.q_in.get()

```
- cat: used in frontend `bot_client.js` to generate the suitable slide
- msg: question message
- kwargs can be used for validations or any extra options to your content renderer function
