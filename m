Message-ID: <47FE9AB9.6000702@domain.hid>
Date: Fri, 11 Apr 2008 07:54:49 +0900
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <000701c89a75$d349f630$9601a8c0@domain.hid>	
	<18429.6412.785941.128928@domain.hid>	
	<000801c89a89$b7b09820$9601a8c0@domain.hid>	
	<47FD650C.7030709@domain.hid>	
	<2ff1a98a0804100225q6e216a50nb0c7c78c86d8817c@domain.hid>	
	<47FE25EF.9070204@domain.hid>
	<2ff1a98a0804100843u4d4c20e5rd33f0b1c94f1e78a@domain.hid>
	<47FE993B.1020801@domain.hid>
In-Reply-To: <47FE993B.1020801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] mlockall questions
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> On Thu, Apr 10, 2008 at 4:36 PM, Philippe Gerum
>> <philippe.gerum@domain.hid> wrote:
>>> Gilles Chanteperdrix wrote:
>>>  > On Thu, Apr 10, 2008 at 2:53 AM, Philippe Gerum
>>>  > <philippe.gerum@domain.hid> wrote:
>>>  >> Robert McCullough wrote:
>>>  >>  > Hi Gilles,
>>>  >>  >
>>>  >>  >   --> -----Original Message-----
>>>  >>  >   --> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>>>  >>  >   --> Sent: Wednesday, April 09, 2008 3:29 PM
>>>  >>  >   --> To: rob@domain.hid
>>>  >>  >   --> Cc: xenomai@xenomai.org
>>>  >>  >   --> Subject: Re: [Xenomai-help] mlockall questions
>>>  >>  >   -->
>>>  >>  >   --> Robert McCullough wrote:
>>>  >>  >   -->  > Hi,
>>>  >>  >   -->  >
>>>  >>  >   -->  > I am converting part of a C++ application to real-time.
>>>  >>  >   -->  >
>>>  >>  >   -->  > I noticed that all the Xenomai examples call
>>>  >>  >   -->  > mlockall(MCL_CURRENT|MCL_FUTURE) at the beginning of main before
>>>  >>  >   --> creating
>>>  >>  >   -->  > any real-time threads.
>>>  >>  >   -->  > Is calling mlockall a requirement when using Xenomai?
>>>  >>  >   -->
>>>  >>  >   --> Yes it is.
>>>  >>  >   -->
>>>  >>  > [Robert McCullough]
>>>  >>  > OK.
>>>  >>  >   -->  >
>>>  >>  >   -->  > I have added a couple of Xenomai tasks to my C++ app.
>>>  >>  >   -->  > A) Without calling mlockall my application seems to run fine but I
>>>  >>  >   --> noticed
>>>  >>  >   -->  > in /proc/xenomai/stat that a few page faults occurred.
>>>  >>  >   -->
>>>  >>  >   --> Well normally your application should stop with a message telling you
>>>  >>  >   --> that you have not call mlockall. Do you happen to install a handler
>>>  >>  >   --> for
>>>  >>  >   --> SIGXCPU ?
>>>  >>  > [Robert McCullough]
>>>  >>  > Yes.
>>>  >>  >   -->
>>>  >>  >   -->  > B) When calling mlockall at the beginning of my main() I do not see
>>>  >>  >   --> any page
>>>  >>  >   -->  > faults but some of the C++ threads do not start.
>>>  >>  >   -->  >
>>>  >>  >   -->  > Why would mlockall cause some threads not to start?
>>>  >>  >   -->
>>>  >>  >   --> Well, you should check rt_task_create or pthread_create return
>>>  >>  >   --> value. The usual error is that you run out of memory because of the
>>>  >>  >   --> stack size problem explained in the TROUBLESHOOTING guide.
>>>  >>  >   -->
>>>  >>  >   --> --
>>>  >>  >   -->
>>>  >>  >   -->
>>>  >>  >   -->                                             Gilles.
>>>  >>  > [Robert McCullough]
>>>  >>  > Thanks.
>>>  >>  > Calling "ulimit -s 2048" before my application in my startup script seems to
>>>  >>  > work fine when I am running over nfs to the Denx ELDK with a bash shell.
>>>  >>  > But my application needs to run from a CompactFlash card running BusyBox on
>>>  >>  > a MPC5200 and BusyBox does not seem to support the "ulimit" command.
>>>  >>  > Is there another way to set this stack limit size?
>>>  >>  >
>>>  >>
>>>  >>  - Setting the stack size property into the attribute struct for each new pthread
>>>  >>  your application may create: pthread_attr_setstacksize(&thattr, stacksize);
>>>  >>
>>>  >>  - Or passing the right stack size value to any (non-POSIX) Xenomai API task
>>>  >>  creation service, we do enforce it (e.g. rt_task_create(), taskInit(),
>>>  >>  t_create()...).
>>>  >>
>>>  >>  - Or calling setrlimit(RLIMIT_STACK, ...) to set a global default value for all
>>>  >>  subsequent glibc-originated threads. This is what the ulimit command does, actually.
>>>  >
>>>  > The problem of pthread_attr_setstacksize (or of setting stack size in
>>>  > one of the various thread creation services) is that it does not work
>>>  > for the main thread stack. So, you have to use ulimit or to call
>>>  > setrlimit before running your application, in order to set the main
>>>  > thread stack size.
>>>  >
>>>  > Now about the ulimit builtin in busybox: busybox ash shell supports ulimit.
>>>  >
>>>
>>>  Even if you don't have any shell supporting ulimit, you just need to create a
>>>  small launcher that basically forks/setrlimit+execs your application.
>> Errr... but you need to call setrlimit before fork, otherwise it is too late...
>>
> 
> #include <sys/resource.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> 
> int main(int argc, char *argv[])
> {
> 	if (strcmp(argv[0], "child")) {
> 		struct rlimit r = { .rlim_cur = 32768, .rlim_max = 32768 };
> 		setrlimit(RLIMIT_STACK, &r);
> 		execl(argv[0], "child", NULL);
> 	} else {
> 		struct rlimit r;
> 		if (getrlimit(RLIMIT_STACK, &r) == 0)
> 			printf("%s: stack size = %d\n", argv[0], r.rlim_cur);
> 	}
> 
> 	return 0;
> }
> 

Just in case you don't think getrlimit() results also apply to the main thread:

#include <sys/resource.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	if (strcmp(argv[0], "child")) {
		struct rlimit r = { .rlim_cur = 32768, .rlim_max = 32768 };
		setrlimit(RLIMIT_STACK, &r);
		execl(argv[0], "child", NULL);
	} else {
		pthread_attr_t attr;
		size_t stacksize;
		void *stackbase;

		if (!pthread_getattr_np(pthread_self(), &attr)) {
			pthread_attr_getstack(&attr, &stackbase, &stacksize);
			printf("stacksize = %lu\n", stacksize);
		}
	}

	return 0;
}

-- 
Philippe.

