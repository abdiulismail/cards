defmodule Cards do
  @moduledoc """
    Provides method for creating and handling deck of cards

     Kernel functions
There are functions related to floating-point numbers on the Kernel module too. Here is a list of them:

Kernel.round/1: rounds a number to the nearest integer.
Kernel.trunc/1: returns the integer part of a number.
 Known issues
There are some very well known problems with floating-point numbers and arithmetic due to the fact most decimal fractions cannot be represented by a floating-point binary and most operations are not exact, but operate on approximations. Those issues are not specific to Elixir, they are a property of floating point representation itself.

For example, the numbers 0.1 and 0.01 are two of them, what means the result of squaring 0.1 does not give 0.01 neither the closest representable. Here is what happens in this case:

The closest representable number to 0.1 is 0.1000000014
The closest representable number to 0.01 is 0.0099999997
Doing 0.1 * 0.1 should return 0.01, but because 0.1 is actually 0.1000000014, the result is 0.010000000000000002, and because this is not the closest representable number to 0.01, you'll get the wrong result for this operation
There are also other known problems like flooring or rounding numbers. See round/2 and floor/2 for more details about them.

To learn more about floating-point arithmetic visit:

0.30000000000000004.com
What Every Programmer Should Know About Floating-Point Arithmetic

  """

  @doc """
    returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["ace","two","three","four","five"]
    suits = ["space","clubs","hearts","diamonds"]

    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end

    # List.flatten(cards)

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

    ## Examples
       iex(3)> deck = Cards.create_deck
       iex(4)> Cards.contains?(deck,"ace of clubs")
       true
  """
  def contains?(deck,card) do
    Enum.member?(deck,card)
  end

  @doc """
    divides a deck into a hand and the remainder of the deck
    the `handsize` argument indicates how many cards should be in the hand

    ## examples
        iex(36)> deck = Cards.create_deck
        iex(37)> {hand,deck } = Cards.deal(deck,1)
        iex(38)> hand
        ["ace of space"]
  """
  def deal(deck,hand_size) do
    Enum.split(deck,hand_size)
  end

  def save(deck,filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename,binary)
  end

  def load(filename) do
    # {status,binary} = File.read(filename)

    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "file does not exist"
    # end

    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error,_reason} -> "file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end




end
