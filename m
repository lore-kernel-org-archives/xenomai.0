Message-ID: <4EB53B0C.7060303@domain.hid>
Date: Sat, 05 Nov 2011 14:33:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1320433713.81220.YahooMailNeo@domain.hid>
	<4EB43B3E.806@domain.hid>
	<1320440601.64091.YahooMailNeo@domain.hid>
	<4EB45AF6.60304@domain.hid>
	<1320460319.56312.YahooMailNeo@domain.hid>
In-Reply-To: <1320460319.56312.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 0 CPU time problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Z <tomz30@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/05/2011 03:31 AM, Tom Z wrote:
> Hi Gilles,
> 
> > No, CLOCK_PROCESS_CPUTIME is a clock implemented by the Linux
> > kernel, so, it does not see the time spent in primary mode. If the
> > foo function does not suspend, you can use rt_timer_tsc(), but the
> > answer is no, there is currently no way to get the cpu time used
> > when in primary mode.
> 
> Thanks a lot for the explanation. It seems my understanding on how
> Xenomai works was incorrect. I thought that if a task, say,
> myRTTask() is spawned by rt_task_create() and rt_task_start(), then
> myRTTask() will always run in the primary mode, so if myRTTask()
> calls foo(), then foo() will be running in the primary mode all the
> time. The correct fact is, myRTTask() could be running in either the
> primary mode or the secondary mode, right? This arises my another
> question, if foo() uses some third party libraries (with source code
> available), how can I tell what parts of foo() will be running in the
> primary mode, and what parts will be in the secondary mode? Are there
> principles for deciding whether the code is in the primary mode or
> the secondary mode?

Hi, it would be nice if you could quote and wrap mails as is usual on
public mailing lists.

Every Linux system call causes a switch to secondary mode, as well as
every call to a xenomai system call documented as such. For instance, if
you look at rt_queue_create documentation, you see:

Environments:

This service can be called from:

    * Kernel module initialization/cleanup code
    * User-space task (switches to secondary mode)

If you want to detect unwanted mode switches to secondary mode, you can
use rt_task_set_mode with the T_WARNSW bit, as is demonstrated in the
example:
examples/native/sigdebug.c

in xenomai sources tree.

-- 
                                                                Gilles.

