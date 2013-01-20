double a[100000];
double b[100000];

void n()
{
    int j;

    for (j=0; j<100000; j++) {
        a[j] = ((double)j)/1000000;
    }
}

int m()
{
    int t, i, j;

    n();

    /* start */
    for (t = 0; t < 20; t++) {
        for (i = 2; i < 100000 - 1; i++) {
            b[i] = 0.33333 * (a[i-1] + a[i] + a[i + 1]);
        }
        for (j = 2; j < 100000 - 1; j++) {
            a[j] = b[j];
        }
    }
    /* end */

    return 0;
}
