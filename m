From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4651AC93.5010500@domain.hid>
References: <46519AD0.80804@domain.hid>  <4651AC93.5010500@domain.hid>
Content-Type: text/plain
Date: Mon, 21 May 2007 17:05:16 +0200
Message-Id: <1179759916.473.103.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] 10us periodical task (Xenomai vs. RTAI)
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2007-05-21 at 16:28 +0200, Gilles Chanteperdrix wrote:
> Igor Plyatov wrote:
> > Is it possible to get 10us results in Xenomai or not?
> 
> Running a task with a period of 10us is usually considered a bit out of
> the scope of Xenomai. Nevertheles, there were some recent improvements
> on Xenomai trunk that might make this possible.

There have been significant improvements on the Adeos/x86 side too,
especially in SMP, now that we use PDAs.

>  It would be interesting
> if you tested this with trunk and tell us whether it works.
> 

Figures are really to be considered wrt the underlying hw Xenomai runs
on: achieving < 10us latency is currently a no-brainer in user-space on
recent x86_64 boxen, kernel space exhibits sub-2 us latencies there with
a 500 ns calibration value for the timer, which is quite good (it's a 2
way dual core AMD Opteron 285). Results on high-end embedded PPC hw are
quite good too IIRC. It's often a matter of memory sub-system, added to
the presence of internal perturbations when it comes to the Intel world,
like SMM etc.
For instance, my oldish Dual PIII 750 Mhz delivers < 20 us in kernel
space, which is as good as what I get with a P4-based 2.4Ghz
uniprocessor system. Also, hw optimizations for the average use case
(i.e. desktop) tend to kill real-time performances on Intel boxen.

> Also note that in order to get ultra-low latencies, you have to properly
> calibrate the nucleus latency (/proc/xenomai/latency).
> 
> > May be better to use only ADEOS functions for my task, is it faster then
> > RTDM?
> 
> Adeos has no notion of a "task", so, you would have to implement your
> task in an interrupt handler, and yes, you would get better performance
> (see for example the difference between latency -t 2 and latency -t 1).
> 
> > What is the state of RTAI nowadays, is it still a live?
> 
> Well, you are not asking on the right mailing list. Try RTAI mailing list.
> 
-- 
Philippe.



