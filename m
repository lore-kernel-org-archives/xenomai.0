Message-ID: <49356C83.8050909@domain.hid>
Date: Tue, 02 Dec 2008 18:12:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4934EB57.9080305@domain.hid>
In-Reply-To: <4934EB57.9080305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Calling comedi from a RT task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Patrick_Gr=E4bel?= <graebel@domain.hid>
Cc: xenomai@xenomai.org

Patrick Gr=E4bel wrote:
> Hi,
>=20
> I am using Xenomai 2.3.1 and comedi with driver "ni_pcimio". I am able
> to create a RT task that triggers each msec. But calling the comedi API
> kicks me out of RT as indicated by /proc/xenomai/stat (column MSW). The
> modules loaded are:
>=20
> comedi_fc   3584 1 ni_pcimio
> kcomedilib 20868 0
> comedi     33248 6 ni_pcimio, ni_tio, comedi_fc, mite, 8255, kcomedilib
> licModule  44272 1 kcomedilib
>=20
> The comedi modules are from a 2.6.20-14-ipipe/comedi/driver directory.
> How do I use the comedi API so that the task will stay realtime? What d=
o
> I have to check?

You should have a look at the RT-capable comedi stack that currently
only lives in Xenomai SVN trunk. How to get your device supported by
that stack, ie. how to port the existing driver to RT-comedi, that's
something Alexis can tell you more about. And/or have a look at the fake
and loop drivers that are already included.

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

