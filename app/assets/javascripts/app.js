/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#app',
    data: {
      leads: [],
      time_format: "12/25/17",
      url: "https://www.google.com/",
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
