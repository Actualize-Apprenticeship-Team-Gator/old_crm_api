/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: '#app',
    data: {
      leads: [],
      time_format: "12/25/17",
      url: "https://www.google.com/",
      leadIdToShow: -1
    },
    mounted: function() {
      $.get('/api/v1/leads.json').success(function(response) {
        console.log(this);
        this.leads = response;
        // Currently trying to do this in the controller instead
        // for(let lead of this.leads) {
        //   console.log("lead...", lead)
        //   lead.show_data = false;

        // }
      }.bind(this));
    },
    methods: {
      moment: function(date) {
        return moment(date);
      },
      toggleLeadData: function(leadInput) {
        this.leadIdToShow = leadInput.id;
        console.log("this.leadIdToShow", this.leadIdToShow)
        // newLead.show_data = !newLead.show_data;
      }
    },
    computed: {

    },
  });
});
