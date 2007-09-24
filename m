Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Sep 2007 16:07:53 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB023D2248@domain.hid>
In-Reply-To: <46F7B400.1020209@domain.hid>
References: <46F777EE.3060100@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
	<46F7B400.1020209@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-core] RTCAN (MSCAN) doesn't compile on latest Denx
	2.6.23
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:

=20
> It's a bit more tricky as it has to deal with flat device tree based
> resource management.=20
>=20

Yes this makes sense.


> I have a patch already since a while but forgot to post it. Could you
> please give the attached patch a try?=20
>=20

Patch applies and compiles cleanly. I will give it a try as soon as I
added the support for our board. I have already support for a 2.6.20
Kernel, so this should be no big deal.

Slightly OT:
Do you know the status of the mpc5200 support of the Denx-2.6 kernel
concerning ATA and FEC ? Are the latest patches from Sylvain Munaut and
Grant Likely already inside ?

What I find nice about the Denx kernel Repo is, that together with
Xenomai there are now two options for opening the MSCAN device.


Best regards,

Daniel Schnell.

