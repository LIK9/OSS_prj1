# OSS_prj1
OSS project1

가장 먼저 shebang을 입력합니다.
처음 파일 권한이 664 이었던 것을 실행하기 위해 chmod를 통해 755로 바꾸었습니다.
터미널 상에서 ./test.sh u.item u.data u.user를 입력하기 때문에 
u.item은 item_file변수에, u.data는 data_file변수에, u.user은 user_file변수에 저장합니다.

처음에 echo로 9가지 메뉴가 나옵니다.

While 을 통해 input 값이 9가 아니라면 계속 실행하도록 하였습니다. 무한 루프의 안정성 문제 때문에 이와 같이 설계하였습니다.

Input이 1이라면 read -p를 통해 input_1에 movie id에 대한 사용자의 입력값을 받습니다.
Cat 으로 u.item에 해당하는 item_file을 가져오고, 그 이후 pipe를 통해 awk를 이용합니다. -v 옵셕을 통해 아까 받은 입력값을 awk 상으로 넣고, NR 즉, 행 수가 입력값과 같다면 그 줄 전체를 출력하도록 하였습니다.

Input이 2라면 먼저 y가 입력값으로 온다면 실행하도록 하였습니다.
Awk 상에서 -F 옵션을 통해 |를 delimeter로 사용하였습니다. 액션 영화의 유무를 나타내는 $1이 1과 같다면 NR(행수)과 $2(제목, 년도)를 출력하도록 하였습니다.

Input이 3이라면. read -p를 통해 input_3에 movie id에 대한 사용자의 입력값을 받습니다.
Awk를 통해 $2(movie id)가 입력값과 같다면 awk 상의 변수 sum에 $3(rating)을 더하고 len을 하나씩 더하도록 하였습니다. END를 통해 data_file을 다 돌고 난후, 평균값을 출력하도록 하였습니다. Printf를 사용하여 decimal에 해당하는 input은 %d로, float인 평균값은 %.5f를 통해 소수점 5째 자리까지 출력되도록 하였습니다.

Input이 4이라면 먼저 y가 입력값으로 온다면 실행하도록 하였습니다.
Sed의 -E 옵션을 통해 regular expression을 사용하였습니다. S 옵션을 통해 /바꾸고 싶은 기존 내용/바꿀 새로운 내용/g 을 사용하였습니다. 주의점으로는 /과 같은 character를 사용하기 위해 sed상에서 혼용되지 않도록 \(역슬래쉬)가 앞에 붙어야 됩니다. 그리고 앞의 10줄말 출력하고 위해 pipe를 통해 head 옵션을 사용하였습니다.

Input이 5라면 먼저 y가 입력값으로 온다면 실행하도록 하였습니다
sed에서 정규식과 명령어를 구분하기 위해 -E옵션과 -e 옵션을 사용하였습니다.
S 옵션을 사용하여 /1에는 user id가, /2에는 나이 정보가, /3에는 직업 정보가 오게 하였고, -e 옵션을 통해 M또는 F를 성별에 따라서 구분하여 출력하였습니다. 그리고 head -n 10을 통해 앞의 10줄만 출력하였습니다.

Input이 6이라면 먼저 y가 입력값으로 온다면 실행하도록 하였습니다
sed에서 정규식을 위해 -E 옵션을 사용하였습니다. S 옵션을 통해 /1에는 일수, /2에는 년도 정보가 오게 하였고, -e 옵션을 통해 월마다 구분하였습니다. 그리고 tail -n 10을 통해 마지막 10줄을 출력하였습니다.

Input이 7이라면 입력값으로 user id 정보를 받았습니다.
Cat을 통해 u.data 파일에서 $1(user id)가 입력값과 같은 $2(movie id) 정보를 불러오고, sort -n을 통해 오름차순으로 정렬하였습니다. 이 일련의 작업을 pipe롤 통해 이어주었고, movieID_array 변수에 저장하였습니다. 그 이후 sed 의 s옵션을 통해 공백을 |로 바꾸었습니다. 그리고 이를 출력하였습니다.
Echo를 통해 movieID_array 변수를 불러오고, tr을 통해 |를 줄바꿈으로 바꾸고, while read 를 통해 이 정보를 한줄씩 읽고 각 줄마다 id라는 변수로 사용하였습니다. 
반복문이 실행되는 동안 즉, movie id를 한줄씩 읽는 동안 cat을 통해 u.item 파일을 읽고, awk의 -v 옵션을 통해 이 movie id를 id라는 변수로 awk 안에서 사용하였고, $1(movie id)가 id라는 변수와 같으면 $1(movie id)와 $2(제목과 년도)가 출력되도록 하였습니다.

Input이 9라면 먼저 y가 입력값으로 온다면 실행하도록 하였습니다
먼저 조건에 해당하는 user id를 변수에 저장해야됩니다. 
Input 7과 비슷한 방법입니다. Cat을 통해 u.user 파일을 불러오고, awk의 -F 옵션을 통해 |를 delimeter로 사용하고, $2(나이 정보)가 20이상, 29이하, $4(직업 정보)가 programmer 라면 $1(user id)를 출력하도록 하고, 이 정보들을 userID_array라는 변수에 저장하였습니다. 그 이후 sed 의 s옵션을 통해 공백을 |로 바꾸고 pattern이라는 변수에 저장하였습니다.
이 이후 제가 생각한 핵심은 이러했습니다. Awk의 END라는 옵션은 불러온 파일을 다 읽고나서 실행됩니다. 구해야 하는 것은 1번 영화에 대한 유저의 평균, 2번 영화에 대한 유저의 평균…이렇게 진행됩니다.  즉, 모든 movie id를 for 문으로 돌면서 하나의 과정 속에는 $1가 pattern과 일치하고, $2가 movie id와 같아면 평균을 계속하도록 하는 것입니다. Sed의 정규식을 따로 더 공부하여 awk 상에서 사용하도록 하였습니다. 
먼저 for문을 돌면서 movieID 변수에 1부터 1655까지의 정수를 넣습니다. 일련의 과정동안 cat을 통해 u.data 파일을 탐색하면서 -v 옵션을 통해 pattern과 movieID를 넣었습니다. 여기서 “^($pattern)$”이 사용되는데, sed의 정규식 처럼 |는 또는 의 의미이고, ^는 그것으로 시작, $는 그것으로 끝납니다. ^와 $를 둘 다 사용하여 그 숫자들로 시작하고 끝나는 즉, 그 숫자 그 자체로 사용될 수 있습니다. 그리고 |를 통해 그 숫자 자체 혹은 다른 숫자 자체.. 이런식으로 사용했습니다. Awk의 ~를 통해 아까 말씀드린 pattern에 포함된다면 그리고, $1(movie id)가 for 문의 변수 movieID와 같다면 awk 상의 변수 sum에 $1(rating)을 더하고, 나누어줄 len를 ++(후위 연산자)하였습니다. printf 를통해 movieID는 %d로 정수출력, 평균값은 %.5f 소수점 5째 자리까지 실수출력하였습니다. 

Input이 9라면 echo 로 Bye가 출력되고 while 문의 조건 때문에 반복문이 종료됩니다.
