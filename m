Message-ID: <4C3509D9.40806@domain.hid>
Date: Thu, 08 Jul 2010 01:12:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F3855E1@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F3855E1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Determining stack usage?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> With the recent questions about the stack size going around I had a
> somewhat related question.  Does Xenomai (or Linux for that matter)
> provide any mechanism to determine stack usage?  I know of other RTOSes
> that used a mechanism that basically prefills the stack with a guard
> word upon task creation, and then calculates the stack usage based on
> the first non guard word it encounters from the bottom of the stack.  I
> didn't know if Xenomai provided this or anything similar.

No. The only thing provided is an unwritable page below the stack, so
that in case of stack overflow, a segmentation fault happens on machines
with an MMU. If you look at the stack pointer at the time of the fault,
you can see that you got a stack overflow. There is no silent corruption
of a neighbor stack.

-- 
					    Gilles.

