Message-ID: <4D3D7107.7030603@domain.hid>
Date: Mon, 24 Jan 2011 13:31:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D387148.3030306@domain.hid>
	<alpine.DEB.1.10.1101211222330.3495@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101211222330.3495@domain.hid>
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
>>> Independent of that, the result is always the same SEGV. 
> ..
>> So, I am afraid you are on you own if you want to debug this.
> 
> It seems that's completely unrelated. The SEGV always occurs if I compile my
> application with -lpthread explicitly listed in the ldflags, as xeno-config
> suggests. Maybe a toolchain problem, I'll ask there first
> 
> http://blackfin.uclinux.org/gf/forummessage/97601

The thing I do not understand is that you should not pass any ldflags to
cond-torture-posix, Xenomai build system should have been taken care
about this.

Anyway, are you using libpthread as a static library?

-- 
                                                                Gilles.

