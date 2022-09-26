require 'aws-sdk-dynamodb'
require 'dotenv' 
Dotenv.load



def update_item?(dynamodb_client,table_item)
    response =  dynamodb_client.update_item(table_item)
    puts "UPDATE item!!title?...:'#{table_item[:title]}'"
    true
rescue StandardError => e
    puts "Error updating item! '#{e.message}"
    false
end

def run_me
    region = 'ap-northeast-1'
    table_name = 'dynamo_practice'
    year = 2022
    title = 'Beer WISKY'
    feel = 'not_fine'
    access_key_id = ENV['AWS_ACCESS_KEY']
    secret_access_key = ENV['AWS_SECRET_KEY']

    dynamodb_client = Aws::DynamoDB::Client.new(region: region,
                                                access_key_id: access_key_id,
                                                secret_access_key: secret_access_key)

    table_item = {
        table_name: table_name,
        key:{
            year: year,
            title: title
        },
        update_expression: "SET feel = :feel", #更新カラムを記載
        expression_attribute_values: {':feel': 'fine!!'},#更新カラムの値を記載
        return_values: 'UPDATED_NEW'
    }

    puts "Drinking alcohol '#{table_name}' with information about"\
            "to table '#{title}(#{year})' ..."
    if update_item?(dynamodb_client,table_item)
        puts 'Table Updated (๑>◡<๑)'
    else
        puts 'Table Not Updated (( _ _ ))..zzzZZ'
    end
end

run_me if $PROGRAM_NAME = __FILE__