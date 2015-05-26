require 'spec_helper'

describe User do

  #サンプルのユーザー情報入力
  before { @user = User.new(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar") }

  subject{ @user }

  # 入力されているかどうか
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  # 値が間違っていた時に正しく動くか？
  describe "when name is not present" do
    before { @user.name = "  " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "  " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it {should_not be_valid}
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    # 事前にデータベースに登録
    before { @user.save }
    # ユーザー検索
    let(:found_user) { User.find_by(email: @user.email) }

    # データベースの該当ユーザーのパスワードと入力したパスワードが正しい場合
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    # 正しくない場合
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      # specify は it と同義
      specify { expect(user_for_invalid_password).to be_false }
    end

    # パスワードは６文字以上じゃないとダメです
    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end

end
