Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Feb 2008 15:20:12 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD3816E@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Atomic 64 bit write access on PCIe device
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

M. Koehrer wrote:
>First I thought of using the FPU for this issue.
>Hoever, I am not sure if it is allowed to use the FPU here as I think
there are some 64 bit integer values
>that will be modified by fldl (e.g. if they represent some kind of
NaN).

Might be. To be checked whether there are some other safer FP
instructions.

Another idea would be to use MMX and the MOVQ instruction for example.

Regards,
--=20
Stephane

