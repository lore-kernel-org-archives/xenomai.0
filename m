From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTim1wpPyNNUFWot0KRVZoQTz1fwxuyP259VrkHiU@mail.gmail.com>
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
	<4D1F4BA4.6090000@domain.hid>
	<AANLkTik-H5J-Wp=6Oc8ne_G+m=qzWyUTDTNdUiLjUJPt@domain.hid>
	<4D1FA645.1000101@domain.hid>
	<AANLkTim1wpPyNNUFWot0KRVZoQTz1fwxuyP259VrkHiU@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 03 Jan 2011 16:29:20 +0100
Message-ID: <1294068560.1837.72.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with Installation. Error message in
 xeno-test: "Xenomai: /dev/rtheap is missing".
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexandre Oliveira <alexandrenagy@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-01-03 at 13:20 -0200, Alexandre Oliveira wrote:
> In attachment:
> 
> .config file from my kernel 2.6.34.1
> and the complete dmesg file.
> 
> I already updated the BIOS version of the mother board... but the same
> problem occurs.
> The /proc/cpuinfo file still returns 0.000 of frequency.

Then you should send this report to the linux kernel folks.

> 
> ========
> root@domain.hid# ./run
> *
> *
> * Type ^C to stop this application.
> *
> *
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)
> 
> ============
> 
> ====
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 15
> model        : 4
> model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
> stepping    : 3
> cpu MHz        : 0.000
> cache size    : 2048 KB
> fdiv_bug    : no
> hlt_bug        : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 5
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
> bogomips    : 1495.04
> clflush size    : 64
> cache_alignment    : 128
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> 
> =======
> 
> Any other file?
> 
> Thanks again for helping. :)
> 
> Att.
> Alexandre.
> 
> 
> 
> 2011/1/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>         Alexandre Oliveira wrote:
>         > Hello,
>         >
>         > I'm not running linux from a vmware. I didn't see that point
>         of the topic...
>         >
>         >
>         > On Monday, I will be at the laboratory and I will send the
>         complete dmesg
>         > file for help.
>         
>         
>         Please also send us the full kernel configuration.
>         
>         --
>         
>          Gilles.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



