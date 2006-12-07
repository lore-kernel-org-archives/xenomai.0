MIME-Version: 1.0
Message-ID: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Date: Thu, 7 Dec 2006 14:09:07 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: [Xenomai-core] [BUG] module usage counter of xenomai native
 corrupted (version 2.2.0 and 2.2.5)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

there seems to be a bug in rt_task_create(). When no more memory is
available, the module usage counter of xeno_native is decremented. I
guess it is not incremented before, however, so the counter gets 0 and
wraps then to a negative number. It is therefore not possible to remove
the module.

I appended a small program to demonstrate this. It simply eats up all
memory from xenomai by registering as much mutexes as possible,
and then tries to execute rt_task_create(), which fails. When started
again, the bug occurs at rt_task_shadow(), as the mutexes have never
been deleted.
Compile with  gcc -O2 -Wall `xeno-config --xeno-cflags` `xeno-config
 --xeno-ldflags` -lrtdm -lnative -o rttest rttest.c
then simply run it, and watch the output of lsmod before and after.

Tested with xenomai 2.2.{0,5} and linux 2.6.17.8, modules loaded:
xeno_native and xeno_nucleus.


Thomas Wiedemann


----
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>


static RT_TASK child, parent;

/* the entry point of the child process */
void childfn(void *cookie) {
        while(1) {
                rt_task_sleep(1000000000L);
                fprintf(stderr, "  hello, i'm the child.\n");
        }
}


int main(int argc, char *argv[]) {
        int num=0;

        mlockall(MCL_CURRENT|MCL_FUTURE);

        /* rt_task_shadow() can be ommitted, the bug still occurrs */
        if((num=rt_task_shadow(&parent,"rtserialtest",50,0))!=0) {
                fprintf(stderr,"Error creating rt task: %i ('%s')!\n", 
num, strerror(-num));
                exit(0);
        }

 
        fprintf(stderr, "Clobbering all mutexes... \n");
        while(1) {
                int i;
                RT_MUTEX m;
                if((i=rt_mutex_create(&m,NULL))<0) {
                        fprintf(stderr,"  -> After creating %i mutexes: 
Error <%i> ('%s')\n",num,i,strerror(-i));
                        break;
                }
                num++;
        }
 
        fprintf(stderr, "Creating child process ...\n");
        num=rt_task_create(&child, "rt_mutex_clobber_child", 0, 50, 0);
        if(num != 0) {
                fprintf(stderr, "  -> rt_task_create: failed: 
%s\n",strerror(-num));
        } else {
                fprintf(stderr, "  -> rt_task_create: OK! no bug.!\n");
        }
 
        return 0;
}

----

