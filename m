From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
Content-Type: multipart/mixed; boundary="=-lXvOaunfUHm0thvRSyLD"
Date: Tue, 17 Aug 2010 14:25:38 +0200
Message-Id: <1282047938.5255.89.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--=-lXvOaunfUHm0thvRSyLD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

I found recently that large application uses to segfault before fork()
leaves its glibc wrapper.

I included here a test suite which can be easily used to verify what
goes wrong. It may be necessary to adjust makefile to compile the code.
So, the console is missing output from line #89. We can see instead a
message that getpid couldn't be linked which is 1st sign of memory
corruption.

i used to think that this issue could be related to not unbinding heap
before fork() but it turned out that it is enough to link userspace with
xenomai libraries.

I wonder if this is known issue and if there is any fix, does 2.5.4 work
same ? or maybe there is something wrong with the kernel i use (or adeos
patch)

Another question is why rt_task_create() is marked deprecated in native
skin. Does it mean that native skin is going to be removed from source
tree ?

Regards,

-- 
Krzysztof Blaszkowski

--=-lXvOaunfUHm0thvRSyLD
Content-Type: application/x-shellscript; name=".try.sh"
Content-Disposition: attachment; filename=".try.sh"
Content-Transfer-Encoding: 7bit


	insmod ./xeno_shmem_test.ko
	sleep .1
	LD_LIBRARY_PATH=`pwd` ./xeno-shmem-fork
	sleep .1
	rmmod xeno_shmem_test

--=-lXvOaunfUHm0thvRSyLD
Content-Disposition: attachment; filename="console.log"
Content-Type: text/x-log; name="console.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

atest:~/xeno-test # ./.try.sh
main:78 heap 0x401be000
/root/xeno-test
main:88
./xeno-shmem-fork: relocation error: ./xeno-shmem-fork: symbol getpid, version GLIBC_2.0 not defined in file libc.so.6 with link time reference
main:95 [2234] pid 2236
main:98 [2234] pid 2236, status 00007f00
main:99 [2234] pid 2236, WIFSIGNALED 0, WIFEXITED 1, rc 127
4
atest:~/xeno-test #
--=-lXvOaunfUHm0thvRSyLD
Content-Disposition: attachment; filename="Makefile"
Content-Type: text/x-makefile; name="Makefile"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


export KERNELDIR ?= $(shell pwd)/../kernel
XENODIR = $(KERNELDIR)/INSTALL/xeno/usr/xenomai


obj-m = xeno_shmem_test.o
xeno_shmem_test-objs = xeno-shmem-fork.o

EXTRA_CFLAGS = -I$(XENODIR)/include
U_LDFLAGS = -lnative -lxenomai -L$(XENODIR)/lib -D_XENO_SHMEM_

all: xmodule userland

xmodule: xeno-shmem-fork.c
	$(MAKE) -C $(KERNELDIR) SUBDIRS=`pwd` V=0 -o $(KERNELDIR)/Module.symvers modules 
	
userland: xeno-shmem-fork.c
	gcc xeno-shmem-fork.c $(EXTRA_CFLAGS) $(U_LDFLAGS) -o xeno-shmem-fork
#	gcc xeno-shmem-fork.c $(EXTRA_CFLAGS)  -o xeno-shmem-fork
	

give-a-try:
	insmod ./xeno_shmem_test.ko
	sleep .1
	LD_LIBRARY_PATH=`pwd` ./xeno-shmem-fork
	sleep .1
	rmmod xeno_shmem_test
	





--=-lXvOaunfUHm0thvRSyLD
Content-Disposition: attachment; filename="xeno-shmem-fork.c"
Content-Type: text/x-csrc; name="xeno-shmem-fork.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/* xenomai/native - fork() regression test
    Systemy mikroprocesorowe 2010
*/


#include <native/heap.h>


#define TEST_HEAP "0x12345"

#ifdef __KERNEL__
#include <linux/module.h>

MODULE_LICENSE("GPL");

#define HEAP_SIZE (16*1024)

RT_HEAP heap_desc;
void *ptr;

int init(void)
{
    int err;

    err = rt_heap_create(&heap_desc, TEST_HEAP , HEAP_SIZE, H_SHARED);
    if (!err) {
	    err = rt_heap_alloc(&heap_desc, 0, TM_NONBLOCK, &ptr);
    }
    
    printk("%s:%d heap %p, rc %d\n", __FUNCTION__, __LINE__, ptr, err);

    return err;
}

void exit(void)
{
    printk("%s:%d heap %p\n", __FUNCTION__, __LINE__, ptr);
    rt_heap_delete(&heap_desc);
}

module_init(init);
module_exit(exit);


#else

#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>

RT_HEAP heap_desc;

void *shared_mem; /* Start address of the shared memory segment */

/* A shared memory segment with Xenomai is implemented as a mappable
   real-time heap object managed as a single memory block. In this
   mode, the allocation routine always returns the start address of
   the heap memory to all callers, and the free routine always leads
   to a no-op. */

#define EXIT_RC 11
int main (int argc, char *argv[])

{
    int err;
    int pid;

#ifdef _XENO_SHMEM_
    err = rt_heap_bind(&heap_desc,  TEST_HEAP ,TM_NONBLOCK);
    if (err)
	return 1;

    if (rt_heap_alloc(&heap_desc,0,TM_NONBLOCK,&shared_mem))
	return 2;

#endif
	
    printf("%s:%d heap %p\n", __FUNCTION__, __LINE__, shared_mem);
    system("pwd");

    pid = fork();
    if (pid < 0) {
	printf("%s:%d errno %d\n", __FUNCTION__, __LINE__, errno);
	return 3;
    }
    
    if (pid == 0) {
	printf("%s:%d\n",  __FUNCTION__, __LINE__);
	printf("%s:%d [%d] pid %d\n", __FUNCTION__, __LINE__, getpid(), pid);
	sleep(1);
	exit(EXIT_RC);
    } else {
	int s;

	printf("%s:%d [%d] pid %d\n", __FUNCTION__, __LINE__, getpid(), pid);

	waitpid(pid, &s, 0);
	printf("%s:%d [%d] pid %d, status %08x\n", __FUNCTION__, __LINE__, getpid(), pid, s);
	printf("%s:%d [%d] pid %d, WIFSIGNALED %u, WIFEXITED %u, rc %u\n", __FUNCTION__, __LINE__, getpid(), pid, 
	    WIFSIGNALED(s), WIFEXITED(s), WEXITSTATUS(s));
	err = (!WIFSIGNALED(s) && WIFEXITED(s) && (WEXITSTATUS(s) == EXIT_RC)) ? 0 : 4;
    }

#ifdef _XENO_SHMEM_
    rt_heap_unbind(&heap_desc);
#endif    
    printf("%d\n", err);

    return err;
}


#endif


--=-lXvOaunfUHm0thvRSyLD--


