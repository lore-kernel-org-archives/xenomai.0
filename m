Message-ID: <4EF1C18C.3020407@domain.hid>
Date: Wed, 21 Dec 2011 12:22:52 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------050500090502070309010101"
Subject: [Xenomai-help] Xenomai rtcan build issue on MPC5121 (kernel >=
	2.6.35)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050500090502070309010101
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Dear all,

I'm trying to build xenomai-2.6.0 with kernel 3.0.4 for powerpc (MPC5121).
some config options:
CONFIG_PPC_MPC512x=3Dy
CONFIG_XENO_DRIVERS_CAN=3Dm
CONFIG_XENO_DRIVERS_CAN_MSCAN=3Dm

Using CAN support leads to compile errors:
   CC [M]  drivers/xenomai/can/mscan/rtcan_mscan.o
   CC [M]  drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.o
drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c: In function=20
'mpc512x_can_get_clock':
drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c:158:30: error: 'struct=20
platform_device' has no member named 'node'
drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c:174:41: error: 'struct=20
platform_device' has no member named 'node'
drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c:178:31: error: 'struct=20
platform_device' has no member named 'node'
make[5]: *** [drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.o] Error 1


I'm a bit surprised as I found a xenomai git commit that seem to handle=20
this issue when building with CONFIG_PPC_MPC52xx:
- can: adapt to platform driver infrastructure changes for 2 .6.35
http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommit;h=3D50b289784ef2b07=
34bef1e99b008ff4b79ad5409


I believe this issue can be fixed for MPC512x as well, by using same=20
principle. Is it correct to do so?

Index: xenomai-2.6.0/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.6.0.orig/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c   =20
2011-10-18 20:17:18.000000000 +0200
+++ xenomai-2.6.0/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c   =20
2011-12-21 11:52:43.000000000 +0100
@@ -155,7 +155,7 @@
      }

      /* Determine the MSCAN device index from the physical address */
-    pval =3D of_get_property(ofdev->node, "reg", &plen);
+    pval =3D of_get_property(mpc5xxx_get_of_node(ofdev), "reg", &plen);
      BUG_ON(!pval || plen < sizeof(*pval));
      clockidx =3D (*pval & 0x80) ? 1 : 0;
      if (*pval & 0x2000)
