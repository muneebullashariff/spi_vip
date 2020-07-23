// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1302, EBLK  * I1297, U  I691);
void  hsG_0__0 (struct dummyq_struct * I1302, EBLK  * I1297, U  I691)
{
    U  I1563;
    U  I1564;
    U  I1565;
    struct futq * I1566;
    struct dummyq_struct * pQ = I1302;
    I1563 = ((U )vcs_clocks) + I691;
    I1565 = I1563 & ((1 << fHashTableSize) - 1);
    I1297->I736 = (EBLK  *)(-1);
    I1297->I737 = I1563;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1297);
    }
    if (I1563 < (U )vcs_clocks) {
        I1564 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1297, I1564 + 1, I1563);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I691 == 1)) {
        I1297->I739 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I736 = I1297;
        peblkFutQ1Tail = I1297;
    }
    else if ((I1566 = pQ->I1205[I1565].I751)) {
        I1297->I739 = (struct eblk *)I1566->I750;
        I1566->I750->I736 = (RP )I1297;
        I1566->I750 = (RmaEblk  *)I1297;
    }
    else {
        sched_hsopt(pQ, I1297, I1563);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
