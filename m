From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Thu, 18 Jul 2013 07:52:22 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664033F386C@MAIL-SINTERS-01.sinters-int.fr>
References: <51E79279.9040102@aaton.com>
In-Reply-To: <51E79279.9040102@aaton.com>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE :  i.MX6 setup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "nicolasp@aaton.com" <nicolasp@aaton.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Nicolas,

Do you use the L3.0.35_4.0.0 LTIB BSP for i.MX6 ?

I am trying to do the same work, by deploying Xenomai on my i.MX6Q Sabre Li=
te board.

Once you have your U-Boot and Kernel from LTIB you have to :

- Download xenomai and take a look at : ksrc/arch/arm/patches/mxc/README

- Resume to the classic installation on : http://www.xenomai.org/documentat=
ion/xenomai-2.6/html/README.INSTALL/#arm

It has been a month that I am trying to deploy but I have not secceed yet !

Regards,
Younes
________________________________________
De : xenomai-bounces@xenomai.org [xenomai-bounces@xenomai.org] de la part d=
e Nicolas Pinault [nicolasp@aaton.com]
Date d'envoi : jeudi 18 juillet 2013 09:00
=C0 : xenomai@xenomai.org
Objet : [Xenomai] i.MX6 setup

Hi,

I'm starting a new project where I have to use Linux on a i.MX6. The new
system has real time constraints. I have chosen xenomai for the real
time part of the software.
I have followed Freescale documents to setup a Ubuntu virtual machine to
run ltib and cross-compile the Linux distribution delivered by
Freescale. I now have a i.MX6 board (Sabre Smart Devices Board) booting
U-Boot and running standard Freescale Linux.
What's next ?
I have read xenomai documentation but some points are not clear.
It is said that patches have to be applied on a vanilla kernel. I guess
the Freescale Linux distribution does not have a vanilla kernel. So how
can I apply patches on it ?

Does anyone have a detailed "howto" to setup a xenomai patched Linux for
a i.MX6 board ?

Regards,
Nicolas

PS : I guess that topic has already been discussed here but I have not
found any archive for the current mailing list.


_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai=