@@ -171,11 +171,11 @@
       */
      if (clock_name && !strcmp(clock_name, "ip")) {
          *mscan_clksrc =3D MSCAN_CLKSRC_IPS;
-        freq =3D mpc5xxx_get_bus_frequency(ofdev->node);
+        freq =3D mpc5xxx_get_bus_frequency(mpc5xxx_get_of_node(ofdev));
      } else {
          *mscan_clksrc =3D MSCAN_CLKSRC_BUS;

-        pval =3D of_get_property(ofdev->node,
+        pval =3D of_get_property(mpc5xxx_get_of_node(ofdev),
                         "fsl,mscan-clock-divider", &plen);
          if (pval && plen =3D=3D sizeof(*pval))
              clockdiv =3D *pval;




If it's ok, can it be integrated into xenomai-head?

Thanks in advance,

Fabrice Gasnier

--=20

Fabrice GASNIER, Ing=E9nieur Syst=E8mes Embarqu=E9s
Email: fabrice.gasnier@domain.hid <mailto:fabrice.gasnier@domain.hid>

D=E9couvrez notre catalogue de formations 2011=20
<http://www.cenosys.com/contenu/pdf/catalogue.pdf>

<http://www.cenosys.com>

10 rue Xavier Bichat - 72000 Le Mans - France - Tel: +33(0)2 43 51 17 97=20
- Fax: +33(0)2 43 51 17 98 - www.cenosys.com <http://www.cenosys.com>

CONFIDENTIALIT=C9 : Ce message =E9lectronique et tous les fichiers attach=
=E9s=20
qu'il contient sont confidentiels et destin=E9s exclusivement =E0 l'usage d=
e=20
la personne =E0 laquelle ils sont adress=E9s. Si vous avez re=E7u ce messag=
e=20
par erreur, merci de le retourner imm=E9diatement =E0 son =E9metteur sans e=
n=20
conserver de copie.

CONFIDENTIALITY : This e-mail and any attachments are confidential and=20
may also be privileged. If you are not the named recipient, please=20
notify the sender immediately and do not disclose the contents to an=20
other person, use it for any purpose, or store or copy the information=20
in any medium.


--------------050500090502070309010101
Content-Type: multipart/related;
 boundary="------------010600040604090605080501"


--------------010600040604090605080501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Dear all,<br>
    <br>
    I'm trying to build xenomai-2.6.0 with kernel 3.0.4 for powerpc
    (MPC5121).<br>
    some config options:<br>
    CONFIG_PPC_MPC512x=y<br>
    CONFIG_XENO_DRIVERS_CAN=m<br>
    CONFIG_XENO_DRIVERS_CAN_MSCAN=m<br>
    <br>
    Using CAN support leads to compile errors:<br>
    &nbsp; CC [M]&nbsp; drivers/xenomai/can/mscan/rtcan_mscan.o<br>
    &nbsp; CC [M]&nbsp; drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.o<br>
    drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c: In function
    'mpc512x_can_get_clock':<br>
    drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c:158:30: error:
    'struct platform_device' has no member named 'node'<br>
    drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c:174:41: error:
    'struct platform_device' has no member named 'node'<br>
    drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.c:178:31: error:
    'struct platform_device' has no member named 'node'<br>
    make[5]: *** [drivers/xenomai/can/mscan/rtcan_mscan_mpc5xxx.o] Error
    1<br>
    <br>
    <br>
    I'm a bit surprised as I found a xenomai git commit that seem to
    handle this issue when building with CONFIG_PPC_MPC52xx:<br>
    - can: adapt to platform driver infrastructure changes for 2 .6.35<br>
<a class="moz-txt-link-freetext" href="http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=50b289784ef2b0734bef1e99b008ff4b79ad5409">http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=50b289784ef2b0734bef1e99b008ff4b79ad5409</a><br>
    <br>
    <br>
    I believe this issue can be fixed for MPC512x as well, by using same
    principle. Is it correct to do so?<br>
    <br>
    Index: xenomai-2.6.0/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c<br>
    ===================================================================<br>
    ---
    xenomai-2.6.0.orig/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c&nbsp;&nbsp;&nbsp;
    2011-10-18 20:17:18.000000000 +0200<br>
    +++ xenomai-2.6.0/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c&nbsp;&nbsp;&nbsp;
    2011-12-21 11:52:43.000000000 +0100<br>
    @@ -155,7 +155,7 @@<br>
    &nbsp;&nbsp;&nbsp;&nbsp; }<br>
    &nbsp;<br>
    &nbsp;&nbsp;&nbsp;&nbsp; /* Determine the MSCAN device index from the physical address
    */<br>
    -&nbsp;&nbsp;&nbsp; pval = of_get_property(ofdev-&gt;node, "reg", &amp;plen);<br>
    +&nbsp;&nbsp;&nbsp; pval = of_get_property(mpc5xxx_get_of_node(ofdev), "reg",
    &amp;plen);<br>
    &nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!pval || plen &lt; sizeof(*pval));<br>
    &nbsp;&nbsp;&nbsp;&nbsp; clockidx = (*pval &amp; 0x80) ? 1 : 0;<br>
    &nbsp;&nbsp;&nbsp;&nbsp; if (*pval &amp; 0x2000)<br>
    @@ -171,11 +171,11 @@<br>
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<br>
    &nbsp;&nbsp;&nbsp;&nbsp; if (clock_name &amp;&amp; !strcmp(clock_name, "ip")) {<br>
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mscan_clksrc = MSCAN_CLKSRC_IPS;<br>
    -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; freq = mpc5xxx_get_bus_frequency(ofdev-&gt;node);<br>
    +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; freq =
    mpc5xxx_get_bus_frequency(mpc5xxx_get_of_node(ofdev));<br>
    &nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mscan_clksrc = MSCAN_CLKSRC_BUS;<br>
    &nbsp;<br>
    -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pval = of_get_property(ofdev-&gt;node,<br>
    +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pval = of_get_property(mpc5xxx_get_of_node(ofdev),<br>
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "fsl,mscan-clock-divider", &amp;plen);<br>
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (pval &amp;&amp; plen == sizeof(*pval))<br>
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clockdiv = *pval;<br>
    <br>
    <br>
    <br>
    <br>
    If it's ok, can it be integrated into xenomai-head?<br>
    <br>
    Thanks in advance,<br>
    <br>
    Fabrice Gasnier<br>
    <br>
    <div class="moz-signature">-- <br>
      <p style="font-size: 9pt;"> Fabrice GASNIER, Ing&eacute;nieur Syst&egrave;mes
        Embarqu&eacute;s<br>
        Email: <a href="mailto:fabrice.gasnier@domain.hid"
          style="color: rgb(144, 150, 157);">fabrice.gasnier@domain.hid</a></p>
      <p style="color: rgb(0, 51, 102); font-size: 8pt;"> D&eacute;couvrez
        notre <a moz-do-not-send="true"
          href="http://www.cenosys.com/contenu/pdf/catalogue.pdf"
          name="Catalogue de formations 2011" style="color: rgb(0, 51,
          102); font-weight: bold;"> catalogue de formations 2011 </a>
        <br>
      </p>
      <p> <a href="http://www.cenosys.com"> <img alt=""
            src="cid:part1.00050903.02020001@domain.hid" style="height:
            40px; border: medium none;"> </a> </p>
      <p style="font-size: 8pt; font-weight: bold;"> 10 rue Xavier
        Bichat - 72000 Le Mans - France - Tel: +33(0)2 43 51 17 97 -
        Fax: +33(0)2 43 51 17 98 - <a href="http://www.cenosys.com"
          style="color: rgb(0, 51, 102);">www.cenosys.com</a> </p>
      <p style="font-size: 8pt;"> CONFIDENTIALIT&Eacute; : Ce message
        &eacute;lectronique et tous les fichiers attach&eacute;s qu'il contient sont
        confidentiels et destin&eacute;s exclusivement &agrave; l'usage de la personne
        &agrave; laquelle ils sont adress&eacute;s. Si vous avez re&ccedil;u ce message par
        erreur, merci de le retourner imm&eacute;diatement &agrave; son &eacute;metteur sans
        en conserver de copie. </p>
      <p style="font-size: 8pt;"> CONFIDENTIALITY : This e-mail and any
        attachments are confidential and may also be privileged. If you
        are not the named recipient, please notify the sender
        immediately and do not disclose the contents to an other person,
        use it for any purpose, or store or copy the information in any
        medium. </p>
    </div>
  </body>
</html>

--------------010600040604090605080501
Content-Type: image/png;
 name="pied-mail.png"
Content-Transfer-Encoding: base64
Content-ID: <part1.00050903.02020001@domain.hid>
Content-Disposition: inline;
 filename="pied-mail.png"

iVBORw0KGgoAAAANSUhEUgAABAAAAABPCAMAAABCgkcbAAAAGXRFWHRTb2Z0d2FyZQBBZG9i
ZSBJbWFnZVJlYWR5ccllPAAAAwBQTFRFNSFqwsXJU0qQWX623NziRmqrrbG25ObpaIq/Pl2k
vcnhvcHFpLjXsqvHNiNwATNmsbW6OU2a9fb4OlGds7rYNzuNiqPLOCl4d4W6PFegla3R+vr7
TnWwN0KUur7CtLi92OHuaXKvnaKpxM3i9PX2Qmepqa6zQGKnSnCu2dve09XYoKWr8PHylJqh
c5LD7u7w/v7/5eryY1WQpquxy87Ro6iunbLUgYy+kJWckpiemZ+lOEmYm6CmzMneztDU5ujp
RTJ1s8Hcq6fJT1yj3NzqdWaY/Pz9YoW7xcjLNB5m9vj7VmipeHSruLzAzNPmlKnO3uDi8vL0
+vr6OS+B0NPW4OLkNB9p4uTm/P3+lpyikZfDPFehOC6AfZTEP2GneXyy4efxxNHl6uvtXYG5
VXqz8fT5Unax6e31+Pj7Z3223uTw0tzrnKTLwsbe+Pj53uHu7O3vhJnGSG6tN0SVjYW00s7e
V3y1Zom+iZPCyMvPQGKo7/Dxt8XeWXu07PD3v7rTn7LFe5nGeGygXYK5NzeJS3GuOjmLU3qz
o53Cw8HX1tjby8XZ8/T0urPMipnG7vL4pa3QjIKtO1Oel4ywjJ3I2NXjNzSGN0iXVHmyNz2P
hnqkPVKeOSx9PlSeN0mY8PP4iYu8Unmyf5vHbY7AzNbo8O70hJ/J5+Xu4d7pYm6tkKXMTnSv
OU6bUXOW6+zuRDaD6Onr4+Xnt7u/ODaIk4iwhJXE1tLhXoK5j6W7T3iyEUBw7vL3Q2Wp6ujw
XYK6WHizfI2/UEGDkJadXoK6v8zZPSlwv8zYgJmyQWaMz9ni7/L13+XsQWeM3+bsXoO6kZed
f5myQGaMtLDOkZeeOEmXU3q0kZadk5mfl52jUHix+/v8uLvAub3BPC18+/z9+fn6YIO7cY2p
xcjfyMLWXYG4YYCfppy86+/2QE+bPEiYYYCgO1CcUXOwzdnql5K+v8PHWnez0tfphpC/SGSq
/f3+u7/Dq77avMDEQC10RGKoh4e4NyVz6Oz0+fr8+Pf6////2lRuEAAAGuZJREFUeNrsXQtg
VNWZTgSHp5AERSCQuBGCIQ8GhmAmRBAfSUTRREBIgwgE12oVqSiIaX0FpKW0VauudjUWUFRA
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
--------------010600040604090605080501--

--------------050500090502070309010101--

