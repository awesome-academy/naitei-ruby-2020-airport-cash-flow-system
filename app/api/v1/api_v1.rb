class ApiV1 < Grape::API
  format :json
  prefix :api
  version "v1", using: :path

  mount RequestApi
end
