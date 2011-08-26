In-Reply-To: <4E580D8D.80002@domain.hid>
MIME-Version: 1.0
From: George Broz <GBroz@domain.hid>
Message-ID: <OFF5A1868E.F6AC0BF7-ON882578F8.0076FF3F-882578F8.00784B5F@moog.com>
Date: Fri, 26 Aug 2011 14:49:17 -0700
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai-help] milli-second overruns under heavy load on x86,
 running Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
08/26/2011 02:18:05 PM:
> On 08/26/2011 10:42 PM, George Broz wrote:
> > Hello,
> > 
> > I'm experiencing very large overruns in the neighborhood of 10 to 50 
> > *milli-seconds* as reported by the Xenomai latency tool in user-task 
mode 
> > whenever the Linux OS is heavily loaded. Under lighter loads these are 
in 
> > the 30 to 70 micro-second (normal) range. 
> > 
> > My system is:
> > - Linux 2.6.37.6 (32-bit), Ubuntu 10.10 distribution
> > - Xenomai 2.5.6 using I-pipe patch adeos-ipipe-2.6.37.6-x86-2.9-02
> > - Intel x86 Atom (dual-core) CPU D510 @ 1.66GHz 
> > - Emb. dev board from Intel (ICH8M ctrlr, Ethernet h/w for e1000e)
> > - Xenomai configured w&w/o --enable-smp --enable-x86-tsc options
> > - gcc version 4.4.5
> > 
> > I've followed all of the recommendations for kernel configuration and 
have 
> > disabled CPU sleep features in the BIOS such as SpeedStep and 
C-States. 
> > Legacy USB has been disabled in the BIOS. Hyperthreading has also been 

> > disabled, although I don't think it matters.
> 
> Have you tried to enable the SMI workaround?
> 
> -- 
>                                                                 Gilles.
> 

Yes - SMI workaround was enabled when the overruns were observed.


# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
CONFIG_XENO_HW_SMI_WORKAROUND=y
CONFIG_XENO_HW_SMI_ALL=y

Aug 25 11:32:33 nxtgenhd kernel: [    2.492709] I-pipe: Domain Xenomai 
registered.
  :
Aug 25 11:32:33 nxtgenhd kernel: [   11.579015] Xenomai: SMI-enabled 
chipset found
Aug 25 11:32:33 nxtgenhd kernel: [   11.579044] Xenomai: SMI workaround 
enabled


--George


