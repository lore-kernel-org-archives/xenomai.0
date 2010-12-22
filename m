From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1293027465.22129.17.camel@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
	<alpine.DEB.1.10.1012221511320.11502@domain.hid>
	<1293027465.22129.17.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Dec 2010 15:20:17 +0100
Message-ID: <1293027617.22129.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
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

On Wed, 2010-12-22 at 15:17 +0100, Philippe Gerum wrote:
> On Wed, 2010-12-22 at 15:14 +0100, Kolja Waschk wrote:
> > > Your Makefile may have an issue. Do you happen to link with
> > > libpthread_rt.so in addition to libnative.so?
> > 
> > Yes, because most of the code uses the native API, but one part uses pthread_* calls.. ?
> > 
> 
> Ok, you should have a look at this commit then, and introduce
> wrap-link.sh in the link rules for your app: 
> http://git.xenomai.org/?p=xenomai-gch.git;a=commit;h=8f5330c9da75f5fdedee5b7cf60e525ee5845300
> 

In short, it is Xenomai's pthread_cond_wait() version which returns
EPERM to the linuxthread manager, because it does not want to be called
from a non-Xenomai thread. Obviously, the manager thread should not
invoke any Xenomai service in the first place, and this is where the
link magic bites.

> 
> > Kolja
> > 
> 

-- 
Philippe.



