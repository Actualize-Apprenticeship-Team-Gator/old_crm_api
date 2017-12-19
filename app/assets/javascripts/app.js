/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: '#app',
    data: {
      leads: [],
      time_format: "12/25/17",
      url: "https://www.google.com/",
      leadIdToShow: -1,
      sortAttribute: 'created_at',
      ascending: true
    },
    mounted: function() {
      $.get('/api/v1/leads.json').success(function(response) {
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
      },
      updateSortAttribute: function(sortAttribute) {
        if (this.sortAttribute === sortAttribute) {
          this.ascending = !this.ascending;
        } else {
          this.ascending = true;
          this.sortAttribute = sortAttribute;
        }
      }
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
