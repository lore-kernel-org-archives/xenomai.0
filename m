From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Sat, 02 May 2015 17:31:44 +0200
Message-ID: <5808875.156NN5Jd1A@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <55433623.3000401@web.de>
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
 <3872595.UY9zmVq9KM@eltrolinux48.eltroad.eltropuls> <55433623.3000401@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hang/Reboot when using
	CONFIG_CC_STACKPROTECTOR_REGULAR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

Am Freitag, 1. Mai 2015, 10:15:31 schrieb Jan Kiszka:
> Reproduced and quickly debugged in KVM: The switch code was just broken
> regarding argument numbering when the protector is on. This fixes it
> (will push a patch soon):
> =


this fixes the problem on my targets also. Thanks for your help.

Marc

-- =

Dipl.-Ing. Marc Str=E4mke
Gesch=E4ftsf=FChrer / CEO

ELTROPULS Anlagenbau GmbH
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150502/de4701b=
6/attachment.sig>
