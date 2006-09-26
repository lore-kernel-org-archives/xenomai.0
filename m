From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
Date: Tue, 26 Sep 2006 23:26:04 +0200
References: <J67G6W$AFC4CDFDA31A148D03B70B64BA5713E3@domain.hid>
	<200609262056.30673.niklaus.giger@domain.hid>
	<45198C45.6080904@domain.hid>
In-Reply-To: <45198C45.6080904@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262326.04533.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Am Dienstag, 26. September 2006 22:23 schrieb Wolfgang Grandegger:
> Niklaus Giger wrote:
> > Am Dienstag, 26. September 2006 18:28 schrieb Wolfgang Grandegger:
> >> Philippe Gerum wrote:
> >>> On Tue, 2006-09-26 at 16:56 +0200, gilles.chanteperdrix wrote:
> >>
> >> OK, but in general, soft-float emulation should be used on systems
> >> without FPU and this is even more important for real-time. This is a
> >> tool chain issue. Niklaus, what tool chain are you using?
> >
> > In my .config I have
> > MATH_EMULATION=y
>
> You seem to need that because your compiler generates code with hard FP
> instructions. You could check this with:
>
>   $ ppc-linux-objdump -d prog|egrep ":\s*[e-f]"
This does not return any match on my system.

But looking at the disassembly of the latency program I have code like:
100081bc <_restfpr_28_x>:
100081bc:       cb 8b ff e0     lfd     f28,-32(r11)
or
1000798c <__floatsidf>:
1000798c:       7c 08 02 a6     mflr    r0
10007990:       2f 83 00 00     cmpwi   cr7,r3,0
10007994:       94 21 ff c0     stwu    r1,-64(r1)
10007998:       90 01 00 44     stw     r0,68(r1)
1000799c:       54 60 0f fe     rlwinm  r0,r3,1,31,31
100079a0:       90 01 00 14     stw     r0,20(r1)
100079a4:       40 9e 00 24     bne-    cr7,100079c8 <__floatsidf+0x3c>

> > The toolchain is gcc-3.4.4-glibc-2.3.5/powerpc-405-linux-gnu built using
> > Dan Kegel crosstool (Version 0.42 if I remember exactly).
> >
> > Shall I switch to another one?
>
> The ELDK from DENX uses FP soft-emulation for 4xx (http://www.denx.de).
> Choose  v3.1.1 for Linux 2.4 and v4 for Linux 2.6.

I am breathing only PowerPC code on my Mac PowerBook (running Debian) and 
never managed to installed ELDK on it. (And even Detlev as a Debian developer 
couldn't recommend a simple way.) 

But I assume that I specifying GLIBC_EXTRA_CONFIG="--without-fp" in the 
powerpc-405.dat should be enough to make Dan Kegels crosstool emit Soft-FPU 
emulation.

I will try to run the tests at work where I have installed ELDK 4.0, but not 
yet a fully working environment. Therefore it may take some time to report a 
result back.

-- 
Niklaus Giger

