Message-ID: <51E7AB87.4020403@aaton.com>
Date: Thu, 18 Jul 2013 10:47:03 +0200
From: Nicolas Pinault <nicolasp@aaton.com>
MIME-Version: 1.0
References: <51E79279.9040102@aaton.com>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F386C@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664033F386C@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RE :  i.MX6 setup
Reply-To: nicolasp@aaton.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Younes,

Le 18/07/2013 09:52, Younes CHALABI a =E9crit :
> Hi Nicolas,
>
> Do you use the L3.0.35_4.0.0 LTIB BSP for i.MX6 ?
>
> I am trying to do the same work, by deploying Xenomai on my i.MX6Q Sabr=
e Lite board.
>
> Once you have your U-Boot and Kernel from LTIB you have to :
>
> - Download xenomai and take a look at : ksrc/arch/arm/patches/mxc/READM=
E
>
> - Resume to the classic installation on : http://www.xenomai.org/docume=
ntation/xenomai-2.6/html/README.INSTALL/#arm
>
> It has been a month that I am trying to deploy but I have not secceed y=
et !
Thanks for your answer. I'll follow the links you provided me.
I'll let you know if I succeed or not.

Regards,
Nicolas
>
> Regards,
> Younes
> ________________________________________
> De : xenomai-bounces@xenomai.org [xenomai-bounces@xenomai.org] de la pa=
rt de Nicolas Pinault [nicolasp@aaton.com]
> Date d'envoi : jeudi 18 juillet 2013 09:00
> =C0 : xenomai@xenomai.org
> Objet : [Xenomai] i.MX6 setup
>
> Hi,
>
> I'm starting a new project where I have to use Linux on a i.MX6. The ne=
w
> system has real time constraints. I have chosen xenomai for the real
> time part of the software.
> I have followed Freescale documents to setup a Ubuntu virtual machine t=
o
> run ltib and cross-compile the Linux distribution delivered by
> Freescale. I now have a i.MX6 board (Sabre Smart Devices Board) booting
> U-Boot and running standard Freescale Linux.
> What's next ?
> I have read xenomai documentation but some points are not clear.
> It is said that patches have to be applied on a vanilla kernel. I guess
> the Freescale Linux distribution does not have a vanilla kernel. So how
> can I apply patches on it ?
>
> Does anyone have a detailed "howto" to setup a xenomai patched Linux fo=
r
> a i.MX6 board ?
>
> Regards,
> Nicolas
>
> PS : I guess that topic has already been discussed here but I have not
> found any archive for the current mailing list.
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


