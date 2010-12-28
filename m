Date: Tue, 28 Dec 2010 10:50:34 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293479986.1856.12.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012281032560.22524@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<1293467484.1856.0.camel@domain.hid>
	<alpine.DEB.1.10.1012271744460.20479@domain.hid>
	<1293469990.1856.11.camel@domain.hid>
	<alpine.DEB.1.10.1012271824540.20479@domain.hid>
	<1293479986.1856.12.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
 gdb/gdbserver hangs...)
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai GNA <xenomai@xenomai.org>

Hi,

>> gdbserver, the target seems to locks up. Only hard reset can bring it back.
> Which means that pthread_cond_wait() likely returns with an error.

I later replaced the printf with a pthread_yield() to work around the "lockup" and made the threads record the errors, if any, to variables instead of complex output; as you suggested.

The pthread_cond_wait always(!) return EPERM in the first two threads when run with gdb,  only the pthread_cond_wait in the third thread succeeds. That appears to be the same result as with the original test code. Even the very first pthread_cond_wait() already returned EPERM, even before the first printf().

Kolja





