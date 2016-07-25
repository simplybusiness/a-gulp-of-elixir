defmodule Transaction do
  defstruct [:date, :account_id, :customer, :amount, errors: []]

  def parse([date, "account_" <> account_id, customer, amount]) do
    %__MODULE__{date: date,
                account_id: String.to_integer(account_id),
                customer: customer,
                amount: String.to_float(amount)}
  end

  def validate(%__MODULE__{} = trans) do
    trans
    |> validate_due
  end

  defp validate_due(%__MODULE__{amount: amount, errors: errors} = trans)
  when amount > 5,
    do: %{trans | errors: ["#{amount} is to much" | errors]}

  defp validate_due(%__MODULE__{} = trans), do: trans
end

defmodule App do
  def process(filename) do
    filename
    |> load
    |> parse
    |> validate
  end

  defp load(filename) do
    filename
    |> File.read!
    |> String.trim
    |> String.split("\n")
  end

  defp parse(list) do
    list
    |> Enum.map(fn x -> String.split(x, ",") end)
    |> Enum.map(fn x -> Transaction.parse(x) end)
  end

  defp validate(list) do
    Enum.map(list, fn t -> Transaction.validate(t) end)
  end
end

App.process("./data.csv") |> Enum.filter(fn %{errors: errors} -> errors != [] end)
