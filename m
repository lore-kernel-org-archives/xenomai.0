Content-Type: text/plain; charset="us-ascii"
Date: Fri, 13 Jul 2007 11:43:31 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <469746E9.6050503@domain.hid>
Message-ID: <20070713094331.281350@domain.hid>
MIME-Version: 1.0
References: <20070713092440.281340@domain.hid> <469746E9.6050503@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error compiling linux 2.6.22 or 2.6.22.1 with
 adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Karl Reichert wrote:
> > Hello,
> > 
> > tried the adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch, but it works neither
> with linux 2.6.20 nor 2.6.20.1
> > patch and prepare-kernel.sh worked, after make menuconfig I tried to
> compile with make and get the following (my gcc gives me german errors, so I
> tried to translate as good as possible):
> > [...]
> > In file included from include/asm/xenomai/hal.h:40,
> >>>from kernel/xenomai/arch/generic/hal.c:42:
> > include/asm/xenomai/wrappers.h: in function wrap_switch_iobitmap:
> > include/asm/xenomai/wrappers.h:86: error: struct tss_struct has no
> element named io_bitmap_base
> > include/asm/xenomai/wrappers.h:96: error: struct tss_struct has no
> element named io_bitmap_base
> > [...]
> > 
> > Any hints? My gcc is 4.1.2
> 
> Don't use 2.6.22 patches for 2.6.20! Pick ipipe-2.6.22-i386-1.8-05 for
> your test.
> 
> Jan
> 
I'm very sorry, my mistake: I used linux 2.6.22.1 and 2.6.22, _not_ 2.6.20, was just a typo.

But I tried with adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch. Where can I get ipipe-2.6.22-i386-1.8-05? It's not listed on the FTP! I can only find ipipe-2.6.20-i386-1.8-05 (which is for 2.6.20 kernels).
-- 
von Karl Reichert

"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

