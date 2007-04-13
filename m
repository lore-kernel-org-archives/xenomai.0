From: "Jose Pascual" <josepascual@domain.hid>
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>	<078801c77d27$5e7cc420$1b764c60$@com>
	<461E6CFE.7000004@domain.hid>
In-Reply-To: <461E6CFE.7000004@domain.hid>
Date: Fri, 13 Apr 2007 09:58:16 +0200
Message-ID: <009401c77da1$7e516a60$7af43f20$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: es
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Hi again Gilles,

Have you thought to make a only patch for at91rm9200 and at91sam9xxx (theses
chips are really quite similar)?

regards

> -----Mensaje original-----
> De: adeos-main-bounces@domain.hid [mailto:adeos-main-bounces@domain.hid] En
> nombre de Gilles Chanteperdrix
> Enviado el: jueves, 12 de abril de 2007 19:32
> Para: Jose Pascual
> CC: adeos-main@gna.org
> Asunto: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
> 
> Jose Pascual wrote:
> > HI,
> >
> > I'm working in a at91rm9200 custom board. Can I use this patch for
> > at91rm9200?
> > what should I change for at91rm9200?
> >
> > Could you send your benchmark results? (what mherz are your PLLA
> working?
> > and your Master Clock?)?
> 
> My bad, I posted this only on Xenomai mailing list and not Adeos list,
> but the at91rm9200 is already supported by the latest I-pipe patch for
> ARM. It is available as a separate patch for Linux 2.6.15 and already
> included in the patch for Linux 2.6.19.
> 
> You can download them there:
> http://svn.gna.org/svn/xenomai/trunk/ksrc/arch/arm/patches/at91/ipipe-
> 2.6.15-at91-1.5-08.patch
> http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.19-arm-
> 1.6-05.patch
> 
> --
>                                                  Gilles Chanteperdrix
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 
> __________ Informacisn de NOD32, revisisn 2184 (20070412) __________
> 
> Este mensaje ha sido analizado con  NOD32 antivirus system
> http://www.nod32.com



