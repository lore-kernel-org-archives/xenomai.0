Message-ID: <4D3AF5B4.5000507@domain.hid>
Date: Sat, 22 Jan 2011 16:20:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D38809E.3080906@domain.hid> <4D388975.80606@domain.hid>
	<alpine.DEB.1.10.1101211225490.3495@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101211225490.3495@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
> Hi,
> 
>> The following patch seems to fix the issue, but I am not yet sure
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> 
> Yes it does fix it for me too. The output of my "try" program when run with
> gdbserver still differs from the output when run standalone, but at least there
> are no EPERM results anymore. The first two tasks cycle pthread_cond_wait more
> than once.
> 
> 0 3x 0x0010
> 1 2x 0x0010
> 2 1x 0x0010

Actually, that is normal, what you see are "spurious wake-ups" caused by
the signals sent by gdb, these are allowed by the posix specification.
However calling pthread_cond_wait again should not return immediately,
it should block until the call to pthread_cond_broadcast, so there
should not be a lockup.

-- 
                                                                Gilles.

