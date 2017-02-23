#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>
#include<curses.h>

#define LEN 4
#define swap(a,b) {a ^= b; b ^= a; a ^= b;}

int score = 0;
int Highest = 0;
void print(int **arr){
    system("clear");
    char buffer[5000];
    sprintf(buffer, "%s", "\n\n\n\n");
    sprintf(buffer, "%s                  2048 by lzh\n\r", buffer);
    sprintf(buffer, "%s        score: %5d   Highest: %5d\n\r", buffer, score, Highest);
    for(int i = 0; i < LEN; ++i){
        sprintf(buffer, "%s        -----------------------------\n\r", buffer);
        sprintf(buffer, "%s        |      |      |      |      |\n\r", buffer);
        sprintf(buffer, "%s        ", buffer);
        for(int j = 0; j < LEN; ++j){
            if (arr[i][j] == 0)
                sprintf(buffer, "%s|      ", buffer);
            else
                sprintf(buffer, "%s| %4d ", buffer, arr[i][j]);
        }
        sprintf(buffer, "%s|\n\r", buffer);
        sprintf(buffer, "%s        |      |      |      |      |\n\r", buffer);
    }
    sprintf(buffer, "%s        -----------------------------\n\r", buffer);
    printf("%s", buffer);
}

void init(int **arr){
    for(int i = 0; i < LEN; ++i)
        memset((void*)arr[i], 0, sizeof(int) * LEN);
    int a = rand()%4, b =rand()%4;
    arr[a][b] = 2;
}

void transpose(int **arr){
    for(int i = 0; i < LEN; ++i){
        for(int j = i + 1; j < LEN; ++j)
            swap(arr[i][j], arr[j][i]);
    }
}

void reverse(int **arr){
    for(int i = 0; i < LEN/2; ++i)
        for(int j = 0; j < LEN; ++j)
            swap(arr[i][j], arr[LEN - 1 - i][j]);
}

void recordScore();
int randomInsert(int **arr, int move){
    int zeroElement = 0;
    for(int i = 0; i < LEN; i++)
        for(int j = 0; j < LEN; j++)
            if(arr[i][j] == 0)
                zeroElement++;
    if(zeroElement == 0){
        recordScore();
        printf("\n\n\t\tYou are doomed!!!\n\n");
        return 0;
    }
    if(move == 0)
        return 1;
    int val = rand()%zeroElement + 1;
    int counter = 0;
    for(int i = 0; i < LEN; i++){
        for(int j = 0; j < LEN; j++){
            if(arr[i][j] == 0)
                counter++;
            if(counter == val){
                arr[i][j] = 2;
                return 1;
            }
        }
    }
    return 0;
}

int combine(int **arr){
    int move = 0;
    for(int i = 0; i < LEN; ++i){
        int j = 0;
        int counter = 0;
        while(counter < LEN - 1){
            if(arr[j][i] == 0){
                int w = j;
                while(w < LEN - 1){
                    if(arr[w+1][i] != 0)
                        move = 1;
                    arr[w][i] = arr[w + 1][i];
                    w++;
                }
                arr[w][i] = 0;
            }else
                ++j;
            counter++;
        }
        j = 0;
        while(j < LEN - 1){
            if(arr[j][i] == arr[j + 1][i] && arr[j][i]){
                move = 1;
                score += arr[j][i];
                arr[j][i] *= 2;
                arr[j + 1][i] = 0;
            }
            ++j;
        }
        j = 0;
        counter = 0;
        while(counter < LEN - 1){
            if(arr[j][i] == 0){
                int w = j;
                while(w < LEN - 1){
                    arr[w][i] = arr[w + 1][i];
                    w++;
                }
                arr[w][i] = 0;
            }else
                ++j;
            counter++;
        }
    }
    return move;
}

void recordScore(){
    if(score > Highest){
        FILE *f = fopen(".HighestScore.txt", "w");
        fprintf(f, "%d", score);
    }
}

void control(int **arr){
    int c = 1;
    while(c){
        print(arr);
        int move = 0;
        c = getch();
        switch(c){
            case 'w':
                move = combine(arr);
                break;
            case 'a':
                transpose(arr);
                move = combine(arr);
                transpose(arr);
                break;
            case 's':
                reverse(arr);
                move = combine(arr);
                reverse(arr);
                break;
            case 'd':
                transpose(arr);
                reverse(arr);
                move = combine(arr);
                reverse(arr);
                transpose(arr);
                break;
            case 'q':
                recordScore();
                return;
            default: continue;
        }
        if(!randomInsert(arr, move))
            return;
    }
}
int main(){
//    initscr();
    SCREEN *s = newterm(NULL, stdin, stdout);
    noecho();
    FILE *scoreFile;
    if((scoreFile = fopen(".HighestScore.txt", "r")) == NULL){
        scoreFile = fopen(".HighestScore.txt", "w");
        fprintf(scoreFile, "0");
    }else
        fscanf(scoreFile, "%d", &Highest);
    srand((unsigned int)time(NULL));
    int **arr = (int **)malloc(sizeof(int*) * 4);
    for(int i = 0; i <LEN; ++i)
        arr[i] = (int *)malloc(sizeof(int) * 4);
    init(arr);
    control(arr);
    for(int i = 0; i < LEN; ++i)
        free(arr[i]);
    free(arr);
    endwin();
    return 0;
}
