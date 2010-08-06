From: "Kim, Jonghyun (NIH/CC) [F]" <jonghyun.kim@domain.hid>
Date: Fri, 6 Aug 2010 14:04:04 -0400
Message-ID: <CB64A448250ADE40A2D9459AEB556D5E0274D4FBBF@NIHMLBX15.nih.gov>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Use of counter for quadratic encoder in NI PCI-6229
	board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

OS : Debian 5.0.4 + Xenomai 2.5.2
HW : NI PCI-6229


Hi.
I have a question on the use of counter in NI PCI-6229 board.

Thanks to analogy, I can use the functions of AI and AO using NI PCI-6229.
But, I failed to use its counter for quadratic encoder.

I think it may work, but it is hard for me because I don't have any verifie=
d example.

Recently, I tried the following code to set the counter up for quadratic en=
coder:
---------------------------------------------------------------------------=
------------------------
a4l_desc_t dsc =3D {.sbdata =3D NULL };
a4l_insn_t config;
unsigned int data[4];

a4l_open(&dsc, filename);
dsc.sbdata =3D malloc(dsc.sbsize);
a4l_fill_desc(&dsc);

config.type =3D A4L_INSN_CONFIG;
config.idx_subd =3D 10;  // this is correct. I checked it
data[0] =3D A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER;
data[1] =3D 0; // X1, X2, X4
data[2] =3D 0; // indexphase HH, LH, ...
data[3] =3D 0; // indexreset
config.data =3D data;
config.data_size =3D 4*sizeof(unsigned int);

a4l_snd_insn(&dsc, &config);
---------------------------------------------------------------------------=
-------------------------

However, the last a4l_snd_insn() returned error code, -22.


Could you give me the verified sample code for quadratic encoder using NI P=
CI-6229 board?
Or plz help me to use my encoder :(

Many thanks in advance.

Jonghyun=

