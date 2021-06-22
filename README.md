# テーブルスキーマ

### Users
|  Column  |  Data  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  pasdword_digest  |  string  |
  
### Tasks
|  Column  |  Data  |
| ---- | ---- |
|  title |  string  |
|  content  |  text  |
| status  |  string  |
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
