Subject: Re: [Xenomai-core] Unresolved symbol xnheap_usable_size since
	r1846 (PPC/vxworks only)
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200611181809.16782.niklaus.giger@domain.hid>
References: <200611181809.16782.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 18:19:49 +0100
Message-Id: <1163870389.4990.48.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2006-11-18 at 18:09 +0100, Niklaus Giger wrote:
> Hi Philippe
> 
> Since your revision 1846 "Sanitize size-related heap macros" I cannot get link 
> anymore the Linux kernel for PPC405 and vxworks. Others targets link without 
> problems 
> 
> See
> http://ngiger.dyndns.org/buildbot/hcu3_vx_q/builds/11/step-mk_kernel/1
> which reports:
> LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o: In function `__heap_read_proc':
> kernel/xenomai/skins/vrtx/heap.c:38: undefined reference to 
> `xnheap_usable_size'
> make: *** [.tmp_vmlinux1] Fehler 1
> 

Fixed by #1858, thanks.

> Best regards
> 
-- 
Philippe.



