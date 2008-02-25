From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 25 Feb 2008 04:51:22 +0100
References: <606588375@domain.hid>
In-Reply-To: <606588375@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802250451.22841.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and Virtex II Pro (PPC405)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Joachim Meyer <Jogi95@domain.hid>

Hi, 

> >Correct me if am wrong,but for me, a Virtex II Pro contains 1 (maybe 2)
> >hardwired PPC405 core(s) inside the FPGA. But compared to common AMCC or
> >Freescale PPC micro-controllers, you have to instanciante in VHDL some
> >peripherals / controllers or some glue towards them. You have to build
> > your own micro-controller, haven't you ?
>
> I don't think you have to add any VHDL Code for the ppc (2 of them on my
> V2) But I use a Kernel from here
> http://git.xilinx.com/cgi-bin/gitweb.cgi?p=linux-2.6-xlnx.git;a=summary
> because there are already some drivers for my Evaluation Board intergrated.

I don't understand: I thought only the PPC405 cores were implemented as hard 
IPs inside the FPGA, not the DDR/SDRAM controller, the EBC, etc.

> >Consequently, as soon as you make Linux run on it, I can see no reason why
> > you would get trouble with Xenomai. Even if you had to cope with such a
> > predicament, the problem(s) would be bound to be located in ipipe, not in
> > Xenomai. Keep in mind that RTAI seems to be based on ipipe too.
>
> I already got some trouble. But this could also be because I don't know 
> what exactly to do. Is there a good Step by Step howto you know? I don't
> think one of the howtos at the xenomai site explains how to setup xenomai.

Maybe the document README.INSTALL (located at the root of Xenomai archive) 
would be a goot start point. It explains how to compile and install Xenomail 
on your machine.

Have you already patched your kernel with Ipipe ?

> What is this ipipe thing?

Maybe I should have said "Adeos". You will find a related paper at the 
following address:

http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf

> >Which framework ?
>
> An application, basing on this framework (written by someone at my college,
> who isn't here anymore), which bases on rtai, was running on linux on a
> celeron. This application should be ported to the Virtex 2 Pro by me. So I
> ask myself how hard it would be, to use Xenomai (perhaps with this "rtai
> skin??") instead of rtai.

It depends on the RTAI functions which are called in your framework. I am not 
sure that 100% of the API is implemented. I did not have time to have a 
closer look... Maybe someone else has the answer...

Regards.

Alexis.


