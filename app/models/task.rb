class Task < ApplicationRecord
  # has_one_attached :image
  has_many_attached :images # 複数の添付画像

  belongs_to :user
  validates :name, presence: true
  validates :name, length: { maximum: 30 }

  scope :recent, -> { order(created_at: :desc) }

  # before_validation :set_name


  class << self
      # モデル側で検索対象のカラムを指定する。
      # (Strong Parametersのメンテナンスが大変なため)
      def ransackable_attributes(auth_object = nil)
        %w[name created_at]
      end

      def ransackable_associations(auth_object = nil)
        []
      end

      def csv_attributes
        %w(name description created_at updated_at)
      end

      def generate_csv
        CSV.generate(headers: true) do |csv|
          csv << csv_attributes
          all.each do |task|
            csv << csv_attributes.map{ |attr| task.send(attr) }
          end
        end
      end

      def import(file)
        CSV.foreach(file.path, headers: true) do |row|
          task = new # Task.new と ほぼ同意
          task.attributes = row.to_hash.slice(*csv_attributes)
          task.save!
        end
      end
    end

  private

  # def set_name
  #   self.name = "nanashi" if name.blank?
  # end
end
