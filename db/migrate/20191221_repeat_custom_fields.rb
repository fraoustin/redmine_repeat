class ReapeatCustomFields < ActiveRecord::Migration[4.2]
    # method called when installing the plugin
    def self.up
      if IssueCustomField.find_by_name('repeat').nil?
        repeat = IssueCustomField.create!(:name => 'repeat', :field_format => 'int',
                                       :default_value => '0',
                                       :is_for_all => true, :trackers => Tracker.all)
      
      end
    end
  
    # method called when installing the plugin
    def self.down
      IssueCustomField.find_by_name('repeat').delete unless IssueCustomField.find_by_name('repeat').nil?
    end
end