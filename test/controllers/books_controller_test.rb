require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    Book.create name: '三体1'
    Book.create name: '三体2'
    Book.create name: '三体3'
    Book.create name: '红楼梦'
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get index with parameter" do

    puts Book.all.map(&:name)

    assert_equal 4, Book.count
    assert Book.count == 4

    get books_url, params: {name: '三体'}

    # 想判断当前页面会显示几条数据。
    # 也就是判断  @books 这个变量 有几个元素
    #puts "== @books: #{assigns(:books).inspect}"
    assert_equal 3, assigns(:books).size
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count", 2) do
      post books_url, params: { book: { name: "星际争霸" } }
      post books_url, params: { book: { name: "仙剑" } }
    end

  end

  test "should show book" do
    book = Book.where("name  = ?", "红楼梦").last
    get book_url(book)

    assert_equal "红楼梦", assigns(:book).name
    assert_response :success
  end

  test "should get edit" do
    book = Book.first
    get edit_book_url(id: book.id)
    assert_response :success
  end

  test "should update book" do
    book = Book.first
    put book_url(book), params: { book: { name: "童话大王" } }

    book = Book.first
    assert_equal "童话大王", book.name
  end

  test "should destroy book" do
    book = Book.first
    assert_difference("Book.count", -1) do
      delete book_url(book)
    end
  end
end
