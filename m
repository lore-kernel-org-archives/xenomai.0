Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Oct 2007 11:01:16 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB025E4260@domain.hid>
In-Reply-To: <b054e88e0710300348w27eec304hecd5dbed4e189b54@domain.hid>
References: <b054e88e0710300348w27eec304hecd5dbed4e189b54@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Efika board
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>, xenomai@xenomai.org

Giammarco Zacheo wrote:
> Does anybody ever tried to port Xenomai on a Efika board?
>=20
> http://www.genesippc.com/efika.php
>=20
> It is a freescale powerpc based board, with some patches to make
> linux work on it. I have read some emails on the net talking about
> RTAI, so what about Xenomai? =20
>=20
> Is is realistic that the adeos patch blindly work on the already
> patched kernel?=20


We have a MPC5200B based board running on a 2.6.23 Denx Linux Kernel,
which contains MPC5200B specific patches. Uboot support should exist
already for Efika.

There is no apparent reason why Xenomai will not run on this board as
good as on our hardware. Kernel 2.6.24 should support it out of the box
as the MPC5200B patches are now inside the official Linux kernel.


Best regards,

Daniel Schnell.

