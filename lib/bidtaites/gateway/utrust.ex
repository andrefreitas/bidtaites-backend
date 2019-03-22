defmodule Bidtaites.Gateway.Utrust do
  defp headers do
    [
      {"Content-Type", "application/json"}
    ]
  end

  def store_session() do
    {:ok, body} =
      Poison.encode(%{
        data: %{
          type: "session",
          attributes: %{
            client_id: "21faf973-645b-40fc-8113-5999bb8c304a",
            client_secret: "9bc06f2d-5bb2-4e5e-a6a6-079a05755384"
          }
        }
      })

    case HTTPoison.post(
           "https://merchants.api.pixels-utrust.com/api/stores/session",
           body,
           headers()
         ) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} -> Poison.decode(body)
      _ -> {:error, Poison.encode!(%{error: "failed to create store session"})}
    end
  end

  def create_order(token, price, reference_id, email) do
    {:ok, body} =
      Poison.encode(%{
        data: %{
          type: "orders",
          attributes: %{
            order: %{
              reference: reference_id,
              amount: %{
                total: price,
                currency: "UTK",
                details: %{
                  subtotal: price,
                  handling_fee: "0.00"
                }
              },
              return_urls: %{
                return_url: "https://bidtaites.herokuapp.com/?status=return",
                cancel_url: "https://bidtaites.herokuapp.com/?status=cancel",
                callback_url: "https://bidtaites-backend.herokuapp.com/api/bids/callback"
              },
              line_items: [
                %{
                  sku: reference_id,
                  name: reference_id,
                  price: price,
                  currency: "UTK",
                  quantity: 1
                }
              ]
            },
            customer: %{
              first_name: "",
              last_name: "",
              email: email,
              address1: "",
              address2: "",
              city: "N/A",
              state: "N/A",
              postcode: "N/A",
              country: "PT"
            }
          }
        }
      })

    case HTTPoison.post(
           "https://merchants.api.pixels-utrust.com/api/stores/orders",
           body,
          headers() ++ [{"Authorization", "Bearer: #{token}"}]
         ) do
      {:ok, %HTTPoison.Response{body: body, status_code: 201}} -> Poison.decode(body)
      _ -> {:error, Poison.encode!(%{error: "failed to create store session"})}
    end
  end

  def session do
    {:ok, body} =
      Poison.encode(
        %{
          "data": %{
            "type": "session",
            "attributes": %{
              "email": "pedro.tavares@talkdesk.com",
              "password": "bidtaites"
            }
          }
        }
      )

    case HTTPoison.post(
          "https://merchants.api.pixels-utrust.com/api/session",
          body,
          headers()
        ) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} -> Poison.decode(body)
      _ -> {:error, Poison.encode!(%{error: "failed to create store session"})}
    end
  end

  def refund(token, order_id, amount) do
    {:ok, body} =
      Poison.encode(
        %{
          "data": %{
            "type": "ses",
            "attributes": %{
              "currency": "UTK",
              "amount": amount,
              "reason": "you lost the auction!"
            }
          }
        }
      )

    case HTTPoison.post(
          "https://merchants.api.pixels-utrust.com/api/payments/#{order_id}/refund",
          body,
          headers() ++ [{"Authorization", "Bearer: #{token}"}]
        ) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} -> Poison.decode(body)
      _ -> {:error, Poison.encode!(%{error: "failed to create store session"})}
    end
  end
end
