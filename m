Date: Mon, 27 Dec 2010 18:27:10 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293469990.1856.11.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012271824540.20479@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<1293467484.1856.0.camel@domain.hid>
	<alpine.DEB.1.10.1012271744460.20479@domain.hid>
	<1293469990.1856.11.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
 gdb/gdbserver hangs...)
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai GNA <xenomai@xenomai.org>

> Since your thread relaxes due to printf() as well, the combination of
> What happens if you only log the debug info in some global array, and

As a quick test I just removed the printf() in the thread body. When run under
gdbserver, the target seems to locks up. Only hard reset can bring it back.
Without gdbserver it behaves well.

Kolja




