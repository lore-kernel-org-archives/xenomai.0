Message-ID: <4D1FA467.2030607@domain.hid>
Date: Sat, 01 Jan 2011 23:02:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<4D1A135E.7060005@domain.hid>
	<alpine.DEB.1.10.1012281853500.23472@domain.hid>
	<alpine.DEB.1.10.1012281925410.23472@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012281925410.23472@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

Kolja Waschk wrote:
>>> posix-cond-torture test case to verify that what was supposed to be
> 
> As a side note, cond-torture-native (not -posix) locks up with gdbserver/gdb after
> displaying just "simple_condwait". My problems seem to be not just related to the POSIX skin.

Ok. I can confirm I am unable to reproduce this issue on the NPTL based
setups I have access to, the LD_ASSUME_KERNEL environment variable no
longer seems to do the trick to force linuxthreads. So, I could not test
a linuxthreads based system.

Your issue seems to be that the condvar waiting syscall is restarted
whereas it should not, and indeed, native and posix condition variables
work the same way. To move forward, we should follow the syscall path
and see at what point it is restarted whereas it should not when running
under gdb.

-- 
                                                                Gilles.

