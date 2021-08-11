# Chatflows


Chatflows are an interactive communication bot that could be used to interactively ask the user some questions then perform actions based on the user's choices. Think of serving a customer, handling invoices, buying items or in our case provisioning workloads on the grid.

## Create a new Chatflow

It's very easy to define a new bot, you just need to make sure it's added in a package and that package is installed with 3Bot server. The chatflow should be under the `/chats` directory in the package created.

### Main Features
Each chatflow should include these :
- `steps` list:
 It includes the names of the functions of the chatflow steps in the chatflow that will be appearing.
- `chatflow_step` decorator:
 Every step function included in the steps list should have this decorator imported using `from jumpscale.sals.chatflows.chatflows import chatflow_step`. If a custom name is to be added for a step, it could be given as a parameter to the decorator function.
- Title:
 `title ` (optional) parameter will display a custom title for the chatflow.

### Custom Features

A chatflow could include some custom features which are optional. These features could be activated by providing the corresponding parameter to the `chatflow_step` decorator that is added for each chatflow step

- disable_previous:
 If set to **True**, the previous button is deactivated and going to any previous step is no longer possible
- final_step:
 Is set to **True** for the final step to reset the chatflow after reaching the last step when revisiting it in the same session

### Available question types for user inputs:

- string_ask
- secret_ask
- int_ask
- text_ask
- single_choice
- multi_choice
- multi_list_choice
- drop_down_choice
- autocomplete_drop_down
- datetime_picker
- time_delta_ask
- download_file
- upload_file
- qrcode_show
- captcha_ask
- md_show
- md_show_confirm
- loading_show
- multi_values_ask


## Example 1

### Example code
Here is an example for a simple chatflow that will help you order a meal from one of your favorite restaurants

```python
from jumpscale.loader import j
from jumpscale.sals.chatflows.chatflows import GedisChatBot, chatflow_step


class FoodChat(GedisChatBot):
 # Sample data
 menus = {
  "3 Burger": {"main": ["Cheese Burger", "Douple Burger"], "sides": ["fries", "Onion rings"]},
  "3 Pizza": {"main": ["Chicken Pizza", "Beef Pizza", "Cheese Pizza"], "sides": ["fries", "Cheese"]},
 }
 # title = "Food Chatflow"
 steps = ["client_name_select", "restaurant_select", "restaurant_main_dish", "restaurant_side_dish", "confirmation"]
 title = 'Food Chat'

 @chatflow_step("Name")
 def client_name_select(self):
  # Ask the user about his name
  self.client_name = self.string_ask("Hello, What's your name?", required=True)

 @chatflow_step("Restaurant")
 def restaurant_select(self):
  # display a dropdown containing your favourite Restaurants
  self.restaurant_name = self.drop_down_choice("Please select a Resturant", list(self.menus.keys()))

 @chatflow_step("Main Dish")
 def restaurant_main_dish(self):
  # display the main dishes of the selected restaurant so the user could choose only one dish
  self.main_dish = self.single_choice("Please Select your main dish", self.menus[self.restaurant_name]["main"])

  # ask about the mount (this accepts any integer)
  self.amount = self.int_ask("How many {} do you want".format(self.main_dish))

 @chatflow_step("Side Dish")
 def restaurant_side_dish(self):
  # ask about the side dishes (the user could choose multible side dishes)
  self.side_dish = self.multi_choice(
   "what do you want with your order", self.menus[self.restaurant_name]["sides"]
  )

 @chatflow_step(title="Confirmation", disable_previous=True, final_step=True)
 def confirmation(self):
  # Now you could add any logic you want here to send the order to the restaurant
  # Then we could show a report to the user about his order using md format
  report = f"""# Hello {self.client_name}
## Your order has been confirmed \n\n<br>\n
### You have ordered : {self.amount} {self.main_dish} with {self.side_dish}
  """

  self.md_show(report, md=True)


chat = FoodChat

```

### Usage example for previous code
<!-- # TODO Describe chatflows more include step configurations like last step and previous-->

Here's how the previously created chatflow will look like

- Asking what the user's name is as string `string_ask`
![Chat Flow1](img/chat1.png)

- Asking what restaurant the user wants from a list of options using `drop_down_choice`
![Chat Flow2](img/chat2.png)

- Asking what main dish the user will be having from a list of options using `single_choice`
![Chat Flow3](img/chat3.png)

- Asking about the amount of the main dish to be ordered using `int_ask`
![Chat Flow4](img/chat4.png)

- Asking about one or more side dishes to be ordered with the main dish using `multi_choice`
![Chat Flow5](img/chat5.png)

- Showing final results using md_show
![Chat Flow6](img/chat6.png)


## Example 2

### Example code
Here is an example for a simple chatflow that will assist a team to plan a meeting.

```python
from jumpscale.loader import j
from jumpscale.sals.chatflows.chatflows import GedisChatBot, chatflow_step


class MeetingPlan(GedisChatBot):

    # Chatflow steps
    steps = ["description_step", "scheduling_step", "documents_step", "confirmation"]

    # Chatflow title
    title = "Meeting Plan"

    @chatflow_step("Welcome")
    def description_step(self):
        if not j.core.config.get("MeetingLocation"):
            j.core.config.set("MeetingLocation", {"Belgium": [], "Spain": [], "Egypt": []})

        self.logged_in_user = self.user_info()
        self.username = self.logged_in_user["username"]
        email = self.logged_in_user["email"]
        self.md_show(
            f"Welcome {self.username} to the meeting planner! This platform will be used to plan and gather required information for the next meeting.",
            required=True,
        )

    @chatflow_step("Meeting Scheduling")
    def scheduling_step(self):
        form = self.new_form()
        chosen_time = form.datetime_picker(
            "When do you prefer the meeting to take place?", default=j.data.time.get().timestamp, required=True
        )
        place = form.drop_down_choice(
            "Where do you prefer the meeting to be held?", ["Belgium", "Spain", "Egypt"], required=True
        )
        form.ask()
        self.meeting_time = int(chosen_time.value)
        self.meeting_place = place.value

    @chatflow_step("Relevant Document")
    def documents_step(self):
        self.documents = self.upload_file(
            """Please add any relevant document or notes that will be used in the meeting
                    Just upload the file with the key""",
            required=True,
        )

    @chatflow_step(title="Confirmation", disable_previous=True, final_step=True)
    def confirmation(self):
        meetingLocationData = j.core.config.get("MeetingLocation")
        if self.username not in meetingLocationData[self.meeting_place]:
            meetingLocationData[self.meeting_place].append(self.username)
            j.core.config.set("MeetingLocation", meetingLocationData)
        bedata = ",".join(meetingLocationData["Belgium"])
        egdata = ",".join(meetingLocationData["Egypt"])
        spdata = ",".join(meetingLocationData["Spain"])
        report = f"""# Hello {self.username}
## You have successfully submitted a response \n\n<br>\n
- You prefer the meeting to be held on {j.data.time.get(self.meeting_time).format()} in {self.meeting_place}
- You have attached the following to be used as meeting notes:
{self.documents} \n\n<br>\n


## The votes for the locations are: \n\n<br>\n

- Belgium   : {bedata}
- Egypt     : {egdata}
- Spain     : {spdata}
        """

        self.md_show(report, md=True)


chat = MeetingPlan

```
