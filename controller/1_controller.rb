class Controller < Ramaze::Controller
  layout '/page'
  helper :flash, :xhtml
  engine :Haml
end