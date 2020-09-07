class RequestApi < ApiV1
  resource :requests do
    desc "Return all requests"
    get "/" do
      Request.all
    end
  end
end
