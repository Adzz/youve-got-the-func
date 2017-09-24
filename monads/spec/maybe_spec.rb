require 'spec_helper'

RSpec.describe Maybe do
  let(:identity)  { ->(x) { x } }
  let(:add_ten) { ->(x) { x + 10 } }
  let(:nothing) { Maybe.new(nil) }
  let(:fifty)   { Maybe.new(50) }


  context "FUNCTOR #fmap" do
    it "fmaping identity will return the same maybe" do
      expect(fifty.fmap(identity)).to eq Maybe.new(50)
    end

    it "maps a function over the contained value applying it correctly" do
      expect(fifty.fmap(add_ten)).to eq Maybe.new(60)
    end

    it "wont blow up if we map over a nothing" do
      expect(nothing.fmap(add_ten)).to eq nothing
    end

    it "hitting a nil in a chain of functions wont blow up" do
      stumbling_block = -> (_x) { nil }
      expect(fifty.fmap(add_ten).fmap(stumbling_block)).to eq nothing
      expect(fifty.fmap(stumbling_block).fmap(add_ten)).to eq nothing
    end

    it "composed functions are equal to successive non composed functions" do
      plus_four = ->(x) { x + 4 }
      plus_four_add_ten = -> (x) { x + 4 + 10 }

      maybe          = fifty.fmap(plus_four).fmap(add_ten)
      composed_maybe = fifty.fmap(plus_four_add_ten)
      expect(maybe).to eq composed_maybe
    end

    context "BONUS ROUND" do
      let(:addition) { ->(x, y) { x + y  } }

      it "functions are partially applied" do
        expect(fifty.fmap(addition).value.call(10)).to eq 60
      end

      it "....and composed!" do
        divide_by_ten = -> (x) { x / 10 }
        expect(fifty.fmap(addition).fmap(divide_by_ten).value.call(10)).to eq 51
      end
    end
  end

  context "APPLICATIVES #apply" do
    let(:id)      { Maybe.new(identity) }
    let(:add_ten_wrapped) { Maybe.new( ->(x) { x + 10}) }

    it "wont blow up if we map over a nothing" do
      expect(nothing.apply(add_ten_wrapped)).to eq nothing
    end

    it "hitting a nil in a chain of functions wont blow up" do
      stumbling_block = Maybe.new(-> (_x) { nil })

      expect(fifty.apply(add_ten_wrapped).apply(stumbling_block)).to eq nothing
      expect(fifty.apply(stumbling_block).apply(add_ten_wrapped)).to eq nothing
    end

    it "Identity - applying the id function to a wrapped value yields the same wrapped result" do
      identity = fifty.apply(id) == Maybe.new(50)
      expect(identity).to be true
    end

    it "Homomorphism - Applying a wrapped function to a wrapped value is the same as applying an unwrapped function to an unwrapped value, and then wrapping it" do
      homomorphism = fifty.apply(add_ten_wrapped) == Maybe.new(add_ten.call(50))
      expect(homomorphism).to be true
    end

    it "Interchange" do
      interchange = fifty.apply(add_ten_wrapped) == add_ten_wrapped.apply(Maybe.new(->(func){func.call(50)}))
      expect(interchange).to be true
    end

    it "Composition" do
      add_four_wrapped = Maybe.new(->(x) {x + 4})
      add_fourteen     = Maybe.new(->(x) {x + 14})

      composition = fifty.apply(add_ten_wrapped).apply(add_four_wrapped) ==  fifty.apply(add_fourteen)
      expect(composition).to be true
    end
  end

  context "MONADS #bind" do
    let(:constructor) { Maybe.new(-> (x) { Maybe.new(x) }) }

    it "chains together functions that return maybes successfully" do
      expect(fifty.bind(constructor).bind(constructor)).to eq Maybe.new(50)
    end
  end
end
