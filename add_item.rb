require 'aws-sdk-dynamodb'
require 'dotenv' 
Dotenv.load



def add_item_to_table(dynamodb_client,table_item)
    dynamodb_client.put_item(table_item)
    puts "Added item '#{table_item[:item][:title]}" \
         "(#{table_item[:item][:year]})'٩( ᐛ )و"
rescue StandardError => e
    puts "Error adding item!! '#{table_item[:item][:title]}" \
        "(#{table_item[:item][:year]})' : #{e.message}"
end

def run_me
    region = 'ap-northeast-1'
    table_name = 'dynamo_practice'
    year = 2021
    title = 'Pork!!'
    feel = 'fine!'
    plot = 'Nathing happens at all'
    rating = 5.5

    access_key_id = ENV['AWS_ACCESS_KEY']
    secret_access_key = ENV['AWS_SECRET_KEY']

    dynamodb_client = Aws::DynamoDB::Client.new(region: region,
                                                access_key_id: access_key_id,
                                                secret_access_key: secret_access_key)

    table_item = {
        table_name: table_name,
        item:{
            year: year,
            title: title,
            feel: feel,
            info: {             # infoはあってもなくてもOK
                plot: plot,
                rating: rating
            }
        }
    }

    puts "Drinking alcohol '#{table_item[:item][:title]}"\
            "to table '#{table_name}' ..."

        add_item_to_table(dynamodb_client,table_item)
end

run_me if $PROGRAM_NAME = __FILE__