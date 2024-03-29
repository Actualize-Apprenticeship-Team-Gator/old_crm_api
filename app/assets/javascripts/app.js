/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: '#app',
    data: {
      leads: [],
      time_format: "12/25/17",
      url: "https://www.google.com/",
      leadIdToShow: -1,
      sortAttribute: 'updated_at',
      ascending: false,
      searchTermFilter: ""
    },
    mounted: function() {
      $.get('/api/v1/leads.json').success(function(response) {
        this.leads = response;
      }.bind(this));
    },
    methods: {
      moment: function(date) {
        return moment(date);
      },
      updateSortAttribute: function(sortAttribute) {
        if (this.sortAttribute === sortAttribute) {
          this.ascending = !this.ascending;
        } else {
          this.ascending = true;
          this.sortAttribute = sortAttribute;
        }
      },
      toggleLeadData: function(leadInput) {
        this.leadIdToShow = leadInput.id;
        console.log("this.leadIdToShow", this.leadIdToShow)
        // newLead.show_data = !newLead.show_data;
      },
      isValidPerson: function(inputPerson) {
        var validFirstName = inputPerson.first_name.toLowerCase().indexOf(this.searchTermFilter.toLowerCase()) !== -1;
        var validLastName = inputPerson.last_name.toLowerCase().indexOf(this.searchTermFilter.toLowerCase()) !== -1;
        var validEmail = inputPerson.email.toLowerCase().indexOf(this.searchTermFilter.toLowerCase()) !== -1;
        return validFirstName || validLastName || validEmail;
      },
    },
    computed: {
      sortedLeads: function() {
        return this.leads.sort(function(a, b) {
          if (this.ascending) {
            return a[this.sortAttribute].localeCompare(b[this.sortAttribute])
          } else {
            return b[this.sortAttribute].localeCompare(a[this.sortAttribute])
          }
        }.bind(this))
      }
    },
  });
});
