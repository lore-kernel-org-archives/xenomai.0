Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 4 May 2007 06:51:29 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01E43E85@domain.hid>
In-Reply-To: <463A2E31.4010302@domain.hid>
References: <4639D724.5010702@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>	<1178204088.29605.85.camel@domain.hid>
	<4639FAC7.9060207@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43DC9@domain.hid>
	<17978.11531.902028.392269@domain.hid>
	<463A2E31.4010302@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Hi,

I like that quick shot. Although of course this would only take effect =
for timers which are not already running. But I think anyway it is =
unsane to change timers which are already running.


Best regards,

Daniel Schnell.



-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: 3. ma=ED 2007 18:47
To: Gilles Chanteperdrix
Cc: Daniel Schnell; Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test

Gilles Chanteperdrix wrote:
> Daniel Schnell wrote:
>  >
>  > If, say, I would use latencies calibrated with user space POSIX  >=20
> timers for a typical work load, what would happen to timers that are =20
> > running in kernel or interrupt space ? Would they then be too early =
?
>  > Have negative values any negative effect besides running too early =
?
>  >
>  > In other words: when one uses timers inside Kernel, ISR's and User  =

> > space at the same time, which value should be used for  >=20
> /proc/xenomai/latency ? Wouldn't it make sense then to have 3  >=20
> different latency values for the 3 possible environments ?
>=20
> Yes the current situation is that there is only one constant, so, if=20
> you calibrate it for ISRs, user-space programs will be systematically=20
> late. Having three different constants would mean that we track, at=20
> nucleus level where each timer is used, and that we order timers in=20
> the timer queue according to their anticipated expiration date. This=20
> is quite a modification.

Quick shot: Maybe the caller of xntimer_start could already account for =
the usage scenario and subtract some magic offset from the timeout date.

Jan


