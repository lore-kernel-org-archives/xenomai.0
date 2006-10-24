From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx
Date: Tue, 24 Oct 2006 12:49:40 +0200
References: <E1Gapzw-0005RB-Ob@domain.hid>
In-Reply-To: <E1Gapzw-0005RB-Ob@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GcJqn-0000Eo-Lv@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, rpm@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Hi all,
>
> I'm currently working on porting I-pipe to the ARM S3C24xx. The patch is
> attached, it must be applied after the shipped
> adeos-ipipe-2.6.15-arm-1.5-01.patch. Unfortunately, there is still a severe
> bug somewhere. I built Xenomai as modules. When I try to modprobe
> xeno_native, the system hangs. No reaction at all, inlcuding serial console
> and network access. I guess that interrupts are not handled any more. From
> what I see if I spread some debug printk() into my code, the timer starts
> working under the control of the Xenomai domain and one or two calls to the
> Linux timer interrupt handler are made. But after that nothing happens any
> more.
>
> As I try to find the bug for some days now but wasn't successful maybe the
> experts have any hints where to continue searching. Or perhaps there is
> someone who can test it and confirm or disprove my observation? It would be
> great to support one more ARM model.

Small update with new infos: After Xenomai has (re)started the system timer 
the Linux timer interrupt handler ist called only once, but 
xnintr_clock_handler() is called several thousand times. So it seems that the 
timer interrupt handler of Linux is not properly called or Xenomai is 
starving Linux.

Sebastian

