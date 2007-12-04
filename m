Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 4 Dec 2007 07:18:39 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375F44@domain.hid>
In-Reply-To: <2ff1a98a0712040608l634b902kf1d7db3652b71575@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
	<2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int>
	<2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int>
	<18260.25837.479943.881970@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid>
	<18260.29573.817255.968962@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375F43@domain.hid>
	<2ff1a98a0712040608l634b902kf1d7db3652b71575@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> No, signals with xnshadow_send_sig are pure linux signals sent with
> the kernel function send_sig. So, they are caught by installing a
> signal handler with either signal or sigaction.

This is fine then. At least then we would know what application had the
problem. Thanks! I will try this tomorrow when I have some time to work
on that project and I'll let you know.

> Note that if a kernel space thread is killed by the watchdog, all
> user-space threads which armed the XNSIGWDG are notified, because we
> do not know to which process the kernel-space thread logically
> belongs.

Maybe it makes more sense to only notify kernel threads that set this
mode. Just a thought. Our application only needs one kernel thread so
it's not a big deal. It has no possible way to run away... at least I
don't think so. :)

BTW, maybe to solve the problem with registering an opaque pointer with
the nucleus, perhaps we should consider adding a single void* to all
xenomai types. (Tasks, queues, pipes, etc.) Then, the user could have a
single call that binds an opaque pointer to any type. This could contain
data the user program needs to identify and properly clean up the
deleted thread. This way, the watchdog timer could simply suspend a
thread rather than delete it, and the user thread could then clean it up
properly. In order to ensure the thread isn't restarted before the user
program gets the signal, it could be marked in such a way as to not
schedule again.

I just keep making this more complicated. :)

Steven


