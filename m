Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] exception 768
Date: Fri, 17 Nov 2006 18:02:56 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D4826@domain.hid>
In-Reply-To: <1163784779.4980.47.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,


Philippe Gerum wrote:
>=20
> Disable CONFIG_XENO_OPT_DEBUG from your kernel configuration, this is
> the source of the PTE misses you are seeing now on ppc. This is not
> to say that those errors are normal, and this issue still remains to
> be fixed, but unless you want to debug the Xenomai nucleus, you don't
> need this option on (additionally, it adds a large overhead which
> translates in significantly augmented jitter).    =20

I can confirm that. As soon we access a file (so far over NFS) these
messages appear if this option is turned on. If the option is disabled,
these messages go away.

We will test on Monday if it will fix also other strangenesses we
encountered so far.

Thanks !


Regards,

Daniel Schnell.


