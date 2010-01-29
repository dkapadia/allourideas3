class AddAttachmentsLogoToEarl < ActiveRecord::Migration
  def self.up
    add_column :earls, :logo_file_name, :string
    add_column :earls, :logo_content_type, :string
    add_column :earls, :logo_file_size, :integer
    add_column :earls, :logo_updated_at, :datetime
  end

  def self.down
    remove_column :earls, :logo_file_name
    remove_column :earls, :logo_content_type
    remove_column :earls, :logo_file_size
    remove_column :earls, :logo_updated_at
  end
end
