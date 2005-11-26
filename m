MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Sat, 26 Nov 2005 16:42:48 -0700
Message-ID: <A0BC2AD74130A347BC7D2D653A27541C301509@domain.hid>
From: "Diekema, Jon (AGRE)" <Jon.Diekema@domain.hid>
Subject: [Xenomai-help] How to access the MPC8260 register space
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


Configuration:
	MPC8260
	Linux 2.4.25
	IPIPE 0.9-03
	Xenomai 2.1 (latest SVN version)
	IMMR =3D 0xF0000000

Background:
	- Have Linux based device driver, providing SCC/FCC transparent
mode access

Problem:

I am new to Xenomai, and am quite exciting about the prospects of what
it can offer.  A user mode device driver sounds like a *nice* dream, but
I ed
 a few more details.  I have a Xenomai task that is able to intercept
the the SCC2 interrupts, but now I need to figure out how to access the
memory based MPC8260 registers. =0D

What is needed for a user mode Xenonmai task to access the MPC8260
register which live in 0xf00000000..0xf0020000?  I tried using
rt_misc_get_io_region(), but didn't get too far.  I think this routine
is designed to access I/O space, which doesn't exist on PPC processor.
Should I be using the mmap() system call?  Or, is there a better
approach?

In kernel space, I have no trouble accessing these registers.






******************************************
The information contained in, or attached to, this e-mail, may contain=
 confidential information and is intended solely for the use of the=
 individual or entity to whom they are addressed and may be subject to=
 legal privilege.  If you have received this e-mail in error you should=
 notify the sender immediately by reply e-mail, delete the message from=
 your system and notify your system manager.  Please do not copy it for any=
 purpose, or disclose its contents to any other person.  The views or=
 opinions presented in this e-mail are solely those of the author and do=
 not necessarily represent those of the company.  The recipient should=
 check this e-mail and any attachments for the presence of viruses.  The=
 company accepts no liability for any damage caused, directly or=
 indirectly, by any virus transmitted in this email.
******************************************

