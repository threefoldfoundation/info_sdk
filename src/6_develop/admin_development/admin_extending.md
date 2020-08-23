# Admin dashboard

Admin dashboard UI based on [vue.js](https://vuejs.org/).


## Development

While development, 3Bot needs to be started with this package installed,then you can go to `http://<host>/admin`.


## Structure

The code for the admin dashboard is all defined in the frontend directory of the admin package. The structure includes the following:
* ```index.js``` where the main components are added by including them from the components/ directory
* ```api.js``` is the api client which includes all endpoints calling the backend/actors
* ```app.vue``` is included in `index.js` and is the main view of the admin dashboard
* `components/` includes all the other vue components included in the admin dashboard
* `components/external/` include external vue components such as codeserver, farm management, and notebooks


## Walkthrough of creating a new component

### The vue component

The component itself is defined in the `/components` directory. We will use the alerts component as an example. 

The component consists mainly of 2 items, the template itself and the script where any processing or api client calls are done.
- Template
 ```html
 <template>
 <div>
  <base-component title="Alerts" icon="mdi-alert-outline" :loading="loading">
  <template #actions>
   <v-btn color="primary" text @click.stop="dialogs.delete = true">
   <v-icon left>mdi-delete-sweep</v-icon> Delete All
   </v-btn>
  </template>

  <template #default>
   <v-data-table class="elevation-1" :loading="loading" :headers="headers" :items="data">
   
   <template v-slot:item.id="{ item }">
    <a @click="open(item)">{{ item.id }}</a>
   </template>
   
   <template v-slot:item.message="{ item }">
    {{ item.message.slice(0, 50) }} {{ item.message.length > 50 ? '...' : ''}}
   </template>

   <template v-slot:item.last_occurrence="{ item }">
    {{ new Date(item.last_occurrence * 1000).toLocaleString() }}
   </template>

   <template v-slot:body.prepend="{ headers }">
   <tr>
    <td>
    <v-text-field v-model="filters.id" clearable filled hide-details dense></v-text-field>
    </td>
    <td>
    <v-select v-model="filters.appname" :items="apps" clearable filled hide-details dense></v-select>
    </td>
    <td></td>
    <td>
    <v-select v-model="filters.type" :items="types" clearable filled hide-details dense></v-select>
    </td>
    <td>
    <v-text-field v-model="filters.category" clearable filled hide-details dense></v-text-field>
    </td>
    <td>
    <v-select v-model="filters.status" :items="states" clearable filled hide-details dense></v-select>
    </td>
    <td>
    <v-text-field v-model="filters.count" clearable filled hide-details dense></v-text-field>
    </td>
    <td>
    <v-text-field v-model="filters.message" clearable filled hide-details dense></v-text-field>
    </td>
   </tr>
   </template>

   </v-data-table>
  </template>
  </base-component>

  <show-alert v-if="selected" v-model="dialogs.show" :alert="selected"></show-alert>
  <delete-alerts v-model="dialogs.delete" @done="getAlerts"></delete-alerts>
 </div>
 </template>

 ```

- Script

 Other components can also be included here from the script such as the single `Alert.vue` and the `Delete.vue`.
 ```javascript
 <script>
 module.exports = {
  components: {
  'show-alert': httpVueLoader("./Alert.vue"),
  'delete-alerts': httpVueLoader("./Delete.vue")
  },
  data () {
  return {
   appname: "init",
   apps: [],
   alerts: [],
   selected: null,
   dialogs: {
   show: false,
   delete: false
   },
   loading: false,
   levels: LEVELS,
   types: TYPES,
   states: STATES,
   filters: {
   id: null,
   appname: null,
   type: null,
   category: null,
   status: null,
   count: null,
   message: null,
   },
   headers: [
   {text: "Id", value: "id"},
   {text: "Application", value: "appname"},
   {text: "Last Occurrence", value: "last_occurrence"},
   {text: "Type", value: "type"},
   {text: "Category", value: "category"},
   {text: "Status", value: "status"},
   {text: "Count", value: "count"},
   {text: "Message", value: "message"}
   ]
  }
  },
  computed: {
  data () {
   return this.alerts.filter((record) => {
   let result = []
   Object.keys(this.filters).forEach(key => {
    result.push(!this.filters[key] || String(record[key]).includes(this.filters[key]))
   })
   return result.every(Boolean)
   })
  }
  },
  methods: {
  open (record) {
   this.selected = record
   this.dialogs.show = true
  },
  getApps () {
   this.$api.logs.listApps().then((response) => {
   this.apps = JSON.parse(response.data).data
   })
  },
  getAlerts () {
   this.loading = true
   this.$api.alerts.listAlerts(this.appname).then((response) => {
   this.alerts = JSON.parse(response.data).data
   }).finally(() => {
   this.loading = false
   })
  }
  },
  mounted () {
  this.getApps()
  this.getAlerts()
  }
 }
 </script>
 ```


### Add actor calls to api client
Add the methods being called in the component to retrieve/post data to the api endpoint of the actor. This can be done by adding it to the apiclient in `api.js`
```javascript
alerts: {
listAlerts: () => {
 return axios({
 url: `${baseURL}/alerts/list_alerts`,
 method: "post",
 headers: { 'Content-Type': 'application/json' }
 })
},
deleteAll: () => {
 return axios({
 url: `${baseURL}/alerts/delete_all_alerts`,
 method: "post",
 })
}
}

```
### Include the component to sidebar
To include the previously created components into the dashboard the following is added in `index.js` taking into consideration the route is added to the existing router and a new router isn't created.
```javascript
const alerts = httpVueLoader('./components/alerts/Alerts.vue')

const router = new VueRouter({
 routes: [
 { name: "Alerts", path: '/alerts', component: alerts, meta: { icon: "mdi-alert-outline", listed: true } },
 ]
})

``` 

