## テーブルスキーマ

### Users
|  Column  |  Data  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  pasdword_digest  |  string  |
  
### Tasks
|  Column  |  Data  |
| ---- | ---- |
|  name |  string  |
|  detail  |  text  |
|  status  |  string  |
|  priority |  integer  |
|  expire_on  |  date  |

### Label_lists
|  Column  |  Data  |
| ---- | ---- |
| tasks_id(FK) |    |
| labels_id(FK) |  |


### Labels
|  Column  |  Data  |
| ---- | ---- |
| label_name |  string  |


## Herokuデプロイ

heroku login  
heroku create  
rails assets:precompile RAILS_ENV=production  

heroku buildpacks:set heroku/ruby  
heroku buildpacks:add --index 1 heroku/nodejs  

heroku stack:set heroku-18  

bundle lock --add-platform x86_64-linux  

git add .  
git commit -m 'fix'  
git push heroku master or git push heroku ブランチ名:master  

heroku run rails db:migrate  
