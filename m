Message-ID: <4F070D70.2060905@domain.hid>
Date: Fri, 06 Jan 2012 16:04:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <56E1AEF6484D429588063ADA1D312704@domain.hid>
In-Reply-To: <56E1AEF6484D429588063ADA1D312704@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/06/2012 03:11 PM, Terry Fryar wrote:
> Using Xen 2.6 with 2.6.38 kernel, have a kernel module with an ISR
> registered using rtdm_irq_request() that schedules a work queue.  This queue
> thread makes an spi call.

If the work queue you schedule is a linux work queue, that is not going
to work, for the same reason as in the last e-mail: you can not call
services interacting with Linux scheduler in xenomai context. So, if you
need an spi driver for real-time drivers or applicaitons, you have to
write one for the RTDM skin without using Linux services. There is no
way around.

> Not sure what this one means??  I see the "cpu_idle", and I vaguely recall
> some issue with that....but I don't remember what this was?

The cpu is idle most of the time, so, the idle function is the function
the most likely to be interrupted by an interrupt.

-- 
					    Gilles.

