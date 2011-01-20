Date: Thu, 20 Jan 2011 18:16:30 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D386922.5080807@domain.hid>
Message-ID: <alpine.DEB.1.10.1101201811090.1990@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>> file cond-torture-posix
>
> Ok. On my side: I call set solib-absolute-prefix to where the debug
> binaries for the target filesystem are. And I call
> handle SIG34 nostop noprint pass.
>
> Coud you try and do the same?

Is SIG34 the same on blackfin? I do not remember ever having seen SIG34, only
SIG32 ("Real-time event 32")

Independent of that, the result is always the same SEGV. I cannot use the absolute-prefix currently, as the directory layout is different on the target. So my script is now

set solib-absolute-prefix notexistent
set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
file cond-torture-posix
handle SIG34 nostop noprint pass
target remote 10.0.10.9:2222

And regardless whether I add an "break main", the SEGV will occur immediately after telling gdb to "cont".

Does my "try.c" always succeed (all errbits=0x0010) in your environment?


Kolja





