MIME-Version: 1.0
In-Reply-To: <4B864299.90802@domain.hid>
References: <4B856ADF.1030100@domain.hid> <4B858711.9040806@domain.hid>
	<4B85E29D.2000202@domain.hid> <4B862216.10100@domain.hid>
	<4B8629E9.6030006@domain.hid> <4B864299.90802@domain.hid>
Date: Thu, 25 Feb 2010 15:10:08 -0300
Message-ID: <8b216e9e1002251010r272732b5u1f66b579333991d0@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/mixed; boundary=000e0cd2e174713621048070b15a
Subject: Re: [Xenomai-help] OpenEmbedded (bitbake) recipes for Xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

--000e0cd2e174713621048070b15a
Content-Type: multipart/alternative; boundary=000e0cd2e174713619048070b158

--000e0cd2e174713619048070b158
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I've actually made my recipes for Xenomai before - they are very
straightforward. All I do is to patch the kernel (using the
prepare-kernel.sh script included in Xenomai), build and configure it, and
than build a separate .ipk for the Xenomai user-space.

Anyway, I've done this in the Gumstix Verdex and in the IGEPv2. For the
Gumstix, I made a *very* unclean solution, which meant copying the compiled
files from the temporary directory to the board once everything was
compiled. Someone made a cleaner solution, and it is described in the
Gusmtix wiki:
http://www.gumstix.net/wiki/index.php?title=3DXenomai_-_Mini_Howto

I am attaching my bitbake file as well. I've also attached my
Xenomai-exercises bitbake recipes/code, which compile cleanly on my machine
because of some very weird links I've made.

