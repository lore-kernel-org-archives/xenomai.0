Content-Type: text/plain; charset="utf-8"
Date: Fri, 09 Nov 2007 11:43:57 +0100
From: "Matthias Frauendorf" <MAHAVIRA@gmx.net>
In-Reply-To: <473335D0.1040502@domain.hid>
Message-ID: <20071109104357.244480@domain.hid>
MIME-Version: 1.0
References: <20071108155600.149430@domain.hid> <473335D0.1040502@domain.hid>
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help]
 =?utf-8?q?Error_during_make=2C_error=3A_=E2=80=98s?=
 =?utf-8?q?truct_tss=5Fstruct=E2=80=99_has_no_member_named_=E2=80=98io=5Fb?=
 =?utf-8?b?aXRtYXBfYmFzZeKAmQ==?=
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


-------- Original-Nachricht --------
> Datum: Thu, 08 Nov 2007 17:14:08 +0100
> Von: Jan Kiszka <jan.kiszka@domain.hid>
> An: MAHAVIRA@gmx.net
> CC: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Error during make, error: ‘struct tss_struct’ has no member named ‘io_bitmap_base’

> MAHAVIRA@gmx.net wrote:
> > Hello, 
> > 
> > i get an error during make of the new linux kernel with xenomai
> > support. i use
> > /usr/src/linux-2.6.23
> > /usr/src/adeos-ipipe-2.6.23-i386-1.10-11.patch
> > /usr/src/xenomai-2.3.4
> > 
> > i patched the kernel-source with ./prepare-kernel.sh and copy a config
> > file from my old kernel (2.6.22-14-generic) to .config, use make
> menuconfig
> > and sudo make. i receive this error:
> > 
> > CC      kernel/xenomai/arch/generic/hal.o
> > In file included from include/asm/xenomai/hal.h:40,
> >                  from kernel/xenomai/arch/generic/hal.c:42:
> > include/asm/xenomai/wrappers.h: In function ‘wrap_switch_iobitmap’:
> > include/asm/xenomai/wrappers.h:86: error: ‘struct tss_struct’ has no
> member named ‘io_bitmap_base’
> > include/asm/xenomai/wrappers.h:96: error: ‘struct tss_struct’ has no
> member named ‘io_bitmap_base’
> > make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> > make[3]: *** [kernel/xenomai/arch/generic] Error 2
> > make[2]: *** [kernel/xenomai/arch] Error 2
> > make[1]: *** [kernel/xenomai] Error 2
> > make: *** [kernel] Error 2
> > 
> > any help?
> 
> Use Xenomai 2.4-rc5. Regarding i386, Xenomai 2.3.x only supports kernels
> up to 2.6.20.x.
> 
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

