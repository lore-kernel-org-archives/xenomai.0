From: Christoph Permes <christoph.permes@domain.hid>
Date: Tue, 08 Sep 2009 16:38:09 +0200
Message-Id: <1252420689.4304.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Xenomai-help] rt_heap cleanup issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I have a kernel module that allocates a shared memory and a non-realtime
userspace application that reads data from the shared memory.

When loading and unloading kernel module and application multiple times,
sometimes the shared memory is not cleaned up. The shared memory remains
in /proc/xenomai/registry/native/heaps with size=0. A try to load the
module again results in a kernel null pointer exception.

I have written a small example to reproduce the issue:

/* kernel module */
#include <linux/module.h>

#include <native/heap.h>

#define MY_SHARED_MEMORY_SIZE (1024 * 1024)

// shared memory descriptor
static RT_HEAP my_heap_desc;

// global shared memory pointer
void* my_shm_pointer = NULL;

int init_module()
{
    char heap_name[] = "MY_SHARED_MEMORY";
    int result;

    // create the heap descriptor
    result = rt_heap_create( &my_heap_desc, heap_name, MY_SHARED_MEMORY_SIZE, H_SHARED );
    if ( result != 0 ) {
        printk( KERN_ERR "Failed to create shared memory %s: %d\n", heap_name, result );
        goto cleanup_return;
    }

    // allocate memory
    result = rt_heap_alloc( &my_heap_desc, 0, TM_NONBLOCK, &my_shm_pointer );
    if ( ( result != 0 ) || ( my_shm_pointer == NULL ) ) {
        printk( KERN_ERR "KEC::SHM: Failed to allocate base shared memory %s: %d\n", heap_name, result );
        goto cleanup_heap;
    }

    // initialize base memory
    memset( my_shm_pointer, 0, MY_SHARED_MEMORY_SIZE );

    printk( KERN_INFO "Shared memory %s opened (0x%08x).\n", heap_name, (unsigned int)my_shm_pointer );


    return 0;

 cleanup_heap:
    my_shm_pointer = NULL;
    rt_heap_delete( &my_heap_desc );

 cleanup_return:

    return -1;
}

void cleanup_module()
{
    int result = 0;

    // delete heap descriptor
    my_shm_pointer = NULL;

    result = rt_heap_delete( &my_heap_desc );

    printk( KERN_INFO "Shared memory closed (%d).\n", result );
}


/* userspace application */
#include <signal.h>
#include <stdio.h>

#include <native/heap.h>

int my_stop = 0;

void my_signal_handler(int);

int main()
{
  char heap_name[] = "MY_SHARED_MEMORY";
  RT_HEAP my_heap;
  void* my_shm_pointer = NULL;
  int result = 0;


  signal( SIGTERM, my_signal_handler );
  signal( SIGINT, my_signal_handler );

  result = rt_heap_bind( &my_heap, heap_name, TM_NONBLOCK );
  if ( result != 0 ) {
    printf( "rt_heap_bind() returned %d\n", result );
    return -1;
  }

  result = rt_heap_alloc( &my_heap, 0, TM_NONBLOCK, &my_shm_pointer );
  if ( result != 0 ) {
    printf( "rt_heap_alloc() returned %d\n", result );
    rt_heap_unbind( &my_heap );
    return -1;
  }

  while ( !my_stop ) {
    sleep( 1 );
  }

  my_shm_pointer = NULL;
  rt_heap_unbind( &my_heap );

  return 0;
}

void my_signal_handler(int sig)
{
    my_stop = 1;
}


I'm using kernel 2.6.29.5, Xenomai 2.4.9 on x86.

The steps to reproduce the issue are:
# insmod my_shm.ko
# ./my_shm &
# rmmod my_shm
# killall my_shm
# insmod my_shm.ko
# ./my_shm &
# rmmod my_shm
# killall my_shm
# cat /proc/xenomai/registry/native/heaps/MY_SHARED_MEMORY
type=kernel:size=0:used:0:numaps=0    <--- strange
# insmod my_shm.ko   <--- null pointer exception, system freeze

There is no null pointer exception when killing the application before
rmmod.

Is it generally a problem if kernel modules are unloaded before all
applications that use the shared memory are terminated?
With userspace realtime applications cleanup works without any problems
regardless of the order the applications are started/terminated.
Maybe I am doing something wrong in the example code above?

As my real application consists of several userspace applications
(realtime and non-realtime) the startup and shutdown procedure is more
complex so that it is not guaranteed that all userspace applications are
finished when the kernel module is unloaded.

Thanks,

Christoph



