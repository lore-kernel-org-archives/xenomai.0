From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Mar 2011 17:28:54 +0200
Message-ID: <1301412534.2109.24.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-03-29 at 16:41 +0200, Henri Roosen wrote:
> Hi,
> 
> I have several Xenomai RT threads (prio > 0) that get ready to run all
> at the same time. Priority coupling is enabled in the kernel.
> 
> If one of them (unfortunately) makes a Linux system call, I see that
> first other lower and same priority Xenomai tasks are scheduled before
> the switched task is run in the Linux domain. As I understand,
> priority coupling should prevent this.
> 
> To rule out a problem in the application, this is also tested with a
> simple application based on the rt_print example. In my opinion, with
> priority coupling enabled this should print:
> Wakeup! - I am - awake! - Me too!
> But I get:
> Wakeup! - I am - Me too! - awake!
> So task 2 gets run before task 3 completes in the Linux domain.
> 
> Please find attached the test application and the .config file.

The fine print with priority coupling is that it stops immediately
whenever the thread blocks linux-wise; this is actually why, after all
this time debugging it, I'm pondering now whether I should keep this
behavior/feature in 3.x.

Initially, this was aimed at enforcing the right scheduling sequence
with traditional RTOS APIs, specifically when it comes to create
threads, so that high priority children do run prior to low priority
parents (some legacy apps may expect this). But the fact is that this
behavior also carries a number of uncertainties, and having the thread
de-boosted when blocked by Linux is a serious one.

Anyway, please try the following:

- do not use rt_printf() to monitor the sequence, but a data array of
some sort to track the switches, and report the contents of that array
at the end of the test.

- replace gettimeofday() with sched_yield().

TIA,

> 
> Xenomai 2.5.6
> Linux 2.6.32.20
> adeos-ipipe-2.6.32.20-x86-2.7-03.patch
> 
> Thanks,
> Henri.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



