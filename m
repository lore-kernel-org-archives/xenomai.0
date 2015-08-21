Date: Fri, 21 Aug 2015 11:21:35 +0000 (UTC)
From: =?UTF-8?Q?=E2=80=ABMohamed_Fawzy=E2=80=AC_=E2=80=AB?=
 <m.fawzy307@yahoo.com>
Message-ID: <1411454298.8857036.1440156095338.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <CA+CJOCyg6wC9=kOi_XTB2pvrv3EdafLLGqd2TcHgt=KOYWWCNQ@mail.gmail.com>
References: <CA+CJOCyg6wC9=kOi_XTB2pvrv3EdafLLGqd2TcHgt=KOYWWCNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?b?2KjYrti12YjYtTogIChubyBzdWJqZWN0KQ==?=
Reply-To: =?UTF-8?Q?=E2=80=ABMohamed_Fawzy=E2=80=AC_=E2=80=AB?=
 <m.fawzy307@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi nicolas=C2=A0
=C2=A0thanks for your reply
it's very appreciated
=C2=A0=C2=A0i used xenomai 2.6.4 and kernel 3.0.43 =C2=A0and patch=C2=A0ade=
os-ipipe-3.0.43-mx6q-1.18-14.patch
is it the right patch ? and how i can check what is the possible patch ?=C2=
=A0

proc folder isn't empty but doesn't contain xenomai folder=C2=A0

thanks again and i hope you reply and help me=C2=A0
Regards=C2=A0      =D9=85=D9=86: Nicolas SCHURANDO <schurann@ext.essilor.co=
m>
 =D8=A5=D9=84=D9=89: m.fawzy307@yahoo.com=20
=D9=86=D8=B3=D8=AE=D8=A9 =D9=83=D8=B1=D8=A8=D9=88=D9=86=D9=8A=D8=A9: "xenom=
ai@xenomai.org" <xenomai@xenomai.org>=20
 =D8=AA=D8=A7=D8=B1=D9=8A=D8=AE =D8=A7=D9=84=D8=A5=D8=B1=D8=B3=D8=A7=D9=84:=
 =D8=A7=D9=84=D8=AC=D9=85=D8=B9=D8=A9 21 =D8=A3=D8=BA=D8=B3=D8=B7=D8=B3=D8=
=8C 2015=E2=80=8F 11:18 =D8=B5
 =D8=A7=D9=84=D9=85=D9=88=D8=B6=D9=88=D8=B9: Re: [Xenomai] (no subject)
  =20
Hi Mohamed,
What version of xenomai are you using ? I am going to assume 2.6.x. I haven=
't worked with 3.x yet, and its architecture being different, I don't think=
 the following instructions would apply for it.
Installation of xenomai as explained at http://www.xenomai.org/documentatio=
n/xenomai-head/pdf/README.INSTALL.pdf is achieved through these steps :  =
=20
   - If you are using a non-vanilla kernel, you should check for a possible=
 pre-patch specific for your kernel.  =20
  =20

   - Prepare your kernel by using the prepare-kernel.sh script.  =20
  =20

   - Again, if you are using a non-vanilla kernel, check for a possible pos=
t-patch to apply.  =20
  =20

   - Configure your kernel as you would normally do, through "make menuconf=
ig" for example, and ensure the chosen configuration complies with xenomai =
requirements; see chapter "Kernel configuration" of http://www.xenomai.org/=
documentation/xenomai-head/pdf/TROUBLESHOOTING.pdf  =20
  =20

   - Build your kernel, its modules, and deploy them on your target. At thi=
s point, you should see a few lines during early boot process if you type "=
dmesg | grep -i xenomai".  =20
  =20

   - Finally, build the user-space binaries of xenomai, and deploy them on =
your target.
Maybe someone can correct me if I am wrong, but I believe the "/proc/xenoma=
i/version" pseudo-file is provided by the kernel, not by the user-space bin=
aries. So, if it is missing on your board, it means something went wrong so=
mewhere between steps 1 and 5.
Have you cross-compiled for the correct arch ? Providing us with the conten=
t of your dmesg would be a starting point.
Regards,
Nicolas Schurando


2015-08-19 13:58 GMT+02:00 <m.fawzy307@yahoo.com>:

i followed =C2=A0documentation to =C2=A0get xenomai up and running on a udo=
o board=C2=A0
but when i run the latency test i get this error message :=C2=A0Xenomai: na=
tive skin or CONFIG_XENO_OPT_PERVASIVE disabledwhen i check =C2=A0Troublesh=
ooting guide i found that i should have /proc/xenomai/version=C2=A0but in m=
y udooubuntu the folder proc is empty=C2=A0
please i need your help to fix this problem and how i can check that xenoma=
i is running on my board=C2=A0
Regards ,=C2=A0Mohamed Fawzy
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://xenomai.org/mailman/listinfo/xenomai



Avant d'imprimer ce document, pensez =C3=A0 l'environnement !Always think g=
reen before printing !Ce courriel et toutes ses pi=C3=A8ces jointes sont co=
nfidentiels et destin=C3=A9s exclusivement =C3=A0 l'usage de la personne =
=C3=A0 laquelle ils sont adress=C3=A9s. Si vous n '=C3=AAtes pas le destina=
taire, nous vous informons que toute utilisation, modification, diffusion, =
=C3=A9dition ou reproduction (totale ou partielle) de ce courriel et/ou de =
ses pi=C3=A8ces jointes, ou des informations qu'ils contiennent, sous quelq=
ue forme que ce soit, est strictement interdite. Si vous avez re=C3=A7u ce =
courriel par erreur, merci imm=C3=A9diatement d'avertir l'exp=C3=A9diteur e=
t de le supprimer avec ses pi=C3=A8ces jointes ainsi que toute copie, de vo=
tre syst=C3=A8me informatique. Nous ne pouvons assurer la s=C3=A9curit=C3=
=A9 des informations transmises par voie =C3=A9lectronique. Nous d=C3=A9cli=
nons donc toute responsabilit=C3=A9 dans l'hypoth=C3=A8se ou ce courriel et=
/ou ses pi=C3=A8ces jointes auraient =C3=A9t=C3=A9 notamment modifi=C3=A9s,=
 alt=C3=A9r=C3=A9s et/ou en cas de transmission d'un virus. Par cons=C3=A9q=
uent, en communiquant avec nous vous acceptez ces risques. Nous vous consei=
llons de v=C3=A9rifier l'absence de virus dans ce courriel et ses pi=C3=A8c=
es jointes.This e-mail and its attachments are confidential and intended fo=
r use by the above named recipient(s) only. If you are not the intended rec=
ipient, please note that any use, modification, dissemination, edition or r=
eproduction (either in whole or partially) of this e-mail and/or its attach=
ments, or of the information contained herein, is strictly prohibited. If y=
ou have received this e-mail by mistake, please notify the sender immediate=
ly, and immediately delete this e-mail with its attachments and any copy of=
 it from your computer system. We do not ensure the security of electronica=
lly transmitted information. Therefore, we take no responsibility in the ev=
ent this email and/or its attachments may have been for example modified, a=
ltered and/or in the case of transmission of a virus. Your communication wi=
th us through such means shall signify your acceptance of such risks. We ki=
ndly advise you to check whether this email or its attachments are free of =
viruses.

  
