require 'aws-sdk-dynamodb'
require 'dotenv' 
Dotenv.load



def get_item_to_table(dynamodb_client,table_item)
    result = dynamodb_client.get_item(table_item)
    puts "GET ITEM is #{result.item['title']} (#{result.item['year'].to_i})🥳🥳🥳🥳🥳🥳🥳"
rescue StandardError => e
    puts "Error Not Get Item!! '#{e.message}'" 
end

def run_me
    region = 'ap-northeast-1'
    table_name = 'dynamo_practice'
    year = 2022
    title = 'Beer WISKY'

    access_key_id = ENV['AWS_ACCESS_KEY']
    secret_access_key = ENV['AWS_SECRET_KEY']

    dynamodb_client = Aws::DynamoDB::Client.new(region: region,
                                                access_key_id: access_key_id,
                                                secret_access_key: secret_access_key)

    table_item = {
        table_name: table_name,
        key:{
            year: year,
            title: title,
        }
    }

    puts "Getting item now... '#{title}(#{year})'"\
            "from table '#{table_name}' ..."

    get_item_to_table(dynamodb_client,table_item)
end

run_me if $PROGRAM_NAME = __FILE__