MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18252.31008.17258.994903@domain.hid>
Date: Tue, 27 Nov 2007 21:08:00 +0100
In-Reply-To: <BF58A8AFB316514587D61EADBFBF4C410165FD26@domain.hid>
References: <18252.28684.840291.855543@domain.hid>
	<BF58A8AFB316514587D61EADBFBF4C410165FD26@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai@xenomai.org

Kyle Howell wrote:
 > >  > I have been debugging a stall problem for a couple of 
 > > days, and I think  > I've put together enough info to check 
 > > with the pros. Everything below  > was experienced on a P4 
 > > (Celeron) running 2.6.20 / Xenomai 2.3.4. I've  > also 
 > > reproduced it on 2.6.19.7 / 2.3.1. A quick test *did not* 
 > > reproduce  > this problem on a Core2 running x86_64 2.6.22.9 
 > > / 2.4RC3. 
 > >  >
 > >  > I've reduced the problem to a fairly simple example below:
 > >  >
 > >  > The Overview:
 > >  > - Running a single real-time process with one standard 
 > > thread and one RT  > task  > - The RT task loops on a 1sec 
 > > rt_task_sleep  > - The standard thread loops on 
 > > nanosleep(10msec) and rt_task_unblock of  > the RT task.
 > >  > - When an unrelated interrupt arrives at the wrong time, 
 > > the entire  > system will hang until the 1sec task_sleep expires.
 > >  > - After resuming, everything runs normally until another 
 > > interrupt lands  > at the wrong moment.
 > > 
 > > Do you observe the same behaviour without the interrupt shield ?
 > 
 > It doesn't appear so. I'll have to let it run longer to be 100% sure,
 > but the usual stressing isn't causing the problem. That's not expected
 > behavior with the interrupt shield, is it?

No, it is not an expected behavior.

-- 


					    Gilles Chanteperdrix.

