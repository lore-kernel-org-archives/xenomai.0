From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 14 Sep 2008 20:11:14 +0200
References: <200809141519.01180.niklaus.giger@domain.hid>
	<48CD4F89.4050601@domain.hid>
In-Reply-To: <48CD4F89.4050601@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809142011.14848.niklaus.giger@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Deviation in Xenomai-Solo from vxWorks behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Am Sonntag 14 September 2008 19.53:13 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
> >
> > The attached program works fine under vxWorks 6.6 (powerpc).
> > Running it under the current xenomai-solo (trunk) on my GNU/Debian
> > x86 system it gets stuck at line 82:
> >
> > Here is the output from vxWorks
> >
> >> timex tSysMain
> >> assert passed at tSysMain line 66
> >> assert passed at tSysMain line 67
> >> assert passed at tSysMain line 70
> >> assert passed at tSysMain line 71
> >> assert passed at tSysMain line 74
> >> assert passed at tSysMain line 75
> >> assert passed at tSysMain line 77
> >> assert passed at tSysMain line 78
> >> assert passed at tSysMain line 79
> >> assert passed at tSysMain line 80
> >> assert passed at tSysMain line 82
> >> assert passed at tSysMain line 83
> >> tSysMain done
> >> timex: time of execution = 600 +/- 2 (0%) millisecs
> >
> > whereas my gdb reports the following
>
> Forget about gdb: it is known to affect the threading order. Does the wrong
> behaviour also happen when running the program without GDB?
>
Yes. Same behaviour without GDB. I only used gdb because it failed.

Best regards
-- 
NIklaus Giger



