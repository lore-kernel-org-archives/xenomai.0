Message-ID: <49358937.5040707@domain.hid>
Date: Tue, 02 Dec 2008 20:15:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1227226604.13217.13.camel@domain.hid>	
	<4926859D.4090208@domain.hid>
	<1228242306.29066.5.camel@domain.hid>
In-Reply-To: <1228242306.29066.5.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shared memory mlockall error w/ mono	interpreter?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> The mono application doesn't need realtime services.  But it does need
> access to DPRAM.

So, maybe you can create a small character device driver and implement
the mmap method for this driver, this will allow you to share a piece of
memory between kernel and user-space without resorting to Xenomai
services. There are examples of this sort of things in the "Linux
devices drivers" book.

> 
> It crashes with the message:
> Xenomai: process memory not locked (missing mlockall?)

Ok. Got it now. So, mono probably calls munlockall. Another solution is
to look for this munlockall in mono sources and recompile mono without it.

-- 
                                                 Gilles.

