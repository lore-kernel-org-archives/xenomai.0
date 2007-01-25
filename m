Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Patching latest Denx 2.4.25-devel kernel with
	xenomai-2.3.0 fails
Date: Thu, 25 Jan 2007 09:03:28 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0198DDF9@domain.hid>
In-Reply-To: <45B858EE.60301@domain.hid>
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
To: Xenomai help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
>=20
> The attached patch fixes the problem by replacing "^" with "-1" for
> "previous line". It works now with FC4 and FC6. Likely it's an
> incompatibility issue between ed-0.2-3 ed-0.3-0.fc6. =20
>=20
> Wolfgang.

Yes this fixes the problem for me. I can successfully patch the kernel
now.

Thanks for the quick fix.


Best regards,

Daniel Schnell.

