Message-ID: <4B5475B7.2070702@domain.hid>
Date: Mon, 18 Jan 2010 15:52:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B5473FE.7050704@domain.hid>
In-Reply-To: <4B5473FE.7050704@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] thread and posix skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Alessio Margan @ IIT wrote:
> Hi,
> 
> I've got problem using pthread_make_periodic_np and pthread_wait_np.
> Should I make some particular initializations ?
> CONFIG_XENO_OPT_TIMING_PERIOD=y have sense ?

It is unrelated. CONFIG_XENO_OPT_TIMING_PERIODIC means that you request
a periodic timer instead of the default which is one-shot. Which means
all your wake-ups will be aligned on timer ticks.

> In the examples and testsuite I 've just seen the use of clock_nanosleep 
> with pthread,
> should I use it instead of pthread_make_periodic_np ?

As you wish.

> 
> This is the thread routine, I get error on pthread_wait_np() return code 
> 110.

Can't tell, your sample code does not compile here. 110 is ETIMEDOUT, it
is usually returned when the start time has already passed. As
documented here:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__posix__thread.html#gafe8deaa3c89e0a07e59f0e58f9ec1473

-- 
					    Gilles.

