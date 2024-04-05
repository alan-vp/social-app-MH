require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
  assert_equal FILL_IN, full_title
  assert_equal FILL_IN, full_title("Help")
  end
end


# si esto da error eliminar este archivo así como:
# línea 12 de test/integration/site_layout_test.rb
# assert_select 'title', full_title('Contact')
# y línea 11 test/test_helper.rb
# include ApplicationHelper

# Ya que este archivo acorde al libro se tenía que haber creado con las dependencias y estructura, sin embargo no existía
# y se creó de forma manual transcribiendo el código aquí mostrado.
