Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2008 12:16:03 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376AF6@domain.hid>
In-Reply-To: <47B09B10.5090200@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>	<47B053A2.9010503@domain.hid>	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>	<2ff1a98a0802110810r297a639ej5a061b823a4d551d@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
	<47B09B10.5090200@domain.hid>
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

> Send those backtraces, please, and a disassembly of your running
kernel
> privately to me.

I don't have the backtraces because they'd occur and the system would
freeze. I wasn't using serial console because my application uses both
serial ports. I even noticed ipipe_ calls and 16554_ serial calls in the
same backtrace.

Next time one occurs, I will be sure to post it.

> Sorry, I just don't understand where the problem is, or maybe I did
not
> understand what you are exactly doing/expecting here.

I wanted to be warned if my main state thread ever went to secondary
domain, so I used T_WARNSW. However, I posted this condition wrong. The
SIGXCPU is caused by my calling assert() because my state thread had an
overrun, which it should not have. The system is doing nothing at this
point, but calling pthread_create() in a shadowed thread causes an
overrun. The shadowed thread is priority 1, and the state thread is
priority 50. The state thread runs at 100Hz so this should not be too
bad on the system.
=20
> If you actually take faults on behalf of the tick timer handler, then
no
> wonder why the CPU figures explode.

I don't understand what you mean here?

> Older versions, or older kernels?

Xenomai 2.2 era. I think I used 2.6.18 or something. It was a long time
ago.
Steven


