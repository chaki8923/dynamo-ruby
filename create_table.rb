require 'aws-sdk-dynamodb'
require 'dotenv' 
Dotenv.load



def create_table(dynamodb_client,table_definition)
    response = dynamodb_client.create_table(table_definition)
    response.table_description.table_status
rescue StandardError => e
    puts "Error create table: #{e.message}"
    'Error'

end

def run_me
    region = 'ap-northeast-1'
    table_name = 'dynamo_practice'
    access_key_id = ENV['AWS_ACCESS_KEY']
    secret_access_key = ENV['AWS_SECRET_KEY']

    dynamodb_client = Aws::DynamoDB::Client.new(region: region,
                                                access_key_id: access_key_id,
                                                secret_access_key: secret_access_key)

    table_definition = {
        table_name: table_name,
        key_schema:[
            {
                attribute_name: 'year',
                key_type: 'HASH' # パーティションキーにHASHを指定しないとダメ
            },
            {
                attribute_name: 'title',
                key_type: 'RANGE' # ソートキーにはRANGEを指定しないとダメ
            }
        ],
        attribute_definitions:[
            {
                attribute_name: 'year',
                attribute_type: 'N' # 型指定
            },
            {
                attribute_name: 'title',
                attribute_type: 'S' #型指定
            }
        ],
        provisioned_throughput:{
            read_capacity_units: 10, # 読み取り容量
            write_capacity_units: 10 #書き込み容量
        }
    }

    puts "Creating the table named '#{table_name}' ..."
    create_table_result = create_table(dynamodb_client,table_definition)

    if create_table_result == 'Error'
        puts 'Table not craeted.'
    else
        puts "Table craeted with status '#{create_table_result}'😋😋😋😋😋😋😋😋"
    end
end

run_me if $PROGRAM_NAME = __FILE__