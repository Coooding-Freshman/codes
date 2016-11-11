// Created by Li zhenghao for ...
#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<unistd.h>

float f(float x, float y, float z) {
    float a;
    a=x*x+9.0f/4.0f*y*y+z*z-1;
    return a*a*a-x*x*z*z*z-9.0f/80.0f*y*y*z*z*z;
}

float h(float x, float z) {
float y;
    for ( y = 1.0f; y >= 0.0f; y -= 0.001f)
        if (f(x, y, z) <= 0.0f)
            return y;
    return 0.0f;
}

int main()
{
    double start;
    float x,y,a,v,y0,ny,nx,nz,nd,d;;
    int count=0;
    start=clock();
    usleep(2000);
    while(1){
        if((int)(clock()-start)/1000>0){
            system("clear");
            printf("\n");
            printf("\n");
            switch(count){
                case 0:printf("\t\t\t     x\n");break;
                case 1:printf("\t\t\t     x\n");break;
                case 2:printf("\t\t\t     x\n");break;
                case 3:printf("\t\t\t     !\n");break;
                case 4:printf("\t\t\t     ¿\n");break;
                case 5:printf("\t\t\t     ¿\n");break;
                case 6:printf("\t\t\t     ¿\n");break;
                case 7:printf("\t\t\t     ¿\n");break;
                case 8:printf("\t\t\t     ¿\n");break;
                default :printf("\t\t\txxx¿¿¿¿¿\n\t\t\t  ¿¿¿¿¿¿"); break;
            }
            ++count;
            for(y=1.5f;y>-1.5f;y-=0.1f){
                for(x=-1.5f;x<1.5f;x+=0.05f){
                    if(count>12){
                        v=f(x,0.0f,y);
                        if(v<0.0f){
                            y0=h(x,y);
                            ny=0.01f;
                            nx=h(x+ny,y)-y0;
                            nz=h(x,y+ny)-y0;
                            nd=1.0f/sqrt(nx*nx+ny*ny+nz*nz);
                            d=(nx+ny-nz)*nd*0.5f+0.5f;
                            putchar(".:-=+*#%@"[(int)(d * 5.0f)]);
                        }else{
                            putchar(' ');
                        }
                    }else{
                        a=x*x+y*y-1;
                        putchar(a*a*a-x*x*y*y*y<=0.0f?'*':' ');
                    }
                }
                putchar('\n');
            }
            start=clock();
        }
    }
    return 0;
}
