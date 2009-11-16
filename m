Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2009 10:57:29 -0600
Message-ID: <181804936ABC2349BE503168465576460CBA4C29@domain.hid>
References: <181804936ABC2349BE503168465576460CBA4A79@domain.hid> 
	<4B0182CF.8070601@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Killing Xenomai task on kernel shutdown
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Steve Deiters wrote:
> Are Xenomai tasks supposed to outlive the kernel?  I have a Xenomai=20
> task that continues to run after the kernel is shut down.
> =20
> I have a PowerPC board which has an external watchdog.  To keep this=20
> happy I have a periodic Xenomai task that I create early in the kernel

> startup with an initcall.  However, when the kernel shuts down I would

> like to stop/delete the task so that the watchdog will restart the=20
> processor.  Right now it seems that the task continues to run after=20
> kernel shutdown.  If nothing else I can just manually stop it on
shutdown.
> =20
> I'm not sure if there's a way to hook into the kernel shutdown.  I=20
> have found the exitcall macros, but they seem to be only used for=20
> module unloading and do not seem to be called on a regular shutdown.=
 =20
> The initcall is in a board specific startup file.  If possible, I'd=20
> like to keep the task deletion also in the same file.  I just do not=20
> know if there is a hook available for this.

What version of xenomai are you running?

--=20
                                          Gilles


It is kernel version 2.6.24.6 with Xenomai 2.4.10.

