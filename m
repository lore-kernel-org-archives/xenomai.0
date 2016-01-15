From: Thomas Axelsson <Thomas.Axelsson@cybercom.com>
Date: Fri, 15 Jan 2016 16:34:24 +0000
Message-ID: <08349b9576164b1daad6e10748bdc0be@mmambx3.global.ad>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai-3.0.1 inter-process rt_queue_receive segfault
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Max Popescu <Max.Popescu@cybercom.com>

Hi,

We are trying to use Alchemy RT Message Queues between two different 
processes in Xenomai 3.0.1. However, our receiving process segfaults 
when it receives a message. Using gdb, we see that the SIGSEGV occurs in 
rt_queue_receive_timed() when doing  "ret = (ssize_t)msg->size;" 
(queue.c:851). Can you help us solve the problem?

We use the queue as follows:
1. rx is started and creates queue
2. rx does a blocking receive
3. tx is started and binds to the queue
4. tx sends a message to the queue
5. rx crashes

(Code for rx and tx attached)

We have found that if we delay the receive in rx, allowing tx 
rt_queue_send to queue the message, rx can receive the message 
correctly. So it looks like the "non-queue" path in rt_queue_send in 
queue.c leads to the problem.

We only see the problem when trying to communicate between two binaries. 
When running rx and tx as tasks in the same process, the code works 
fine. Also, mutexes between two binaries work.

If we run both processes in GDB, the communication works. If only rx is 
run in GDB, we catch the SIGSEGV.

The binaries can communicate without problems in Xenomai 2.6.4 on kernel 
3.14.17, if we make sure to have unique names for the queues and tasks 
(this does not solve the problem seen with Xenomai 3.0.1). 

Architecture: x86_64
Kernel: Vanilla linux-3.14.39 patched using prepare-kernel.sh (kernel 
config attached) (Also tested on linux-3.18.20)
Xenomai: 3.0.1
I-pipe release: 9

Boot line:
linux16 /vmlinuz-3.14.39-xenomai root=/dev/mapper/centos-root ro 
rd.lvm.lv=centos/root rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet 
LANG=en_US.UTF-8 systemd.debug

We have tried with the default heap sizes and (currently):
CONFIG_XENO_OPT_SYS_HEAPSZ=1024
CONFIG_XENO_OPT_PRIVATE_HEAPSZ=10240
CONFIG_XENO_OPT_SHARED_HEAPSZ=10240

We have also tried with --mem-pool-size=1M and 500M.

(I forgot to copy our message to the rt queue buffer in the code, when I 
stripped down our binaries to minimal cases, but the message was copied 
in our original code, which crashed in the same way. I also realize that 
the printouts below have the current RTIME written after taking and 
before releasing the queue lock, which is due to adding two printf to 
queue.c. No other patching of Xenomai has been done and the problem 
occurred when all code was unmodified.)

Best Regards
Thomas Axelsson and Max Popescu


Test run
----------------
$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib ./rx --session=s
   0"002.712| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
Created task
Created new queue
rt_queue_receive_timed locked 3259034025576
[ waits until I run sender, then dies ]
$

$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib ./tx --session=s
   0"001.767| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
rt_queue_send locked 3259033975244
rt_queue_send unlock 3259034012060
Created task
Bound to queue
buf=0x7fad8a9530c0
Awoken 1 receivers
$

dmesg output:
[ 3243.901520] SELinux: initialized (dev fuse, type fuse), uses 
genfs_contexts
[ 3247.496643] SELinux: initialized (dev fuse, type fuse), uses 
genfs_contexts
[ 3247.497294] receiver[19328]: segfault at 7fad8a9530a0 ip 
00007ff2f4469e1d sp 00007ffe87433990 error 4 in 
libalchemy.so.0.0.0[7ff2f445e000+15000]


Test run, both processes run with GDB
----------------
$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib gdb ./rx
Reading symbols from /home/lteuser/rt_apps2/rx...done.
(gdb) set args --session=d1
(gdb) r
Starting program: /home/lteuser/rt_apps2/./rx --session=d1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[New Thread 0x7ffff5756700 (LWP 19502)]
Detaching after fork from child process 19503.
[New Thread 0x7ffff7ff4700 (LWP 19508)]
[New Thread 0x7ffff7eb7700 (LWP 19509)]
   0"206.922| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
Created task
Created new queue
rt_queue_receive_timed locked 3609975957954
rt_queue_receive_timed unlock 3609976025968
Pointer=0x7ffff4a3e0c0
Received message  7

$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib gdb ./tx
Reading symbols from /home/lteuser/rt_apps2/tx...done.
(gdb) set args --session=d1
(gdb) r
Starting program: /home/lteuser/rt_apps2/./tx --session=d1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[New Thread 0x7ffff5756700 (LWP 19514)]
[New Thread 0x7ffff7ff4700 (LWP 19515)]
[New Thread 0x7ffff7eb7700 (LWP 19516)]
   0"006.005| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
