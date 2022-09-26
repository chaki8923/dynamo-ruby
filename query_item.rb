require 'aws-sdk-dynamodb'
require 'dotenv' 
Dotenv.load



def query_item_to_table(dynamodb_client,table_item)
    result = dynamodb_client.query(table_item)
    result.items.each{|re| 
    
        puts "Query item is #{re['title']}(#{re['year'].to_i})😍😍😍😍😍😍😍"\
    }
    # puts "Query item is #{result.items}"
rescue StandardError => e
    puts "Error Not Get Item!! '#{e.message}'" 
end

def run_me
    region = 'ap-northeast-1'
    table_name = 'dynamo_practice'
    year = 2011
    beef_title = 'Beef!!'
    pork_title = 'Pork!!'

    access_key_id = ENV['AWS_ACCESS_KEY']
    secret_access_key = ENV['AWS_SECRET_KEY']

    dynamodb_client = Aws::DynamoDB::Client.new(region: region,
                                                access_key_id: access_key_id,
                                                secret_access_key: secret_access_key)

    table_item = {
        table_name: table_name,
        expression_attribute_names:{
            '#y' => 'year'
        },
        expression_attribute_values:{
            ':year' => 2021,
           ':beef_title' => beef_title,
           ':pork_title' => pork_title,
        },
        key_condition_expression: '#y = :year AND title BETWEEN :beef_title AND :pork_title' ,
    }

    puts "Getting item now... "\
            "from table '#{table_name}' ..."

    query_item_to_table(dynamodb_client,table_item)
end

run_me if $PROGRAM_NAME = __FILE__