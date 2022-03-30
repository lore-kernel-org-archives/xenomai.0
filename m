MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 30 Mar 2022 12:14:53 +0200
Message-ID: <CAFLxGvzNx5_mrUJiaJ717knj__vOKamhsq4Vw7kyga557v4OHA@mail.gmail.com>
Subject: x86 port i/o broken on recent kernel
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi!

The following test works fine on 5.4.180 (ipipe) but fails on 5.15.9 (dovetail).

$ ./iotest
Segmentation fault
$ dmesg
[Xenomai] switching iotest to secondary mode after exception #13 from
user-space at 0x400b8d (pid 14574)
traps: iotest[14574] general protection fault ip:400b8d
sp:7feb57915e20 error:0 in iotest[400000+1000]

Wild guess, Linux's iopl() emulation might play a role.
https://lwn.net/Articles/804143/

---8<---
/*
* gcc iotest.c `/usr/xenomai/bin/xeno-config --cflags --ldflags
--skin=posix` -Wall -o iotest
*/

#include <assert.h>
#include <pthread.h>
#include <sched.h>
#include <sys/io.h>

static void *tfn(void *d)
{
       struct sched_param schedp = {0};

       schedp.sched_priority = 1;
       assert(sched_setscheduler(0, SCHED_FIFO, &schedp) == 0);

       outb(0xFF, 0x378);

       return NULL;
}

int main(void)
{
       pthread_t t;

       assert(iopl(3) == 0);
       pthread_create(&t, NULL, tfn, NULL);
       pthread_join(t, NULL);

       return 0;
}
--->8---

-- 
Thanks,
//richard

