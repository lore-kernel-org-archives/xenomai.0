Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Working example for direct memory mapped IO
Date: Thu, 14 Dec 2006 15:14:37 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A0C1882@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid, xenomai@xenomai.org

Niklaus Giger wrote:
>To document basic Xenomai/Linux patterns I developed the attached small

>example for our PPC405 board, which just rolls the 8 debug LEDs.
>
>Are there any comments about it?=20

This is a worthy example. I strongly recommend you to declare your=20
ledRegister variable as volatile. You'll find another example in
the Denx's FAQ[1], and accessible through shorter URL[2].
Personally, I always access hardware registers through in_[lbe]{8,16,32}
out_[lbe]{8,16,32} macros, so the code is portable across machines of=20
different endianess, and thanks to the integrated memory barriers,=20
I known exactly when the CPU will actually perform the I/O with respect=20
to the other C instructions.

[1]
http://www.denx.de/wiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acces
singPeripheralsFromUserSpace
[2] http://tinyurl.com/6c7th

Best regards
--=20
Stephane

