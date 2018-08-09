require "minitest/autorun"
require_relative "../isbn.rb"

class ISBN < Minitest::Test

    # def test_assert_that_1_equals_1
    #     assert_equal(1, 1)
    # end
    
    # def test_if_isbn_bad
    #     assert_equal(false, isbn_10("yxz"))
    # end

    # def test_if_isbn_good
    #     assert_equal(true, isbn_10("7421394761"))
    # end

    # def test_ignore_dash_and_space
    #     assert_equal(true, isbn_10("74-2-1 3-9 4-7 61"))
    # end

    # def test_only_numbers
    #     assert_equal(false, isbn_10("abcdefghij"))
    # end

    # def test_wrong_isbn
    #     assert_equal(false, isbn_10("7421394769"))
    # end

    # def test_isbn13_bad
    #     assert_equal(false, isbn_13("xyz"))
    # end

    # def test_isbn13_good
    #     assert_equal(true, isbn_13("9780470059029"))
    # end
    
    # def test_ignore_dash_and_space_isbn13
    #     assert_equal(true, isbn_13("9 7 8 0-47-0-05 90 2-9"))
    # end

    # def test_isbn13_only_takes_numbers
    #     assert_equal(false, isbn_13("abcdefghijklm"))
    # end

    # def test_wrong_isbn13
    #     assert_equal(false, isbn_13("9780470059023"))
    # end

    # def test_extra_valid_isbn10
    #     assert_equal(true, isbn_10("0471958697"))
    # end

    # def test_extra_valid_isbn10_2
    #     assert_equal(true, isbn_10("0-321-14653-0"))
    # end

    # def test_extra_valid_isbn10_3
    #     assert_equal(true, isbn_10("877195869x"))
    # end

    # def test_extra_valid_isbn13
    #     assert_equal(true, isbn_13("978-0-13-149505-0"))
    # end
    
    # def test_extra_valid_isbn13_2
    #     assert_equal(true, isbn_13("978 0 471 48648 0"))
    # end

    # def test_combining_functions
    #     assert_equal(true, isbn("0471958697"))
    # end

    # def test_continued_combination
    #     assert_equal(true, isbn("978-0-13-1 49 50 5-0"))
    # end

    def test_refactor_returns_num_10
        assert_equal("0471958697", isbn_refa1("0   4- 7 1-  - -95 8--6-9-7"))
    end

    def test_refactor_returns_num_13
        assert_equal("9780131495050", isbn_refa1("9  78-0-13-14 9- -50 5-0"))
    end

    def test_refactor_returns_false
        assert_equal(false, isbn_refa1("abc123def456x"))
    end

    def test_refa2_returns_true
        assert_equal(["9780131495050", 100, "0"], isbn_refa2("9  78-0-13-14 9- -50 5-0"))
    end

    def test_refa2_returns_false
        assert_equal(false, isbn_refa2("abs123w54x"))
    end

    def test_refa3_returns_true
        assert_equal(true, isbn_refa3("0   4- 7 1-  - -95 8--6-9-7"))
    end

    def test_refa3_returns_false
        assert_equal(false, isbn_refa3("as58f3w54x"))
    end

    def test_refa3_returns_false_for_empty_string
        assert_equal(false, isbn_refa3(""))
    end

end