Message-ID: <2ff1a98a0711280534v4f45f270o7f3fd308ac3585bc@domain.hid>
Date: Wed, 28 Nov 2007 14:34:56 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0711280508s2a6ddd09i102e00e7e6cae8df@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2F8EE677D406514ABE53EF9C0934A666042ABDFF@anubis2.clb.tcfr.thales>
	<2ff1a98a0711280508s2a6ddd09i102e00e7e6cae8df@domain.hid>
Subject: Re: [Xenomai-help] Low priority primary mode threads scheduling vs
	linux regular th read.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

On Nov 28, 2007 2:08 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Nov 28, 2007 9:24 AM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
> > Hi,
> >
> > It was said in a previous thread under title "scheduling of low priority primary mode Xenomai threads versus high priority secondary mode Xenomai threads":
> > <<Plain regular Linux threads unknown from the Xenomai scheduler are always preempted by primary mode threads, but they _do_ compete for the CPU with secondary mode threads according to their priority and scheduling class>>
> > Consider the following example with 3 Threads (coupling between Xenomai and Linux schedulers is On):
> > *       TL : regular linux thread with high priority (unknown from Xenomai Scheduler) => ready to run.
> > *       Tx1 : xenomai real time thread with medium priority in primary mode => running.
> > *       Tx2 : xenomai real time thread with low priority in primary mode => blocked (waiting for an event).
> > Tx1, which is running, issues a linux system call and then switches to secondary mode. TL and Tx1 compete for the CPU and TL takes the CPU control (am I right?).
> > Then an interrupt occurs and gives the necessary condition to unblock the Tx2 thread. Does the sentence <<Plain regular Linux threads unknown from the Xenomai scheduler are always preempted by primary mode threads>> means that Tx2 will preempt TL or does TL keep control of the CPU because it is still in competition with the secondary mode thread Tx2 which has a higher priority compared to Tx1?
>
> The problem is that when Tx2 is running in secondary mode, it needs to
> voluntary switch to primary mode. When in secondary mode, Tx2 is
> suspended from Xenomai nucleus point of view, so xnpod_resume_thread
> cause the SIGHARDEN signal to be sent to Tx2, but Tx2 needs to run a
> little bit to handle the signal which will cause it to switch to
> primary mode.
>
> So, in my opinion (but I may be wrong) TL will continue to run until
> it lets Tx2 run.

Forget about this, it is completely wrong, the SIGHARDEN signal is
only used when suspending from Xenomai nucleus point of view a thread
running in secondary mode.

If Tx2 is blocked in secondary mode, it will be resumed by the
interrupt, but since the root thread inherited TL priority and Tx2
priority is lower than TL priority, Xenomai scheduler will let TL run.
If you do not want this to happen, you have to disable root thread
priority coupling.

-- 
                                               Gilles Chanteperdrix

