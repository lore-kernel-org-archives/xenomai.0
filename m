Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Dec 2008 16:08:09 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD3849E@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] rt_heap_create problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Hans_S=F8ndergaard_=28HSO=29?= <HSO@VIAUC.DK>, xenomai@xenomai.org

Hans S=F8ndergaard (HSO) wrote:
> I use Xenimai 2.4.3 and Linux 2.6.24 on an AT91SAM9260 processor based =
on ARM926EJ-S.
> My problem is that the code snippet below gives an error -2.

What does mean error -2 ?  Isn't it ENOENT /* No such file or directory =
*/ ?

A rough guess would lead to /dev/rtheap missing. Can you check?
You may also make use of strace to get more clues.

Regards
--=20
Stephane

