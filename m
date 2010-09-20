Message-ID: <4C97C956.6040108@domain.hid>
Date: Mon, 20 Sep 2010 22:51:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
In-Reply-To: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] t_getreg / t_setreg undefined references in
 pSOS+ skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: xenomai@xenomai.org

ronny meeus wrote:
> Hello
> 
> I see in the psos.h file the function declaration for both the t_getreg and
> the t_setreg functions.
> Also in the psos kernel module I see functionality available.
> What I miss it the references for both service calls in the syscall.c file.
> 
> This results in undefined references if I try to use the service call in my
> application.
> 
> Is there any patch available that solves my problem?

I am afraid you will have to write that one... At first sight,
t_setreg/t_getreg would look like TSD, and straight-forward to implement
using pthread_getspecific/pthread_setspecifi, except that these posix
services do not allow to get another thread's TSD.

-- 
                                                                Gilles.

