MIME-Version: 1.0
In-Reply-To: <1529421239.7462838.1439985533416.JavaMail.yahoo@mail.yahoo.com>
References: <1529421239.7462838.1439985533416.JavaMail.yahoo@mail.yahoo.com>
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Fri, 21 Aug 2015 11:18:47 +0200
Message-ID: <CA+CJOCyg6wC9=kOi_XTB2pvrv3EdafLLGqd2TcHgt=KOYWWCNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] (no subject)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: m.fawzy307@yahoo.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Mohamed,

What version of xenomai are you using ? I am going to assume 2.6.x. I
haven't worked with 3.x yet, and its architecture being different, I don't
think the following instructions would apply for it.

Installation of xenomai as explained at
http://www.xenomai.org/documentation/xenomai-head/pdf/README.INSTALL.pdf is
achieved through these steps :

   1. If you are using a non-vanilla kernel, you should check for a
   possible pre-patch specific for your kernel.

   2. Prepare your kernel by using the prepare-kernel.sh script.

   3. Again, if you are using a non-vanilla kernel, check for a possible
   post-patch to apply.

   4. Configure your kernel as you would normally do, through "make
   menuconfig" for example, and ensure the chosen configuration complies wi=
th
   xenomai requirements; see chapter "Kernel configuration" of
   http://www.xenomai.org/documentation/xenomai-head/pdf/TROUBLESHOOTING.pd=
f

   5. Build your kernel, its modules, and deploy them on your target. At
   this point, you should see a few lines during early boot process if you
   type "dmesg | grep -i xenomai".

   6. Finally, build the user-space binaries of xenomai, and deploy them on
   your target.

Maybe someone can correct me if I am wrong, but I believe the
"/proc/xenomai/version" pseudo-file is provided by the kernel, not by the
user-space binaries. So, if it is missing on your board, it means something
went wrong somewhere between steps 1 and 5.

Have you cross-compiled for the correct arch ? Providing us with the
content of your dmesg would be a starting point.

Regards,

Nicolas Schurando

2015-08-19 13:58 GMT+02:00 <m.fawzy307@yahoo.com>:

> i followed  documentation to  get xenomai up and running on a udoo board
> but when i run the latency test i get this error message : Xenomai: nativ=
e
> skin or CONFIG_XENO_OPT_PERVASIVE disabledwhen i check  Troubleshooting
> guide i found that i should have /proc/xenomai/version but in my udooubun=
tu
> the folder proc is empty
> please i need your help to fix this problem and how i can check that
> xenomai is running on my board
> Regards , Mohamed Fawzy
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>

--=20


Avant d'imprimer ce document, pensez =C3=A0 l'environnement !

Always think green before printing !

Ce courriel et toutes ses pi=C3=A8ces jointes sont confidentiels et destin=
=C3=A9s=20
exclusivement =C3=A0 l'usage de la personne =C3=A0 laquelle ils sont adress=
=C3=A9s. Si=20
vous n '=C3=AAtes pas le destinataire, nous vous informons que toute=20
utilisation, modification, diffusion, =C3=A9dition ou reproduction (totale =
ou=20
partielle) de ce courriel et/ou de ses pi=C3=A8ces jointes, ou des informat=
ions=20
qu'ils contiennent, sous quelque forme que ce soit, est strictement=20
interdite. Si vous avez re=C3=A7u ce courriel par erreur, merci imm=C3=A9di=
atement=20
d'avertir l'exp=C3=A9diteur et de le supprimer avec ses pi=C3=A8ces jointes=
 ainsi que=20
toute copie, de votre syst=C3=A8me informatique. Nous ne pouvons assurer la=
=20
s=C3=A9curit=C3=A9 des informations transmises par voie =C3=A9lectronique. =
Nous d=C3=A9clinons=20
donc toute responsabilit=C3=A9 dans l'hypoth=C3=A8se ou ce courriel et/ou s=
es pi=C3=A8ces=20
jointes auraient =C3=A9t=C3=A9 notamment modifi=C3=A9s, alt=C3=A9r=C3=A9s e=
t/ou en cas de=20
transmission d'un virus. Par cons=C3=A9quent, en communiquant avec nous vou=
s=20
acceptez ces risques. Nous vous conseillons de v=C3=A9rifier l'absence de v=
irus=20
dans ce courriel et ses pi=C3=A8ces jointes.

This e-mail and its attachments are confidential and intended for use by=20
the above named recipient(s) only. If you are not the intended recipient,=
=20
please note that any use, modification, dissemination, edition or=20
reproduction (either in whole or partially) of this e-mail and/or its=20
attachments, or of the information contained herein, is strictly=20
prohibited. If you have received this e-mail by mistake, please notify the=
=20
sender immediately, and immediately delete this e-mail with its attachments=
=20
and any copy of it from your computer system. We do not ensure the security=
=20
of electronically transmitted information. Therefore, we take no=20
responsibility in the event this email and/or its attachments may have been=
=20
for example modified, altered and/or in the case of transmission of a=20
virus. Your communication with us through such means shall signify your=20
acceptance of such risks. We kindly advise you to check whether this email=
=20
or its attachments are free of viruses.
