Message-ID: <4937ACEE.9060302@domain.hid>
Date: Thu, 04 Dec 2008 11:11:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <843a47610812031439g309ec9b5h898e636327c841cf@domain.hid>
In-Reply-To: <843a47610812031439g309ec9b5h898e636327c841cf@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Busy Loop Hang
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Matthew Fornero <matthew.fornero@domain.hid>
Cc: xenomai@xenomai.org

Matthew Fornero wrote:
> Hello,
> 
> I've created the following test case to illustrate linux and any tasks
> in the secondary domain hanging while executing a busy loop on one CPU
> in an SMP system.
> 
> Xenomai 2.4.5, Linux 2.6.26.5, x86_64
> Tests on quad-core AMD Opteron and dual-core Intel Core 2
> kernel booted with isolcpus=1-31
> 
> Task 1 (busy loop): Priority 99, CPU 1
> polls rt_timer_tsc until a timeout value is reached (1 ms)
> increments a counter (master counter)
> updates a global variable for the elapsed time
> every four minutes, goes to sleep with rt_task_sleep

This will not work. You can not prevent linux from working during 4
minutes and hope that it continue to work normally. For a minimal
perturbation of Linux, I would advise to suspend real-time activities
every 1/HZ seconds.

-- 
                                                 Gilles.

