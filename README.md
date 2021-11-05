## usersテーブル

| Column             | Type        | Options                   |
| ------------------ | ----------- | ------------------------- |
| email              | string      | null: false, unique: true |
| encrypted_password | string      | null: false               |
| nickname           | string      | null: false               |
| last_name          | string      | null: false               |
| first_name         | string      | null: false               |
| last_name_kana     | string      | null: false               |
| first_name_kana    | string      | null: false               |
| birth_day          | date        | null: false               |

### Association
- has_many :items
- has_many :purchase_records


## itemsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| image               | string     | null: false                    |
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | text       | null: false                    |
| item_status         | integer    | null: false                    |
| shipping_fee        | integer    | null: false                    |
| item_prefecture     | integer    | null: false                    |
| scheduled_delivery  | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase_record
- has_one :item_status
- has_one :item_prefecture
- has_one :shipping_fee
- has_one :scheduled_delivery


## purchase_recordsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false ,foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :buyer_information


## buyer_informationsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | integer    | null: false                    |
| buyer_prefecture   | integer    | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | integer    | null: false                    |
| purchase_record    | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase_record
- has_one :buyer_prefecture