As for the IGEP, I had to make some modifications in the configuration
files, as described in a previous thread here in the mailing list (see
http://www.mail-archive.com/xenomai@xenomai.org). I am
attaching it as well, but I also transferred the files and ran ldconfig
manually.

If possible, I would like some feedback on how well Xenomai runs in the
Beagleboard - we are trying it on the IGEPv2 here, but some Beagleboards an=
d
Gumstix Overos are on the way so we can evaluate their use in different
embedded systems.

Hope this helps!
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

On Thu, Feb 25, 2010 at 6:27 AM, Bob Feretich
<bob.feretich@domain.hid>wrote:

> The xenomai-help archives show that some people are using OpenEmbedded
> to build Xenomai into various Linux distributions. (I am most interested
> in Angstrom, but other distributions would also be of interest.)
>
> Does anyone know where the bitbake recipes for this can be found?
>
> Thanks,
> Bob Feretich
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--000e0cd2e174713619048070b158
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;ve actually made my recipes for Xenomai before - they are very straig=
htforward. All I do is to patch the kernel (using the prepare-kernel.sh scr=
ipt included in Xenomai), build and configure it, and than build a separate=
 .ipk for the Xenomai user-space.<br>
<br>Anyway, I&#39;ve done this in the Gumstix Verdex and in the IGEPv2. For=
 the Gumstix, I made a *very* unclean solution, which meant copying the com=
piled files from the temporary directory to the board once everything was c=
ompiled. Someone made a cleaner solution, and it is described in the Gusmti=
x wiki:<br>
<a href=3D"http://www.gumstix.net/wiki/index.php?title=3DXenomai_-_Mini_How=
to">http://www.gumstix.net/wiki/index.php?title=3DXenomai_-_Mini_Howto</a><=
br><br>I am attaching my bitbake file as well. I&#39;ve also attached my Xe=
nomai-exercises bitbake recipes/code, which compile cleanly on my machine b=
ecause of some very weird links I&#39;ve made.<br>
<br>As for the IGEP, I had to make some modifications in the configuration =
files, as described in a previous thread here in the mailing list (see <a h=
ref=3D"http://www.mail-archive.com/xenomai@xenomai.org">http=
://www.mail-archive.com/xenomai@xenomai.org</a>). I am attac=
hing it as well, but I also transferred the files and ran ldconfig manually=
.<br>
<br>If possible, I would like some feedback on how well Xenomai runs in the=
 Beagleboard - we are trying it on the IGEPv2 here, but some Beagleboards a=
nd Gumstix Overos are on the way so we can evaluate their use in different =
embedded systems.<br>
<br>Hope this helps!<br>=A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =
=A0 =A0 LARA - Robotics and Automation Laboratory<br> =A0 =A0 =A0 Departmen=
t of Electrical Engineering<br> =A0 =A0 =A0 UnB - University of Bras=EDlia,=
 Brazil<br> =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">h=
ttp://www.lara.unb.br/~fbcavalcanti/</a><br>
<br><div class=3D"gmail_quote">On Thu, Feb 25, 2010 at 6:27 AM, Bob Feretic=
h <span dir=3D"ltr">&lt;<a href=3D"mailto:bob.feretich@domain.hid">bob=
.feretich@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
The xenomai-help archives show that some people are using OpenEmbedded<br>
to build Xenomai into various Linux distributions. (I am most interested<br=
>
in Angstrom, but other distributions would also be of interest.)<br>
<br>
Does anyone know where the bitbake recipes for this can be found?<br>
<br>
Thanks,<br>
Bob Feretich<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</blockquote></div>

--000e0cd2e174713619048070b158--

--000e0cd2e174713621048070b15a
Content-Type: application/octet-stream; name="xenomai.bb"
Content-Disposition: attachment; filename="xenomai.bb"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g63udhh90

REVTQ1JJUFRJT04gPSAiWGVub21haSAyLjQuNi4xIgoKUFIgPSAicjAiCgpERVBFTkRTID0gIiIK
CkZJTEVTXyR7UE59LWRiZyA9ICIvdXNyL3hlbm9tYWkgL2RldiIKClNSQ19VUkkgPSAiIGh0dHA6
Ly9kb3dubG9hZC5nbmEub3JnL3hlbm9tYWkvc3RhYmxlL3hlbm9tYWktMi40LjYuMS50YXIuYnoy
IFwKICIKClMgPSAiJHtXT1JLRElSfS94ZW5vbWFpLTIuNC42LjEiCgppbmhlcml0IGF1dG90b29s
cwoKZG9fY29uZmlndXJlICgpIHsKCS4vY29uZmlndXJlIC0tZW5hYmxlLWFybS1tYWNoPXB4YTN4
eCAtLWhvc3Q9YXJtLWxpbnV4Cn0KCmRvX2NvbXBpbGUoKSB7CglvZV9ydW5tYWtlCn0KCmZha2Vy
b290IGRvX2luc3RhbGwoKSB7CglvZV9ydW5tYWtlICJERVNURElSPSR7RH0iIGluc3RhbGwKIwly
bSAtcmYgJHtEfS94ZW5vbWFpL3NoYXJlL2RvYy8KfQo=
--000e0cd2e174713621048070b15a
Content-Type: application/x-gzip; name="xenomai_exercises.tar.gz"
Content-Disposition: attachment; filename="xenomai_exercises.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g63ug3fe1

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
--000e0cd2e174713621048070b15a
Content-Type: application/octet-stream; name="xenomai_igep.bb"
Content-Disposition: attachment; filename="xenomai_igep.bb"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g63vc1t12

U0VDVElPTiA9ICJiYXNlIgpERVNDUklQVElPTiA9ICJ4ZW5vbWFpIgpMSUNFTlNFID0gInhlbm9t
YWkiClBOID0gInhlbm9tYWkiClBWID0gIjIuNS4xIgoKaW5oZXJpdCBhdXRvdG9vbHMKClNSQ19V
UkkgPSAiaHR0cDovL2Rvd25sb2FkLmduYS5vcmcveGVub21haS9zdGFibGUveGVub21haS0ke1BW
fS50YXIuYnoyIgoKUyA9ICIke1dPUktESVJ9L3hlbm9tYWktMi41LjEiCgpkb19jb25maWd1cmUo
KSB7CgkuL2NvbmZpZ3VyZSAtLXByZWZpeD0vdXNyIC0taW5jbHVkZWRpcj0vdXNyL2luY2x1ZGUv
eGVub21haSAtLWVuYWJsZS1hcm0tbWFjaD1vbWFwMyAtLWVuYWJsZS1hcm0tZWFiaSAtLWVuYWJs
ZS1hcm0tdHNjIC0tZGlzYWJsZS1kb3gtZG9jIC0tZGlzYWJsZS1kYnggLS1ob3N0PWFybS1ub25l
LWxpbnV4LWdudWVhYmkKfQoKZG9fY29tcGlsZSgpIHsKCW9lX3J1bm1ha2UKfQoKZG9faW5zdGFs
bCgpIHsKICAgIG9lX3J1bm1ha2UgJ0RFU1RESVI9JHtEfScgJ1NVRE89L2Jpbi90cnVlJyBpbnN0
YWxsCn0KClBBQ0tBR0VTID0gIiR7UE59IgpGSUxFU18ke1BOfSA9ICIvZGV2LyogL3Vzci9iaW4v
KiAvdXNyL2xpYi8qIC91c3IvaW5jbHVkZS8qIgoK
--000e0cd2e174713621048070b15a--

