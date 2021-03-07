From: Peter Laurich <Peter.Laurich@akamina.com>
Subject: Differences in mode switching depending on single program vs two
 program testing
Message-ID: <f181fe8c-58be-628c-c555-093bdb9829d9@akamina.com>
Date: Sun, 7 Mar 2021 18:13:56 -0500
MIME-Version: 1.0
Content-Language: en-CA
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I am seeing significant differences in behaviour depending on whether I 
spawn 2 Xenomai tasks from one program vs two programs. The 2 Xenomai 
tasks that I spawn from the one program are line-for-line identical to 
the 2 tasks that I spawn from two programs. The version where a single 
mainline spawns 2 tasks produces the following output:

_*Single Mainline:*_

root@AKASRV:~$ dmesg | grep Xenomai
[Xenomai] scheduling class idle registered.
[Xenomai] scheduling class rt registered.
I-pipe: head domain Xenomai registered.
[Xenomai] allowing access to group 1100
[Xenomai] Cobalt v3.1 [DEBUG]
[Xenomai] switching Test1 to secondary mode after exception #1 from 
user-space at 0x76ce932c (pid 313)

root@AKASRV:~$ cat /proc/xenomai/sched/stat
CPU  PID    MSW        CSW        XSC        PF    STAT %CPU  NAME
   0  0      0          82         0          0     00218000 99.7  [ROOT/0]
   1  0      0          0          0          0     00218000 100.0  [ROOT/1]
   0  311    43         47         139        0     002680c0 0.0  
mutexOneFileTes
   0  313    13         22         39         1     00248044 0.0  Test1
   0  314    11         19         31         0     00248044 0.0  Test2
   0  0      0          169036     0          0     00000000 0.3  
[IRQ16: [timer]]
   1  0      0          5458       0          0     00000000 0.0  
[IRQ16: [timer]]

_*Two Mainlines:*_

The version where 2 mainlines each spawn 1 task each produces the 
following output:

root@AKASRV:~$ dmesg | grep Xenomai
[Xenomai] scheduling class idle registered.
[Xenomai] scheduling class rt registered.
I-pipe: head domain Xenomai registered.
[Xenomai] allowing access to group 1100
[Xenomai] Cobalt v3.1 [DEBUG]
[Xenomai] switching mutexTest2 to secondary mode after exception #1 from 
user-space at 0x76ec2d2e (pid 318)
[Xenomai] switching mutexTest2 to secondary mode after exception #1 from 
user-space at 0x76eef642 (pid 318)
[Xenomai] switching mutexTest2 to secondary mode after exception #1 from 
user-space at 0x76eee5aa (pid 318)
[Xenomai] switching mutexTest2 to secondary mode after exception #1 from 
user-space at 0x76ec9eee (pid 318)
[Xenomai] switching Test2 to secondary mode after exception #1 from 
user-space at 0x76eee5aa (pid 321)

root@AKASRV:~$ cat /proc/xenomai/sched/stat
CPU  PID    MSW        CSW        XSC        PF    STAT %CPU  NAME
   0  0      0          60         0          0     00218000 99.7  [ROOT/0]
   1  0      0          45         0          0     00218000 100.0  [ROOT/1]
   0  313    40         43         126        0     002680c0 0.0  mutexTest1
   0  315    1          3          8          0     00240042 0.0  
remote-agent
   0  316    11         18         37         0     00248044 0.0  Test1
   1  318    25         28         66         4     002680c0 0.0  mutexTest2
   1  320    1          3          8          0     00240042 0.0  
remote-agent
   1  321    11         18         31         1     00248044 0.0  Test2
   0  0      0          164476     0          0     00000000 0.3  
[IRQ16: [timer]]
   1  0      0          5324       0          0     00000000 0.0  
[IRQ16: [timer]]

Does anyone have any ideas why the behaviour would be different if I 
spawn the 2 tasks from 1 mainline vs 2 mainlines?

Also, any thoughts as to why a rt_mutex_bind() that causes a task switch 
would apparently result in a page fault?

Some additional information:

  * I do run the two mainline test case with the same Xenomai session by
    using the --session=aka argument when they are started
  * I do have Xenomai built with full debugging enabled so I can get
    more debug information
  * I am using Xenomai 3.1 with Linux kernel 4.19.144 on a Arm Cortex-A9
    platform
  * I got to these tests after chasing page faults for a few days. You
    can see 1 page fault in Test1 in the stat output for the single
    mainline case; I also see this page fault when using Linux to
    capture page fault information after each Xenomai call. In the
    single mainline case, the page fault occurs when the mutex that
    Test2 is waiting for (rt_mutex_bind()) is created by Test1 causing a
    task switch from Test1 to Test2.
  * In the two mainline case, there are 4 page faults in the mainline
    that spawns Test2 and then another page fault in Test2. Using the
    Linux captures, I see that there are multiple page faults during
    each rt_task_create() call - typically around 17 using Linux
    captures. I have no idea why Xenomai stat reports 0 page faults in 2
    of the 3 mainlines (mutexOneFileTest & mutexTest1) and 4 in the 3rd
    mainline (mutexTest2). The Linux fault capture of task Test2 also
    shows 1 page fault caused by the processing of the rt_mutex_bind()
    where Test2 is waiting for Test1 to create the mutex (rt_mutex_create())

I've chased this problem for many days and am out of ideas to try. Any 
suggestions would be gratefully appreciated.

Thanks

Peter

P.S. I am happy to post the C code if it is of use. I have 3 mainline C 
files and 2 C files containing the Xenomai task code. The mainlines 
#include the task C files so that I am guaranteed that the Xenomai tasks 
are identical.



