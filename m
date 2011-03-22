Message-ID: <4D88012F.5010601@domain.hid>
Date: Tue, 22 Mar 2011 02:53:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinbWB880bzWqR2o-6Ah2A_iZCucMQU-HaOcunEL@mail.gmail.com>
In-Reply-To: <AANLkTinbWB880bzWqR2o-6Ah2A_iZCucMQU-HaOcunEL@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] port du Xenomai
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Rodrigo Muraro <rodrigo.muraro@domain.hid>
Cc: adeos-main@gna.org

Rodrigo Muraro wrote:
> Salut,
>=20
> Je suis en train de porter Xenomai pour le processeur OMAP-L138.
>=20
> Je suis parti du kernel 2.6.34 fourni par Texas Instruments e j'ai appl=
ique
> le patch I-pipe Xenomai 2.5.4.

You probably would better start with 2.6.35, as it already has an I-pipe
patch:
http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.35.9-arm-1=
=2E18-01.patch

The current version of Xenomai is 2.5.6.

>=20
> Ensuite j'ai suivi les indications d=C3=A9crites dans le document suiva=
nt:
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
>=20
> J'ai modifi=C3=A9 que le fichier time.c du repertoire arch/arm/mach-dav=
inci
>=20
> Le kernel se bloque pendant l'initialisation du pilote USB, plus pr=C3=A9=
cis=C3=A9ment
> apr=C3=A8s l'appel =C3=A0 la fonction msleep.

Tips and tricks #2. Check that the timer is ticking.

Please note that for an easier access to everybody, this list uses the
english language.

--=20
                                                                Gilles.


