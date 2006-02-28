Date: Tue, 28 Feb 2006 06:24:54 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0299D36.256C%steve@domain.hid>
In-Reply-To: <44045C75.30107@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Every other RTOS I've ever used would disagree with you. However, I can wrap
the suspend/resume functions with a call to set period. Thanks for the tip.

Steven

On 2/28/06 6:21 AM, "Jan Kiszka" <jan.kiszka@domain.hid> wrote:

> Steven Seeger wrote:
> Just imagine that your task is attached to a continuously running timer
> as soon as you request this via rt_task_set_periodic. So, if you feel
> like suspending the task for a while, detach it from that timer again
> (infinite period). Putting this functionality into the RTOS is a bit
> overkill in my eyes.
> 
> This is a corner use-case, so not everyone should pay for implementing
> it in a generic way, only the user who really wants it (by having to
> write a few extra lines).
> 
> Jan
> 


