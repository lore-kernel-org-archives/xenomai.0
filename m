From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <515034A5-8E42-4ACC-B08E-FC8A05DEB293@domain.hid>
References: <515034A5-8E42-4ACC-B08E-FC8A05DEB293@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 16 Oct 2010 10:48:58 +0200
Message-ID: <1287218938.1854.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] hanging in Xenomai 2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-10-15 at 22:43 -0700, Stefan Schaal wrote:
> Hi everybody,
> 
>   here is a quick first report on an issue that appeared with Xenomai 2.5.5 --- NOTE: 2.5.4 (and earlier) DOES NOT have this issue.
> 
> We run multiple real-time processes, synchronized by semaphores and interprocess communication using shared memory. All is cleanly implemented using the xenomai real-time functions, no mode switches. The different processes are distributed on different processors of our multi-core machine using rt_task_spawn() with the T_CPU directive. 
> 
> Up to version 2.5.4, this worked fine.
> 
> With version 2.5.5 (and 2.5.5.1), the processes hang after a few seconds of running (CPU consumption goes to zero), and usually one of them hangs so badly that it cannot be killed anymore with kill -9 -- thus reboot is required.
> 
> The problems happens on BOTH our i386 machine (Dell 8-core, ubuntu 9.04, kernel 2.6.29.5) AND x86_64 machine (Dell 8 core, ubuntu 9.10, kernel 2.6.31.4). Thus, this seems to be specific to the xenomai release 2.5.5 and higher.
> 
> No "dmesg" print-outs when this error occurs.
> 
> We will try to create a simple test program to illustrate the problem, but maybe the issue is already obvious to some of the experts on this list.
> 

$ cat /proc/xenomai/stat
$ cat /proc/xenomai/sched

when the threads hang would help.

Additionally, please clone the -stable repo from there:
git://git.xenomai.org/xenomai-2.5.git

then branch+build and test from these commits:

- 6a020f5 first; if the bug does not show up anymore, check the next one
- 5e7cfa5; if the bug is still there, try disabling
CONFIG_XENO_OPT_PRIOCPL to test the basic system and re-check.

> Best wishes,
> 
> -Stefan
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



