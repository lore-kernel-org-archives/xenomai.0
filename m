content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] How to access the MPC8260 register space
Date: Mon, 28 Nov 2005 09:53:32 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2EF0@domain.hid>
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
To: "Diekema, Jon (AGRE)" <Jon.Diekema@domain.hid>, xenomai@xenomai.org

Diekema, Jon (AGRE) wrote:
[..]
>What is needed for a user mode Xenonmai task to access the MPC8260
>register which live in 0xf00000000..0xf0020000?  I tried using
>rt_misc_get_io_region(), but didn't get too far.  I think this routine
>is designed to access I/O space, which doesn't exist on PPC processor.
>Should I be using the mmap() system call?  Or, is there a better
>approach?

This is a linuxppc-embedded FAQ, which is documented in Denx's FAQ:
=20
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
 or shorter: http://tinyurl.com/6c7th

For more information, please follow this thread (not ppc specific
actually)
   http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html

Regards,
--=20
Stephane