rt_queue_send locked 3609975901548
rt_queue_send unlock 3609975946944
Created task
Bound to queue
buf=0x7ffff4a3e0c0
Awoken 1 receivers
[Thread 0x7ffff7eb7700 (LWP 19516) exited]
[Thread 0x7ffff5756700 (LWP 19514) exited]
[Thread 0x7ffff7fdb740 (LWP 19510) exited]
[Inferior 1 (process 19510) exited normally]
(gdb)



Test run, running only rx in GDB
----------------
$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib ./tx  --session=d1
   0"002.694| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
rt_queue_send locked 3944831651465
rt_queue_send unlock 3944831697515
Created task
Bound to queue
buf=0x7fa37f742180
Awoken 1 receivers

$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib gdb ./rx
Starting program: /home/lteuser/rt_apps2/./rx --session=d1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[New Thread 0x7ffff5756700 (LWP 1345)]
[New Thread 0x7ffff7ff4700 (LWP 1347)]
[New Thread 0x7ffff7eb7700 (LWP 1348)]
   0"011.038| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
Created task
Created new queue
rt_queue_receive_timed locked 3983663928231

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7bcfe1d in rt_queue_receive_timed (queue=0x7fffffffe3c0, 
bufp=0x7fffffffe3b8, abs_timeout=0x0) at ../../../lib/alchemy/queue.c:851
851                     ret = (ssize_t)msg->size;
(gdb)

$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib ./tx  --session=d1
   0"016.110| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected 
[--enable-debug=full]
rt_queue_send locked 3983663867499
rt_queue_send unlock 3983663913026
Created task
Bound to queue
buf=0x7f0cc69270c0
Awoken 1 receivers


Boot dmesg output for Xenomai
---------------
$ dmesg | grep -i xeno
[    0.000000] Linux version 3.14.39-xenomai (user@sunk) (gcc version 
4.8.3 20140911 (Red Hat 4.8.3-9) (GCC) ) #1 SMP PREEMPT Fri Jan 15 
12:34:35 CET 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.14.39-xenomai 
root=/dev/mapper/centos-root ro rd.lvm.lv=centos/root 
rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet LANG=en_US.UTF-8 
systemd.debug
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.14.39-xenomai 
root=/dev/mapper/centos-root ro rd.lvm.lv=centos/root 
rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet LANG=en_US.UTF-8 
systemd.debug
[    0.999706] [Xenomai] scheduling class idle registered.
[    0.999707] [Xenomai] scheduling class rt registered.
[    0.999725] [Xenomai] disabling automatic C1E state promotion on 
Intel processor
[    0.999744] [Xenomai] SMI-enabled chipset found, but SMI workaround 
disabled
          (see xenomai.smi parameter). You might encounter
[    0.999775] I-pipe: head domain Xenomai registered.
[    1.002126] [Xenomai] Cobalt v3.0.1 (Exact Zero) [DEBUG]
[    1.184680] usb usb1: Manufacturer: Linux 3.14.39-xenomai ehci_hcd
[    1.194673] usb usb2: Manufacturer: Linux 3.14.39-xenomai ehci_hcd
*** RTnet for Xenomai v3.0.1 ***
$


Xenomai configuration
---------------
$ sudo LD_LIBRARY_PATH=/usr/xenomai/lib ./rx --dump-config
based on Xenomai/cobalt v3.0.1
CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_BUILD_ARGS=" '--enable-pshared' '--enable-registry' 
'--enable-smp' '--enable-debug=full'"
CONFIG_XENO_BUILD_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 4.8.3 20140911 (Red Hat 4.8.3-9) (GCC) "
CONFIG_XENO_DEBUG=1
CONFIG_XENO_DEBUG_FULL=1
CONFIG_XENO_DEFAULT_PERIOD=100000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr/xenomai"
CONFIG_XENO_PSHARED=1
CONFIG_XENO_RAW_CLOCK_ENABLED=1
CONFIG_XENO_REGISTRY=1
CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
CONFIG_XENO_REVISION_LEVEL=1
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=14
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_VERSION_NAME="Exact Zero"
CONFIG_XENO_VERSION_STRING="3.0.1"
CONFIG_XENO_X86_VSYSCALL=1
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=65536
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 3.14.39-xenomai.config
Type: application/octet-stream
Size: 129562 bytes
Desc: 3.14.39-xenomai.config
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160115/5f6bbad5/attachment.obj>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: rx.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160115/5f6bbad5/attachment.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: tx.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160115/5f6bbad5/attachment-0001.c>
