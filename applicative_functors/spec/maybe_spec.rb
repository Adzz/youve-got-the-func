require 'spec_helper'

RSpec.describe Maybe do
  let(:identity)  { ->(x) { x } }
  let(:add_ten) { ->(x) { x + 10 } }
  let(:nothing) { Maybe.new(nil) }

  context "FUNCTOR #fmap" do
    context "The first functor law" do
      it "fmaping identity will return the same maybe" do
        maybe = Maybe.new("String")
        expect(maybe.fmap(identity)).to eq Maybe.new("String")
     end
    end

    context "As a mapp-able container it..." do
      it "maps a function over the contained value applying it correctly" do
        expect(Maybe.new(10).fmap(add_ten)).to eq Maybe.new(20)
      end

      it "wont blow up if we map over a nothing" do
        expect(nothing.fmap(add_ten)).to eq nothing
      end

      it "hitting a nil in a chain of functions wont blow up" do
        stumbling_block = -> (_x) { nil }
        expect(Maybe.new(10).fmap(add_ten).fmap(stumbling_block)).to eq nothing
        expect(Maybe.new(10).fmap(stumbling_block).fmap(add_ten)).to eq nothing
      end
    end

    context "follows the second functor law" do
      it "composed functions are equal to successive non composed functions" do
        plus_four = ->(x) { x + 4 }
        plus_four_add_ten = -> (x) { x + 4 + 10 }

        maybe          = Maybe.new(10).fmap(plus_four).fmap(add_ten)
        composed_maybe = Maybe.new(10).fmap(plus_four_add_ten)
        expect(maybe).to eq composed_maybe
      end
    end

    context "BONUS ROUND" do
      let(:addition) { ->(x, y) { x + y  } }

      it "functions are partially applied" do
        expect(Maybe.new(10).fmap(addition).value.call(10)).to eq 20
      end

      it "....and composed!" do
        divide_by_ten = -> (x) { x / 10 }
        expect(Maybe.new(100).fmap(addition).fmap(divide_by_ten).value.call(10)).to eq 101
      end
    end
  end

  context "APPLICATIVES #apply" do
    let(:id)      { Maybe.new(identity) }
    let(:fifty)   { Maybe.new(50) }
    let(:add_ten_wrapped) { Maybe.new( ->(x) { x + 10}) }

    context "Still prevents nil errors" do
      it "wont blow up if we map over a nothing" do
        expect(nothing.apply(add_ten_wrapped)).to eq nothing
      end

      it "hitting a nil in a chain of functions wont blow up" do
        stumbling_block = Maybe.new(-> (_x) { nil })
        expect(Maybe.new(10).apply(add_ten_wrapped).apply(stumbling_block)).to eq nothing
        expect(Maybe.new(10).apply(stumbling_block).apply(add_ten_wrapped)).to eq nothing
      end
    end

    context "First Applicative Law" do
      it "Identity - applying the id function to a wrapped value yields the same wrapped result" do
        identity = fifty.apply(id) == Maybe.new(50)
        expect(identity).to be true
      end
    end

    context "Second applicative law" do
      it "Homomorphism - Applying a wrapped function to a wrapped value is the same as applying an unwrapped function to an unwrapped value, and then wrapping it" do
        homomorphism = fifty.apply(add_ten_wrapped) == Maybe.new(add_ten.call(50))
        expect(homomorphism).to be true
      end
    end

    context "Third applicative law" do
      it "Interchange" do
        interchange = fifty.apply(add_ten_wrapped) == add_ten_wrapped.apply(Maybe.new(->(func){func.call(50)}))
        expect(interchange).to be true
      end
    end

    context "Fourth applicative law" do
      it "Composition" do
        add_four_wrapped = Maybe.new(->(x) {x + 4})
        add_fourteen     = Maybe.new(->(x) {x + 14})

        composition = fifty.apply(add_ten_wrapped).apply(add_four_wrapped) ==  fifty.apply(add_fourteen)
        expect(composition).to be true
      end
    end
  end
end
