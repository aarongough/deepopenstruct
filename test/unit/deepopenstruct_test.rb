require 'test_helper'

class TestDeepOpenStruct < Test::Unit::TestCase
  
  test "should convert hash into openstruct" do
    hash = {:item_1 => 1, 'item_2' => 2, "item_3" => 3}
    assert_nothing_raised do
      deepstruct = DeepOpenStruct.load(hash)
      assert_equal 1, deepstruct.item_1
      assert_equal 2, deepstruct.item_2
      assert_equal 3, deepstruct.item_3
    end
  end
  
  test "should convert array of hashes into array of openstructs" do
    array = [{:hash_1 => 1}, {:hash_2 => 2}, {:hash_3 => 3}]
    assert_nothing_raised do
      deepstruct = DeepOpenStruct.load(array)
      assert_equal 1, deepstruct[0].hash_1
      assert_equal 2, deepstruct[1].hash_2
      assert_equal 3, deepstruct[2].hash_3
    end
  end
  
  test "should convert nested hash into nested openstruct" do
    hash = {:hash_1 => {:foo => :blah}, :hash_2 => {:foo => :blah, :deep_nest => {:foo => :blah}}}
    assert_nothing_raised do
      deepstruct = DeepOpenStruct.load(hash)
      assert_equal :blah, deepstruct.hash_1.foo
      assert_equal :blah, deepstruct.hash_2.foo
      assert_equal :blah, deepstruct.hash_2.deep_nest.foo
    end
  end
  
  test "should convert arrays of hashes in hash into arrays of openstructs" do
    hash = {:array => [1, 2, {:foo => :blah, :array => [3, 4, {:see => :more}]}]}
    assert_nothing_raised do
      deepstruct = DeepOpenStruct.load(hash)
      assert_kind_of Array, deepstruct.array
      assert_equal 1, deepstruct.array[0]
      assert_equal 2, deepstruct.array[1]
      assert_kind_of OpenStruct, deepstruct.array[2]
      assert_equal :blah, deepstruct.array[2].foo
      assert_kind_of Array, deepstruct.array[2].array
      assert_equal 3, deepstruct.array[2].array[0]
      assert_equal 4, deepstruct.array[2].array[1]
      assert_kind_of OpenStruct, deepstruct.array[2].array[2]
      assert_equal :more, deepstruct.array[2].array[2].see
    end      
  end
  
  test "should raise ArgumentError if argument supplied to initialize is not a Hash or Array" do
    [1, "hello", 3.00, OpenStruct.new({:blah => :foo})].each do |item|
      assert_raises ArgumentError, "should have raised error when initialized with #{item.class}" do
        test = DeepOpenStruct.load(item)
      end
    end
  end
  
  test "should not not create side effects on array" do
    array = [{:hash_1 => 1}, {:hash_2 => 2}, {:hash_3 => 3}]
    deepstruct = DeepOpenStruct.load(array)
    assert_kind_of Hash, array[0]
  end
  
  test "should not not create side effects on hash" do
    hash = {:array => [1, 2, {:foo => :blah, :array => [3, 4, {:see => :more}]}]}
    deepstruct = DeepOpenStruct.load(hash)
    assert_kind_of Hash, hash[:array][2]
    assert_kind_of Hash, hash[:array][2][:array][2]
  end
  
  test "should allow overriding of :id" do
    hash = {:id => "blah"}
    deepstruct = DeepOpenStruct.load(hash)
    assert_equal "blah", deepstruct.id
  end
  
  test "should allow overriding of :type" do
    hash = {:type => "blah"}
    deepstruct = DeepOpenStruct.load(hash)
    assert_equal "blah", deepstruct.type
  end
  
end
