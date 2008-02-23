From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sat, 23 Feb 2008 01:03:21 +0100
References: <605030777@domain.hid>
In-Reply-To: <605030777@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802230103.21647.berlemont.hauw@domain.hid>
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

Hi,

> 1: I wanted to use RTAI on an Linux I compiled myself for a ppc405 core on
> a Virtex II pro. But I realized that the support of xenomai for the ppc405
> seems a lot better. Has anyone expirience with that and can give me some
> tips? I use the XUP Board from Xilinx:
> http://www.xilinx.com/univ/xupv2p.html

Correct me if am wrong,but for me, a Virtex II Pro contains 1 (maybe 2) 
hardwired PPC405 core(s) inside the FPGA. But compared to common AMCC or 
Freescale PPC micro-controllers, you have to instanciante in VHDL some 
peripherals / controllers or some glue towards them. You have to build your 
own micro-controller, haven't you ?

Consequently, as soon as you make Linux run on it, I can see no reason why you 
would get trouble with Xenomai. Even if you had to cope with such a 
predicament, the problem(s) would be bound to be located in ipipe, not in 
Xenomai. Keep in mind that RTAI seems to be based on ipipe too.  

Anyway, if you encounter troubles, I would advice you to have a look at your 
IRQ controller; just in case, the PPC405 core is interfaced with an external 
IRQ controller... maybe someone else has more accurate info on Virtex II pro 
PPC405...

Just to reassure you, I had opportunities to work with various AMCC CPU (405, 
440) and a little bit with FREESCALE components (PQ2, PQ3); everything was 
fine with Xenomai.

> 2: There is also an framework wich depends on RTAI. Can I use that
> framework with xenomai and this rtai-skin I read about?

Which framework ?

Alexis.


