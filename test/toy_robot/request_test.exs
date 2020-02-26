defmodule ToyRobot.RequestTest do
  use ExUnit.Case

  import Mock

  alias ToyRobot.Request

  @post_response %HTTPoison.Response{
    body: "{\"direction\":\"north\",\"x\":0,\"y\":1}",
    headers: [
      {"cache-control", "max-age=0, private, must-revalidate"},
      {"content-length", "33"},
      {"content-type", "application/json; charset=utf-8"},
      {"date", "Wed, 26 Feb 2020 05:42:44 GMT"},
      {"server", "Cowboy"}
    ],
    request: %HTTPoison.Request{
      body: "{\"direction\":\"north\",\"x\":0,\"y\":1}",
      headers: [{"content-type", "application/json"}],
      method: :post,
      options: [],
      params: %{},
      url: "http://localhost:4001/place"
    },
    request_url: "http://localhost:4001/place",
    status_code: 200
  }

  @get_response %HTTPoison.Response{
    body: "{\"direction\":\"west\",\"x\":0,\"y\":1}",
    headers: [
      {"cache-control", "max-age=0, private, must-revalidate"},
      {"content-length", "32"},
      {"content-type", "application/json; charset=utf-8"},
      {"date", "Wed, 26 Feb 2020 05:43:57 GMT"},
      {"server", "Cowboy"}
    ],
    request: %HTTPoison.Request{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "http://localhost:4001/report"
    },
    request_url: "http://localhost:4001/report",
    status_code: 200
  }

  describe "get/1" do
    test "makes a call to the given endpoint" do
      with_mock HTTPoison, get!: fn _ -> @get_response end do
        Request.get("/report")
        assert_called(HTTPoison.get!(api_base_url() <> "/report"))
      end
    end

    test "returns the response data as a map" do
      with_mock HTTPoison, get!: fn _ -> @get_response end do
        assert Request.get("/report") == %{"direction" => "west", "x" => 0, "y" => 1}
      end
    end
  end

  describe "post/2" do
    test "makes a call to the given endpoint" do
      with_mock HTTPoison, post!: fn _, _, _ -> @post_response end do
        Request.post("/move")
        assert_called(HTTPoison.post!(api_base_url() <> "/move", :_, :_))
      end
    end

    test "sets the content type to JSON" do
      with_mock HTTPoison, post!: fn _, _, _ -> @post_response end do
        Request.post("/move")
        assert_called(HTTPoison.post!(:_, :_, [{"content-type", "application/json"}]))
      end
    end

    test "sets the body to empty if not given data" do
      with_mock HTTPoison, post!: fn _, _, _ -> @post_response end do
        Request.post("/move")
        assert_called(HTTPoison.post!(:_, "", :_))
      end
    end

    test "sets the body to a JSON encoded string if given data" do
      with_mock HTTPoison, post!: fn _, _, _ -> @post_response end do
        Request.post("/place", %{x: 0, y: 0, direction: :north})
        assert_called(HTTPoison.post!(:_, "{\"direction\":\"north\",\"x\":0,\"y\":0}", :_))
      end
    end

    test "returns the response data as a map" do
      with_mock HTTPoison, post!: fn _, _, _ -> @post_response end do
        resp = Request.post("/place", %{x: 0, y: 0, direction: :north})
        assert resp == %{"direction" => "north", "x" => 0, "y" => 1}
      end
    end
  end

  defp api_base_url() do
    Application.get_env(:toy_robot, :api_base_url)
  end
end
