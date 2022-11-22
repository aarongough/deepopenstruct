# frozen_string_literal: true

require 'spec_helper'

describe DeepOpenStruct do
  it 'converts hash into openstruct' do
    hash = {item1: 1, item2: 2, 'item3': 3}
    deepstruct = DeepOpenStruct.load(hash)

    expect(deepstruct.item1).to eq(1)
    expect(deepstruct.item2).to eq(2)
    expect(deepstruct.item3).to eq(3)
  end

  it 'converts array of hashes into array of openstructs' do
    array = [{hash1: 1}, {hash2: 2}, {hash3: 3}]
    deepstruct = DeepOpenStruct.load(array)

    expect(deepstruct[0].hash1).to eq(1)
    expect(deepstruct[1].hash2).to eq(2)
    expect(deepstruct[2].hash3).to eq(3)
  end

  it 'converts nested hash into nested openstruct' do
    nested_hash = { hash1: { foo: :blah1 }, hash2: { foo: :blah2, deep_nest: { foo: :blah3 } } }
    deepstruct = DeepOpenStruct.load(nested_hash)

    expect(deepstruct.hash1.foo).to eq(:blah1)
    expect(deepstruct.hash2.foo).to eq(:blah2)
    expect(deepstruct.hash2.deep_nest.foo).to eq(:blah3)
  end

  it 'converts arrays of hashes in hash into arrays of openstructs' do
    nested_hash = { array: [1, 2, { foo: :blah, array2: [3, 4, { see: :more }] }] }
    deepstruct = DeepOpenStruct.load(nested_hash)

    expect(deepstruct.array).to be_a(Array)
    expect(deepstruct.array[0]).to eq(1)
    expect(deepstruct.array[1]).to eq(2)

    expect(deepstruct.array[2]).to be_a(OpenStruct)
    expect(deepstruct.array[2].foo).to eq(:blah)

    expect(deepstruct.array[2].array2).to be_a(Array)
    expect(deepstruct.array[2].array2[0]).to eq(3)
    expect(deepstruct.array[2].array2[1]).to eq(4)

    expect(deepstruct.array[2].array2[2]).to be_a(OpenStruct)
    expect(deepstruct.array[2].array2[2].see).to eq(:more)
  end

  it 'raises ArgumentError if initialized with something other than a Hash or Array' do
    expect {
      DeepOpenStruct.load(1)
    }.to raise_error(ArgumentError)
  end

  it 'does not change source data when given Array' do
    array = [{hash1: 1}, {hash2: 2}]

    expect { 
      DeepOpenStruct.load(array)
    }.not_to change(array[0], :class)
  end

  it 'does not change source data when given Hash' do
    hash = {array: [1, 2]}

    expect {
      DeepOpenStruct.load(hash)
    }.not_to change(hash[:array], :class)
  end

  it 'allows overriding of :id' do
    deepstruct = DeepOpenStruct.load({id: :blah})
    expect(deepstruct.id).to eq(:blah)
  end

  it 'allows overriding of :type' do
    deepstruct = DeepOpenStruct.load({type: :blah})
    expect(deepstruct.type).to eq(:blah)
  end
end
