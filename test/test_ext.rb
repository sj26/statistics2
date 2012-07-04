$test = true

require 'test/unit'
require 'sample_tbl'

require '_statistics2'
$mod = Statistics2

# Request extension to be skipped.
module Statistics20
  NO_EXT = true
end
eval(File.read(File.expand_path('../../lib/statistics2.rb', __FILE__)).gsub(/Statistics2/, 'Statistics20'))
$mod0 = Statistics20

class TestStatistics2 < Test::Unit::TestCase
  def test_normal
    norm_tbl(0.0, 3.1) do |x|
      a, b = $mod.normal___x(x), $mod0.normal___x(x)
      assert_in_delta a, b, 0.000001
    end
  end

  def test_chi
    chi2_tbl() do |n, x|
      a, b = $mod.pchi2_x(n, x), $mod0.pchi2_x(n, x)
      assert_in_delta a/b, 1.0, 0.01
    end
  end

  def test_t
    t_tbl() do |n, x|
      a, b = $mod.ptx__x(n, x), $mod.ptx__x(n, x)
      assert_in_delta a, b, 0.001
    end
  end

  def test_f
    [0.01, 0.025, 0.05].each do |opt|
      f_tbl(opt) do |n1, n2, y|
        a, b = $mod.pf_x(n1, n2, y), $mod0.pf_x(n1, n2, y)
        assert_in_delta a/b, 1.0, 0.01
      end
    end
  end
end
