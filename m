MIME-Version: 1.0
Sender: andret7@gmail.com
From: Andrea <andrea.schiappacasse@camelotbio.com>
Date: Tue, 19 Apr 2016 16:08:01 +0200
Message-ID: <CAMQ-e4-eJ+Ahb2c4BaZQWfey8WFbEevRzOxTJNgSXNj6RYj=eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  trying to shadow a pthread fails with -EINVAL error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

I'm currently trying to integrate Xenomai 3.0.2 using Cobalt with alchemy
skin in a C++  project, under kernel 4.1.8  with i-pipe patch.

In my application I'm creating some threads using boost library, and I
would like to shadow one of them to a rt_task in order to use some xenomai
function in there.

If I call rt_task_shadow(NULL, NULL, 0,0) from the running thread, -EINVAL
is returned.

While the API docs says that this can be due to an invalid prio, tracking
down the source of the error, it appears that in my case it is generated in
the function syncobj_lock (copperplate/syncobj.c), where a call to
monitor_enter (which internally calls cobalt_monitor_enter) fails and
returns -1.

The same happens with threads created both using standard pthread_create or
via the boost library.

Trying to shadow the main thread (or creating rt_task from there) works
correctly. instead.

A reproducible example in my system:

#include "pthread.h"
#include "alchemy/task.h"
#include <iostream>
#include <unistd.h>

void* shadow(void*)
{
    std::cerr<<"Shadow returned "<< rt_task_shadow(NULL, NULL, 0,0);
}

int main(int argc, char* argv[])
{
    pthread_t test_thread;
   // new boost::thread(shadow);
    pthread_create(&test_thread, NULL, shadow, NULL);
    sleep(10);

    return 0;
}

with output: Shadow returned -22

Do you have any insight on where the problem could be? Am I missing
something basic?

If possible, I would like to stick to alchemy skin.

Thank you in advance for your help,

Andrea
