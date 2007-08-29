Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Aug 2007 18:10:37 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB1BB@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Re : sqrt() function in xenomai kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
[..]
>> Kernel-space math remains a dead end, just the point where it ends
may
>> vary. We should really encourage people to port away from it whenever
>> possible.
>
> Still, I think that having some libm support in kernel-space may help
> people when porting their applications to Xenomai.

IIRC, Mathieu's need for libm support in kernel-space was because its=20
(legacy) application was written for the RTAI API. Instead of providing
libm support in kernel-space (which sucks anyway performance-wise
compared
to a fixed point implementation), a user-space port of the RTAI skin=20
could enable easier porting of its application. That said, I would=20
strongly advocate for converting the use of the RTAI API to either
native
or Posix skin API.
--=20
Stephane

