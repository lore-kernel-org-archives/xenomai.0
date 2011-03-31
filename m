Message-ID: <4D948F87.9010109@domain.hid>
Date: Thu, 31 Mar 2011 16:28:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>	<1301412534.2109.24.camel@domain.hid>	<4D922EF5.8020808@domain.hid>	<1301426227.2109.35.camel@domain.hid>	<4D9230C5.7050007@domain.hid>	<1301426830.2109.41.camel@domain.hid>	<4D923306.60409@domain.hid>	<1301461081.2092.14.camel@domain.hid>	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>	<1301472945.2092.21.camel@domain.hid>	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>
	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>
In-Reply-To: <AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Henri Roosen wrote:
> Did some more tracing to see why the lower priority thread is
> scheduled before the higher prio thread is ended.
> 
> The highest priority task makes a system call and gets relaxed by
> xnshadow_relax. The rpi is pushed here and a Linux call with
> LO_WAKEUP_REQ is scheduled. Then I see the scheduler scheduling to the
> ROOT task. So far so good!
> 
> In the Linux domain, we run into the lostage_handler, where the
> scheduled LO_WAKEUP_REQ is executed. Here there is a call to
> xnpod_schedule() which actually causes a switch back to the primary
> domain and the lower priority Xenomai task to be scheduled in, even
> before the wanted process is woken up.
>
> Now, I am unsure what is faulty here and maybe Philippe or someone can
> answer that. Personally I would have expected the xnpod_schedule (or
> xnsched_pick_next) to know about the rpi list and not schedule a lower
> priority task than of any on that list. I was unable to find such
> code.
>

Unless I am wrong, what happens is whait is intended, at least if we
read the comment:
		case LO_WAKEUP_REQ:
			/*
			 * We need to downgrade the root thread
			 * priority whenever the APC runs over a
			 * non-shadow, so that the temporary boost we
			 * applied in xnshadow_relax() is not
			 * spuriously inherited by the latter until
			 * the relaxed shadow actually resumes in
			 * secondary mode.
			 */
			rpi_clear_local(xnshadow_thread(current));
			xnpod_schedule();

Which means that we do not want other Linux kernel code than the
real-time thread itself to inherit from this thread priority. Except
that all the code from the switch to root thread to the lostage_handler
(which means any Linux currently preempted critical section) already
inherited the priority.

-- 
					    Gilles.

