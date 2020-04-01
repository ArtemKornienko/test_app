defmodule TestAppWeb.ExampleChannel do
  use Phoenix.Channel
  def join("example", payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_inn", params, socket) do
    check_result = inn_validation(params["body"])
    new_params = Map.put_new(params, "check_result", check_result)
    case TestAppWeb.InnBaseApi.write_inn(new_params) do
      {:error, "data is wrong"} ->
        :nothing
      _else ->
        broadcast! socket, "new_inn", new_params
    end
    {:noreply, socket}
  end

# =======================================================================>
  def inn_validation(inn_body_s) do
    inn_body_l = String.codepoints(inn_body_s)
    inn_validation(inn_body_l, String.length(inn_body_s))
  end
  def inn_validation(inn_body, 10) do
    case mul(inn_body, [2,4,10,3,5,9,4,6,8,0], 0) do
      true ->
        "корректен"
      false ->
        "некорректен"
    end
  end

  def inn_validation(inn_body, 12) do
    answ1 = mul(inn_body, [7,2,4,10,3,5,9,4,6,8,0], 0)
    answ2 = mul(inn_body, [3,7,2,4,10,3,5,9,4,6,8,0], 0)
    case true == answ1 == answ2 do
      true ->
        "корректен"
      false ->
        "некорректен"
    end
  end

  def inn_validation(_inn_body, _inn_length) do
    "некорректен"
  end

  def mul([last_num|_], [0], sum) do
    chast = rem(sum, 11)
    chast = if chast == 10 do
      0
    else
      chast
    end
    {last_num_int, _} = Integer.parse(last_num)
    case chast == last_num_int  do
      true ->
        true
      false ->
        false
    end
  end
  def mul([h|t], [h1|t1], sum) do
    {number, _} = Integer.parse(h)
    new_sum = sum + number*h1
    mul(t, t1, new_sum)
  end

  def inn_send(_socket, []) do
    :ok
  end

  def inn_send(socket, [h|t]) do
    params = %{"body" => h.inn, "date" => h.date, "check_result" => h.check }
    broadcast! socket, "new_inn", params
    inn_send(socket, t)
  end
end
