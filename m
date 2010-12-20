From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <957881.73468.qm@domain.hid>
References: <613800.93095.qm@domain.hid>
	<1292853709.2007.7.camel@domain.hid>
	<957881.73468.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Dec 2010 16:04:29 +0100
Message-ID: <1292857469.2007.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting on ARM-11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Usama Masood <mirza.usama@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-12-20 at 06:03 -0800, Usama Masood wrote:
> 
> Thanks man but the list have no ARM11 processor ......
> 

First line of the ARM SoC section there: Integrator/CP. Which is a
versatile platform supporting different processors. Now, with a bit more
curiosity, excerpt from ksrc/arch/arm/patches/README from a Xenomai
tarball:

-- supported boards

o ARM Integrator/CP ARM 1136

Which in fact means that "porting to ARM11" as a processor family does
not mean much. But I'm a bit new to Xenomai as well and you do need
accurate info, so I'll let other people pick up.

> 
> 
> ______________________________________________________________________
> From: Philippe Gerum <rpm@xenomai.org>
> To: Usama Masood <mirza.usama@domain.hid>
> Cc: xenomai@xenomai.org
> Sent: Mon, December 20, 2010 7:01:49 PM
> Subject: Re: [Xenomai-help] Porting on ARM-11
> 
> On Mon, 2010-12-20 at 05:53 -0800, Usama Masood wrote:
> > 
> > I am new at RTAI and i want to port Xenomai on ARM 11. Any
> direction?
> > Thankyou.
> > 
> 
> Well, we are new to RTAI as well. Maybe this would help:
> 
> http://xenomai.org/index.php/Embedded_Device_Support#Supported_SoC
> 
> > Usama Masood
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> 
> -- 
> Philippe.
> 
> 
> 
> 

-- 
Philippe.



