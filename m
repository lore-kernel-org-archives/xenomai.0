From: Peter Laurich <Peter.Laurich@akamina.com>
Subject: Accessing a mutex from different programs
Message-ID: <c1062c1f-f95e-8816-3caf-d78290f3bb63@akamina.com>
Date: Fri, 12 Feb 2021 09:57:20 -0500
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

Hello,

I am in the process of migrating from Xenomai 2 to 3.1. I have existing 
code with programs as individual c files where each file has a mainline 
that then creates a task (rt_task_spawn()). The task spawn part is 
working fine but I can not seem to access a mutex created in one task 
from another task. This worked flawlessly in Xenomai 2 but I have 
something not quite right now.

Here are some more details:

  - I have two test programs: mutexTest1.c and mutexTest2.c

  - the rt_task in mutexTest1.c successfully calls rt_mutex_create() 
followed by rt_mutex_bind(). A test by calling rt_mutex_acquire() 
followed by rt_mutex_release() also work so the mutex can be acquired 
and released within the same program.  This task then goes into a sleep 
loop.

  - I then start mutexTest2 which calls rt_mutex_bind() looking for the 
named mutex that was created in mutexTest1; the bind has a TM_INFINITE 
timeout. This call to bind never returns.

I have searched extensively for configure options and other postings. I 
thought --enable-pshared would help but it did not. I don't think that 
--enable-registry will do anything to make this possible but it would 
allow me to see the mutex object and verify that it was created.

The wiki states "Mutexes can be shared by multiple processes which 
belong to the same Xenomai session." but I can't find a definition of 
what a Xenomai session is.

I am running on an ARM target and the Xenomai test program latency works.

Any suggestions would be appreciated.

Thanks

Peter

