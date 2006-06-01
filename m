Message-ID: <447F5935.4090105@domain.hid>
Date: Thu, 01 Jun 2006 23:16:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xnpod help
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>	<17535.18007.179715.207040@domain.hid>	<447F49C8.4090609@domain.hid>
	<39455.155.98.4.39.1149195102.squirrel@domain.hid>
In-Reply-To: <39455.155.98.4.39.1149195102.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

Brandt Erickson wrote:
> I think there's a little bit of a misunderstanding.  I'm not trying to
> write my own skin.  I'm new to xenomai and I'm just trying write a simple
> kernel module that starts a periodic realtime thread. 

Ok, things get clearer. But why a kernel module? Are you *that* short on
CPU cycles? The overhead is rather low, see "latency -t0
-p<your-period>" vs. "latency -t1 -p<your-period>" on your box for a
comparison.

> Write now I'm just
> trying to have it write a simple message to printk but eventually I'm
> going to want it to write to a DAC to control a servo.  I've been browsing
> the xenomai API linked off the main website and I thought that using the
> nuclues was the prefered method for doing this but I get the feeling now
> that is not the case.  My ultimate goal is to have a realtime kernel-space
> thread that acts as a pid-controller that communicates and synchronizes
> with a non-realtime user-space application that displays pertinent
> information to the user.  How would you recommend going about doing that? 

In any case, do not use the nucleus directly. Its feasible, for sure,
but rather unhandy for application development. Take a look at the
native or the posix API instead.

Again, consider carefully if the inconvenience to go to kernel space is
really required. You will understand what I mean when you start thinking
about how to communicate between the RT and the Linux tasks.

Here is a simple native example which can easily be extended with
pthreads for non-RT jobs, or use main() directly:

#include <signal.h>
#include <sys/mman.h>
#include <native/task.h>

void demo(void *arg)
{
    rt_task_set_periodic(NULL, TM_NOW, 200000);
    while (1) {
        rt_task_wait_period(NULL);
        /* real-time jobs */
    }
}

void catch_signal(int sig) { }

int main(int argc, char* argv[])
{
    RT_TASK demo_task;

    signal(SIGINT, catch_signal);
    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_task_create(&demo_task, "mydemo", 0, 99, 0);
    rt_task_start(&demo_task, &demo, NULL);
    pause();
    rt_task_delete(&demo_task);
    return 0;
}

Jan

