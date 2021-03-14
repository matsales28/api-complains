module Responseable
  Error = -> (response) { [response, false] }
  Success = -> (response) { [response, true] }
end
