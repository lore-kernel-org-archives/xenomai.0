Date: Wed, 2 Jun 2010 23:06:35 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100602210634.GB2590@domain.hid>
References: <AANLkTimHOPpI3mst8-fM4Atf6V_-kurbqD-RKZdWDbUY@mail.gmail.com>
	<4C038E30.5070606@domain.hid>
	<AANLkTimSJSagZ2zccsNZbgNE0RDP5ECPjSNqhyvVBtgk@domain.hid>
	<AANLkTimVOpXi7D_speJ1AuygscOt8NxGt4ZP_o8Vjrql@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimVOpXi7D_speJ1AuygscOt8NxGt4ZP_o8Vjrql@domain.hid>
Subject: Re: [Xenomai-help] How to generate a waveform / digital output
 (Alexis)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Ettore Pedretti wrote:
> Hi Daniele,
> 
> Thanks again for your code. It works when I select range=0
> 
> ./analogy-waveform --r 0
> ./analogy-phasemod --r 0
> 
> I get a sine wave out of the card
> 

If you are OK with it, I will integrate this code into cmd_write (or
instead of it).

Many thanks.

> Thanks a bunch!!
> 
> Ettore
> 
> On 31 May 2010 16:24, Ettore Pedretti <ep41@domain.hid> wrote:
> > Hi Daniele,
> >
> > Thanks very much for your help. It is very appreciated. I compiled
> > your programs. When I run them I get:
> >
> > fangorn:~/control/CHAMP/analogy# ./analogy-waveform
> > amplitude=1.000000
> > offset=0.000000
> > analogy-waveform.c:364:main:DEBUG: device=analogy0 fd=0
> > analogy-waveform.c:365:main:DEBUG: subdevices=14
> > analogy-waveform.c:366:main:DEBUG: read subdevice=-1
> > analogy-waveform.c:367:main:DEBUG: write subdevice=1
> > analogy-waveform.c:368:main:DEBUG: sbsize=16456
> > analogy-waveform.c:374:main:DEBUG: subdevice=1
> > analogy-waveform.c:405:main:DEBUG: range=0 10000000 -10000000
> > analogy-waveform.c:411:main:DEBUG: min=-1.000000 max=1.000000
> > analogy-waveform.c:414:main:DEBUG: range=-1
> > analogy-waveform.c:419:main:ERROR: analogy get rngnfo
> >
> > and dmesg:
> >
> > Analogy: a4l_rt_ioctl: minor=0
> > Analogy: a4l_rt_ioctl: minor=0
> > Analogy: a4l_rt_ioctl: minor=0
> > Analogy: a4l_ioctl_cancel: minor=0
> > Analogy: a4l_ioctl_cancel: non functional subdevice
> > Analogy: a4l_rt_close: minor=0
> >
> > What am I doing wrong? do I need to pass a parameter?
> >
> > Cheers
> >
> > Ettore
> >
> > --
> > Ettore Pedretti, SUPA
> > School of Physics and Astronomy
> > University of St Andrews, North Haugh,
> > St Andrews, Fife, KY16 9SS, Scotland
> > Ph: +44-1334-461666, Fax: +44-1334-463104
> > The University of St Andrews is a charity registered in Scotland : No SC013532
> >
> 
> 
> 
> -- 
> Ettore Pedretti, SUPA
> School of Physics and Astronomy
> University of St Andrews, North Haugh,
> St Andrews, Fife, KY16 9SS, Scotland
> Ph: +44-1334-461666, Fax: +44-1334-463104
> The University of St Andrews is a charity registered in Scotland : No SC013532
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Alexis.

