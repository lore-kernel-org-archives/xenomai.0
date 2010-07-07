Message-ID: <4C3463FD.4040804@domain.hid>
Date: Wed, 07 Jul 2010 13:24:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilmN6HTqYAcEv5qTqYhpjgBiMYQAPvPwCnynAHu@domain.hid>	<4C345529.8010309@domain.hid>
	<AANLkTimmMGLKCyhiLBdDafSvkGlldwI17Xb2Y-XCx1bV@mail.gmail.com>
In-Reply-To: <AANLkTimmMGLKCyhiLBdDafSvkGlldwI17Xb2Y-XCx1bV@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] task management, multi-thread, multi-core
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> If the second task is running already, when the
> higher priority
> task is waiting for an outside event, then the event comes, the high
> priority task
> has to wait until the lower priority one to finish?

No. Xenomai scheduler is preemptive:
http://en.wikipedia.org/wiki/Preemptive_multitasking

> Do you mean that if I need memory isolation, I use process, if I am sure my code
> has no memory problem, I should choose thread for better performance? Or it
> is more complex than this?

You can never be sure that code has no memory problem. It is more
complex than that, for instance, whether the threads are inter-dependent
should be taken into account.

-- 
					    Gilles.

