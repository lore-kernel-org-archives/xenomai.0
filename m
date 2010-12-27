From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1012271824540.20479@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<1293467484.1856.0.camel@domain.hid>
	<alpine.DEB.1.10.1012271744460.20479@domain.hid>
	<1293469990.1856.11.camel@domain.hid>
	<alpine.DEB.1.10.1012271824540.20479@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Dec 2010 20:59:46 +0100
Message-ID: <1293479986.1856.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
 gdb/gdbserver hangs...)
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
Cc: Xenomai GNA <xenomai@xenomai.org>

On Mon, 2010-12-27 at 18:27 +0100, Kolja Waschk wrote:
> > Since your thread relaxes due to printf() as well, the combination of
> > What happens if you only log the debug info in some global array, and
> 
> As a quick test I just removed the printf() in the thread body. When run under
> gdbserver, the target seems to locks up. Only hard reset can bring it back.
> Without gdbserver it behaves well.

Which means that pthread_cond_wait() likely returns with an error.

> 
> Kolja
> 
> 
> 

-- 
Philippe.



