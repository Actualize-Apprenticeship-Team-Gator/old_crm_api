/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
      leads: [],
      time_format: "12/25/17",
      url: "https://www.google.com/",
      leadIdToShow: -1
      searchTermFilter: "",
      errors: []
    },
    mounted: function() {
      $.get('/api/v1/leads.json').success(function(response) {
        console.log(this);
        this.leads = response;
      }.bind(this));
    },
    methods: {
      moment: function(date) {
        return moment(date);
      },
       toggleLeadData: function(leadInput) {
-        this.leadIdToShow = leadInput.id;
-        console.log("this.leadIdToShow", this.leadIdToShow)
-        // newLead.show_data = !newLead.show_data;
-      },
      isValidPerson: function(inputPerson) {
        var validFirstName = inputPerson.first_name.toLowerCase().indexOf(this.searchTermFilter.toLowerCase()) !== -1;
        var validLastName = inputPerson.last_name.toLowerCase().indexOf(this.searchTermFilter.toLowerCase()) !== -1;
        var validEmail = inputPerson.email.toLowerCase().indexOf(this.searchTermFilter.toLowerCase()) !== -1;
        return validFirstName || validLastName || validEmail;
      },
    },
    computed: {

    },
  });
});
