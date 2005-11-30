Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] using mq_receive and mq_send
Date: Wed, 30 Nov 2005 17:42:14 +0200
Message-ID: <02AA386EB831044F8537A696BA785C78076489@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

it says:
         U __wrap_mq_close
         U __wrap_mq_open
         U __wrap_mq_receive
         U __wrap_mq_send
         U __wrap_mq_unlink

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Wednesday, November 30, 2005 4:37 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] using mq_receive and mq_send


Landau, Bracha wrote:
> I do link that way. The linking is fine, only the mq_receive and mq_sen=
d don't work. I don't even "own" the regular libmqueue library.
>

What does "nm <your_app>|grep wrap_mq_" says?

> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Wednesday, November 30, 2005 4:01 PM
> To: Landau, Bracha
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] using mq_receive and mq_send
>=20
>=20
> Landau, Bracha wrote:
>=20
>>I am using Xenomai on the MPC8272ADS board with kernel 2.6.14.3.
>>
>>I've created an application that uses posix message queuing from xenoma=
i.
>>
>>When I call mq_open, mq_close, mq_setattr, mq_getattr, mq_unlink - the =
calls succeed.
>>
>>When I call mq_receive or mq_send, the call fails (returns -1) and errn=
o is set to 1 (Operation not permited).
>>
>>I put some debugging printk's into the xenomai code and it seems it doe=
sn't even get to the call to __mq_receive or __mq_send from syscall.c (it=
 does get to printk's that I put in  the other __mq_* functions).
>>
>>Can anyone help?
>>
>=20
>=20
> You must link your app with the flags output by "xeno-config=20
> --posix-ldflags". Have a look at skins/posix/demos/Makefile for a=20
> working example.
>=20


--=20

Philippe.
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

