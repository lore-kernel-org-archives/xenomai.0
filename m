Message-ID: <48D66DC4.8030706@domain.hid>
Date: Sun, 21 Sep 2008 17:52:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F48E4DA6A@trillian.at.omicron.at>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F48E4DA6A@trillian.at.omicron.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

Richard Cochran wrote:
> I posted this patch today on linux-arm-kernel, but I repeat it
> here because there does not seem to be too much interest on that
> list for the ARM FCSE.
> 
> I also tried to combine this patch with ipipe for kernel 2.6.20
> running on the Intel IXDP465, but after booting I soon get a BUG.
> 
> Anyhow, perhaps the ARM people might take a look at combining
> ipipe with FCSE...

Ok. Six monthes later, I finally gave a try to your patch on at91rm9200,
which supports FCSE as well.

When booting, I get random segmentation faults (either with or without
the I-pipe), assertion which fails in glibc, and such things.

I looked at the code, and have a few questions:
- in cpu_switch_mm, you comment out the cache flush but keep the TLB
flush, is the TLB flush really needed ?
- in pmd_populate (file include/asm-arm/pgalloc.h), you populate two
pmds, does not this look wrong ? I mean it looks like pmd_populate is
called with the two "kinds" (translated and untranslated) addresses,
which should not happen.
- in exit_mmap (file mm/mmap.c), we should arrange for flush_cache_mm to
flush the whole cache (I mean without consulting mm->cpu_vm_mask) to
avoid keeping stale entries pointing to pages which are going to be
returned to the system. I tried to change this, but I still get the
random failures.
- anyone still has the old FASS patch ? Perhaps by looking at it we
could find what is missing in your patch.


-- 
					    Gilles.

