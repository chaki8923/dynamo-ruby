require 'aws-sdk-dynamodb'
require 'dotenv' 
Dotenv.load



def item_delete_from_table?(dynamodb_client,table_item)
    dynamodb_client.delete_item(table_item)
    true
rescue StandardError => e
    puts "Error deleting item!! #{e.message}"
    false
end

def run_me
    region = 'ap-northeast-1'
    table_name = 'dynamo_practice'
    year = 2021
    title = 'Drin WISKY'
    feel = 'fine'
    plot = 'Nathing happens at all'
    rating = 5.5

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

    puts "Deleting item '#{title} (#{year})' from the '#{table_name}' table..."

    if item_delete_from_table?(dynamodb_client,table_item)
        puts 'Item deleted.😇😇😇😇😇😇😇😇😇'
    else
        puts 'Item not deleted'
    end
end

run_me if $PROGRAM_NAME = __FILE__