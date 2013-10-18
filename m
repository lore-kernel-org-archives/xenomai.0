Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
Date: Fri, 18 Oct 2013 14:50:07 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 0 of 2] Xenomai-forge thread_obj: unset
 __THREAD_S_SAFE when not needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello list,

I believe that there is a problem in xenomai-forge when you create tasks
from within another task and the newly created tasks have a lower 
priority than the priority of the task where you created them from.

In the threadobj_start() function the thobj->status is set to 
__THREAD_S_STARTED|__THREAD_S_SAFE. After this there is a check if the 
thobj priority is lower or equal to the current thobj priority. If that 
is the case, it will return there. If it is not the case, 
synchronization needs to be done.

As far as I understand the code, however, I think that the 
__THREAD_S_SAFE is only set there because you don't want the 
finalize_thread to already clean up the thobj in case you are still 
waiting for the synchronization in the threadobj_start(). Correct?
If so then this is where I think there is a problem. In case that you 
don't need to wait for the synchronization and return already before it,
the __THREAD_S_SAFE is set but never unset. This has as result that in 
the finalize_thread() (on deletion) the destroy_thread() function will 
not be called, which has as consequence that proper clean up is not 
done. The first patch should fix this.

I came to this conclusion after investigating a segmentation fault on a 
test application that creates, starts and deletes tasks in a loop. I can 
reproduce the issue with the test code at the end of this post. In the 
code there is a main_task, with priority 90, from where the test_tasks 
are created, started and deleted. The priority of the test_tasks is 50. 

The result is that a lot of tasks created are not properly deleted. 
This causes (among maybe other things) a LOT of file descriptors staying 
open (4 per task I think). These file descriptors are created in the 
notifier_init() function by doing two pipe() syscalls. If this fails, an 
error is returned by notifier_init(). However the function 
threadobj_setup_corespec() does not check this. At a certain point, no 
more file descriptors are allowed on the process (max is 1024 here) and 
the pipe() call will fail. If this now happens on the creation of a task
with a higher priority than 90 (which is the last step in the test 
code), then threadobj will be properly deleted or attempt this at least. 
In the deletion, the notifier_destroy() function will be called. This 
will give a segmentation fault when trying to do pvlist_remove_init() as 
the notifier_init() function never ran completely in the first place 
(because of error on pipe()).   
To make sure that the fail on the pipe() call is seen, I created the 
second patch. There could be a better thing to do than sending a panic 
but at least you notice that there is a problem.

Regards,
Kim

 lib/copperplate/notifier.c  |  4 ++--
 lib/copperplate/threadobj.c |  4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)


test code snippet:

static void test_task(u_long a,u_long b,u_long c,u_long d)
{
  while (1)
    tm_wkafter(1000);
}

static void main_task(u_long a,u_long b,u_long c,u_long d)
{
  u_long tid,args[4] = {0,0,0,0};
  int i;
  char name[32];
  
  for (i=0;i<256;i++) {
    printf("counter i: %d\n", i);
    sprintf(name, "TEST_%d", i);
    t_create (name,50,0,0,0,&tid);
    t_start(tid,T_PREEMPT,test_task,args);
    t_delete(tid);
  }
  t_create ("FAIL",95,0,0,0,&tid);
  t_start(tid,T_PREEMPT,test_task,args);
  t_delete(tid);

  while (1) tm_wkafter(1000);
}

int main(int argc, char * const argv[])
{
  u_long tid,args[4] = {0,0,0,0};

  psos_long_names = 1;

  mlockall(MCL_CURRENT | MCL_FUTURE);
  copperplate_init(&argc,&argv);

  t_create("MAIN",90,0,0,0,&tid);
  t_start(tid,0,main_task, args);
  while (1) tm_wkafter(1000);
  return 0;
}



