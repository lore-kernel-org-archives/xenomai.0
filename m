Message-ID: <47FD650C.7030709@domain.hid>
Date: Thu, 10 Apr 2008 09:53:32 +0900
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <000701c89a75$d349f630$9601a8c0@domain.hid>	<18429.6412.785941.128928@domain.hid>
	<000801c89a89$b7b09820$9601a8c0@domain.hid>
In-Reply-To: <000801c89a89$b7b09820$9601a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mlockall questions
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org

Robert McCullough wrote:
> Hi Gilles,
> 
>   --> -----Original Message-----
>   --> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>   --> Sent: Wednesday, April 09, 2008 3:29 PM
>   --> To: rob@domain.hid
>   --> Cc: xenomai@xenomai.org
>   --> Subject: Re: [Xenomai-help] mlockall questions
>   --> 
>   --> Robert McCullough wrote:
>   -->  > Hi,
>   -->  >
>   -->  > I am converting part of a C++ application to real-time.
>   -->  >
>   -->  > I noticed that all the Xenomai examples call
>   -->  > mlockall(MCL_CURRENT|MCL_FUTURE) at the beginning of main before
>   --> creating
>   -->  > any real-time threads.
>   -->  > Is calling mlockall a requirement when using Xenomai?
>   --> 
>   --> Yes it is.
>   --> 
> [Robert McCullough] 
> OK.
>   -->  >
>   -->  > I have added a couple of Xenomai tasks to my C++ app.
>   -->  > A) Without calling mlockall my application seems to run fine but I
>   --> noticed
>   -->  > in /proc/xenomai/stat that a few page faults occurred.
>   --> 
>   --> Well normally your application should stop with a message telling you
>   --> that you have not call mlockall. Do you happen to install a handler
>   --> for
>   --> SIGXCPU ?
> [Robert McCullough] 
> Yes.
>   --> 
>   -->  > B) When calling mlockall at the beginning of my main() I do not see
>   --> any page
>   -->  > faults but some of the C++ threads do not start.
>   -->  >
>   -->  > Why would mlockall cause some threads not to start?
>   --> 
>   --> Well, you should check rt_task_create or pthread_create return
>   --> value. The usual error is that you run out of memory because of the
>   --> stack size problem explained in the TROUBLESHOOTING guide.
>   --> 
>   --> --
>   --> 
>   --> 
>   --> 					    Gilles.
> [Robert McCullough] 
> Thanks.
> Calling "ulimit -s 2048" before my application in my startup script seems to
> work fine when I am running over nfs to the Denx ELDK with a bash shell.
> But my application needs to run from a CompactFlash card running BusyBox on
> a MPC5200 and BusyBox does not seem to support the "ulimit" command.
> Is there another way to set this stack limit size?
> 

- Setting the stack size property into the attribute struct for each new pthread
your application may create: pthread_attr_setstacksize(&thattr, stacksize);

- Or passing the right stack size value to any (non-POSIX) Xenomai API task
creation service, we do enforce it (e.g. rt_task_create(), taskInit(),
t_create()...).

- Or calling setrlimit(RLIMIT_STACK, ...) to set a global default value for all
subsequent glibc-originated threads. This is what the ulimit command does, actually.

-- 
Philippe.

