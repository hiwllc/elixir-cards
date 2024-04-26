defmodule Cards do
  @moduledoc """
    Provides methods for create and handling a deck of cards
  """

  @doc """
    Return a list of strings for cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines wheter a deck contains a given card

    ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how manu cards should be in the hand.

    ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @spec save(
          any(),
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | char(),
              binary() | []
            )
        ) :: :ok | {:error, atom()}
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "Arquivo não existe"
    end
  end

  def create_hand(size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(size)
  end
end
