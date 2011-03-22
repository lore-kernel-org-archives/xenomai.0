MIME-Version: 1.0
Date: Mon, 21 Mar 2011 22:43:02 -0300
Message-ID: <AANLkTinbWB880bzWqR2o-6Ah2A_iZCucMQU-HaOcunEL@mail.gmail.com>
From: Rodrigo Muraro <rodrigo.muraro@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d6476b6a6649049f085dcc
Subject: [Adeos-main] port du Xenomai
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--0016e6d6476b6a6649049f085dcc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Salut,

Je suis en train de porter Xenomai pour le processeur OMAP-L138.

Je suis parti du kernel 2.6.34 fourni par Texas Instruments e j'ai applique
le patch I-pipe Xenomai 2.5.4.

Ensuite j'ai suivi les indications d=E9crites dans le document suivant:
http://www.xenomai.org/index.php/I-pipe:ArmPorting

J'ai modifi=E9 que le fichier time.c du repertoire arch/arm/mach-davinci

Le kernel se bloque pendant l'initialisation du pilote USB, plus pr=E9cis=
=E9ment
apr=E8s l'appel =E0 la fonction msleep.

J'ai fait un essai en plus:
J'ai appliqu=E9 le patch Xenomai mais j'ai d=E9sactiv=E9 l'option Xenomai d=
ans le
menuconfig. La compilation s'est bien pass=E9 et le kernel s'est toujours
bloqu=E9.

Le source du kernel que j'ai parti (2.6.34 fourni par Texas Instruments)
marche bien.

Est-ce que vous pouvez m'aider?

Merci,

Rodrigo

--0016e6d6476b6a6649049f085dcc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Salut,<div><br></div><div>Je suis en train de porter Xenomai pour le proces=
seur OMAP-L138.</div><div><br></div><div>Je suis parti du kernel 2.6.34 fou=
rni par Texas Instruments e j&#39;ai applique le patch I-pipe Xenomai 2.5.4=
.</div>
<div><br></div><div>Ensuite j&#39;ai suivi les indications d=E9crites dans =
le document suivant:</div><div><span class=3D"Apple-style-span" style=3D"bo=
rder-collapse: collapse; font-family: arial, sans-serif; font-size: 13px; "=
><a href=3D"http://www.xenomai.org/index.php/I-pipe:ArmPorting" target=3D"_=
blank" style=3D"color: rgb(42, 93, 176); ">http://www.xenomai.org/index.php=
/I-pipe:ArmPorting</a></span></div>
<div><br></div><div>J&#39;ai modifi=E9 que le fichier time.c du repertoire =
arch/arm/mach-davinci</div><div><br></div><div>Le kernel se bloque pendant =
l&#39;initialisation du pilote USB, plus pr=E9cis=E9ment apr=E8s l&#39;appe=
l =E0 la fonction msleep.</div>
<div><br></div><div>J&#39;ai fait un essai en plus:</div><div>J&#39;ai appl=
iqu=E9 le patch Xenomai mais j&#39;ai d=E9sactiv=E9 l&#39;option Xenomai da=
ns le menuconfig. La compilation s&#39;est bien pass=E9 et le kernel s&#39;=
est toujours bloqu=E9.</div>
<div><br></div><div>Le source du kernel que j&#39;ai parti (2.6.34 fourni p=
ar Texas Instruments) marche bien.</div><div><br></div><div>Est-ce que vous=
 pouvez m&#39;aider?</div><div><br></div><div>Merci,</div><div><br></div>
<div>Rodrigo</div>

--0016e6d6476b6a6649049f085dcc--

