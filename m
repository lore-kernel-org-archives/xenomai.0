Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2008 13:18:48 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B00@domain.hid>
In-Reply-To: <47B0AC03.9050403@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>	<47B053A2.9010503@domain.hid>	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>	<2ff1a98a0802110810r297a639ej5a061b823a4d551d@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
	<47B09B10.5090200@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AF6@domain.hid>
	<47B0AC03.9050403@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] overhead
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai@xenomai.org

> At least the topmost four/five lines would help. You will find
> __ipipe_handle_irq within the call frame each time an interrupt is
> taken, so you need to focus on which handler gets actually called. In
> the case above, it seems a serial interrupt is involved, and what its
> handler does might be the root of the issue.

I'll run these tests tonight for you and post the results.

> Creating threads should be kept out of real-time duties, it's just
> unsafe in terms of latency (Btw, I hope you do reduce the default
glibc
> stacksize from 8Mb to something more sensible in a real-time
application
> context, given that mlockall is in effect).

I understand this, and this is something I always follow. However, this
is a linux only pthread not being created in a realtime context. The
only reason the thread is shadowed is so it can call a few things
occasionally to lock an RT_MUTEX. None of these mutexes are held at this
time, and the thread might as well be in secondary mode. (and probably
is.)

> ipipe_handle_irq will be present in every call frame on behalf of an
> external or virtual interrupt context, therefore if you get a fault in
> the interrupt handler like you reported lately, the time spent in the
> fault recovery code will be charged to the interrupt context.

Thanks for the explanation. I'll be sure to gather some of these
tonight. I sent you the only one I have privately with the kernel.

Steven

