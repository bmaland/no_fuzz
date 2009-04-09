require File.dirname(__FILE__) + '/test_helper.rb'

class NoFuzzTest < ActiveSupport::TestCase

  load_schema

  class PackageTrigram < ActiveRecord::Base
  end

  class Package < ActiveRecord::Base
    include NoFuzz

    fuzzy :name
  end

  def test_populating_and_deleting_trigram_index
    Package.create!(:name => "abcdef")
    Package.populate_trigram_index
    assert_equal 5, PackageTrigram.count
    Package.clear_trigram_index
    assert_equal 0, PackageTrigram.count
  end

end
