Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
Date: Tue, 7 Nov 2006 14:39:03 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB014DF008@domain.hid>
In-Reply-To: <ac3922a00611070616s6efa5e39wa8a2b849d9fc683b@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai@xenomai.org

Syed Amer Gilani wrote:
=20
> I had similar problems, but with a 2.6.18 Kernel. Check you Kernel
> configurations of mscan. The default clock of 66Mhz is possibly
> wrong, on my mpc5200b board it is 33Mhz. And also check the Pin
> Configuration. I had also no termination on board, so i had to add it
> to the cable.  =20


Hi,

This fixed it: setting it from 66MHz to 33MHz in the MSCAN
configuration. At least the IOUnit gets messages now. Thanks a lot !!

If now only the clock_nanosleep() would wait as long as expected and
would not return after 1/4 of the time ....



Best regards,

Daniel.

