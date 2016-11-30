#include <iostream>  
#include <vector>  
#include <list>  
#include <map>  
#include <set>  
#include <deque>  
#include <queue>  
#include <stack>  
#include <bitset>  
#include <algorithm>  
#include <functional>  
#include <numeric>  
#include <utility>  
#include <sstream>  
#include <iomanip>  
#include <cstdio>  
#include <cmath>  
#include <cstdlib>  
#include <cctype>  
#include <string>  
#include <cstring>  
#include <cmath>  
#include <ctime>  
#include <fstream>
#define MAXN 9*9*9*9  
#define INF 1000000000  
#define N 9  
#define M 9*9*9+5  
#define rep(i, a, b)  for(int i = a; i <= b; i++)
using namespace std; 
char mpm[9][9];
int T; 
int L[MAXN], R[MAXN], C[MAXN], S[M], U[MAXN], D[MAXN], H[M], O[M], X[MAXN];  
int cnt, head;  
char mp[N * N + 5], ans[N * N + 5];  
bool vis[N * N * 4 + 5];  
void link(int r, int c)  
{  
    S[c]++;  
    C[cnt] = c;  
    X[cnt] = r;  
    U[cnt] = c;  
    D[cnt] = D[c];  
    U[D[c]] = cnt;  
    D[c] = cnt;  
    if(H[r] == -1)  
    {  
        H[r] = cnt;  
        L[cnt] = R[cnt] = cnt;  
    }  
    else  
    {  
        L[cnt] = H[r];  
        R[cnt] = R[H[r]];  
        L[R[H[r]]] = cnt;  
        R[H[r]] = cnt;  
    }  
    cnt++;  
}  
void init()  
{  
    cnt = 0;  
    head = 0;  
    for(int i = 0; i <= N * N * 4; i++)  
    {  
        S[i] = 0;  
        vis[i] = 0;  
        D[i] = U[i] = i;  
        R[i] = (i + 1) % (N * N * 4 + 1);  
        L[i] = (i + N * N * 4) % (N * N * 4 + 1);  
        cnt++;  
    }  
    memset(H, -1, sizeof(H));  
}  
void cal(int &r, int &cx, int &cy, int &ck, int &cg, int i, int j, int k)  
{  
    r = (i * N + j) * N + k - 1;  
    cg = i * N + j + 1;  
    cx = N * N + i * N + k;  
    cy = N * N * 2 + j * N + k;  
    int LN = (int)sqrt(N * 1.0);  
    ck = N * N * 3 + (i / LN * LN + j / LN) * N + k;  
}  
void readdata()  
{  
    int r, cx, cy, ck, cg;  
    for(int i = 0; i < N; i++)  
        for(int j = 0; j < N; j++)  
            if(mp[i * N + j] != '?')  
            {  
                cal(r, cx, cy, ck, cg, i, j, mp[i * N + j] - '0');  
                link(r, cx);  
                link(r, cy);  
                link(r, ck);  
                link(r, cg);  
                vis[cx] = vis[cy] = vis[ck] = vis[cg] = 1;  
            }  
    for(int i = 0; i < N; i++)  
        for(int j = 0; j < N; j++)  
            if(mp[i * N + j] == '?')  
            for(int k = 1; k <= N; k++)  
            {  
                cal(r, cx, cy, ck, cg, i, j, k);  
                if(vis[cx] || vis[cy] || vis[ck] || vis[cg]) continue;  
                link(r, cx);  
                link(r, cy);  
                link(r, ck);  
                link(r, cg);  
            }  
}  
void removes(int c)  
{  
    L[R[c]] = L[c];  
    R[L[c]] = R[c];  
    for(int i = D[c]; i != c; i = D[i])  
        for(int j = R[i]; j != i; j = R[j])  
        {  
            U[D[j]] = U[j];  
            D[U[j]] = D[j];  
            S[C[j]]--;  
        }  
}  
void resumes(int c)  
{  
    for(int i = U[c]; i != c; i = U[i])  
        for(int j = L[i]; j != i; j = L[j])  
        {  
            U[D[j]] = j;  
            D[U[j]] = j;  
            S[C[j]]++;  
        }  
    L[R[c]] = c;  
    R[L[c]] = c;  
}  
bool dfs(int k)  
{  
    if(R[head] == head)  
    {  
        for(int i = 0; i < k; i++)  
            ans[X[O[i]] / N] = X[O[i]] % N + '1';  
        for(int i = 0; i < N * N; i++)  
        {  
            printf("%c", ans[i]);  
        }  
        printf("\n");  
        return true;  
    }  
    int s = INF, c;  
    for(int i = R[head]; i != head; i = R[i])  
        if(s > S[i])  
        {  
            s = S[i];  
            c = i;  
        }  
    removes(c);  
    for(int i = U[c]; i != c; i = U[i])  
    {  
        O[k] = i;  
        for(int j = R[i]; j != i; j = R[j])  
            removes(C[j]);  
        if(dfs(k + 1)) return true;  
        for(int j = L[i]; j != i; j = L[j])  
            resumes(C[j]);  
    }  
    resumes(c);  
    return false;  
}  
int main()  
{  
    ofstream myfile;
    myfile.open("time.txt");

    cin >> T;
    while(T--){
        // rep(i,1,9)
        //  rep(j,1,9)
        //      cin >> mp[i][j];
        string st;
        rep(i,0,8){         
            cin >> st;
            // cout <<st << endl;
            rep(j,0,8)
                mpm[i][j] = st[j];
        }
        // cout << st << endl;
        cin >> st;
        // cout <<"!"<< st << endl;
        // printf("GY\n");
        int i,j,k;
        for(i=0;i<9;i++)
            for(j=0;j<9;j++)
            {
                k = 9*i+j;
                // cout << mpm[i][j];
                mp[k]=mpm[i][j];
                // cout << mp[k];
            }
        // printf("GY1\n");
        
        clock_t start;
        double duration;
        start = clock();  
        
        init();  
        readdata();  
        dfs(0);  

        duration = ( clock() - start ) / (double) CLOCKS_PER_SEC;
        cout<< "Time: " << duration*1000 << "ms" << endl;
        myfile << fixed << setprecision(8) << duration*1000 << endl;

    }  

    myfile.close();
    return 0;  
}  