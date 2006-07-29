From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RQWxUIqjVx"
Content-Transfer-Encoding: 7bit
Message-ID: <17611.36969.814874.846387@domain.hid>
Date: Sat, 29 Jul 2006 18:44:25 +0200
Subject: Re: [Xenomai-core] [PATCH] detect conflict with INPUT_PCSPKR
In-Reply-To: <44CB2884.80801@domain.hid>
References: <44CB2884.80801@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


--RQWxUIqjVx
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > This is a simple patch to catch the very rare but fatal conflict between
 > Xenomai's TSC emulation and the PC speaker driver on 2.6/x86.
 > 
 > Jan
 > 
 > 
 > --- include/asm-i386/hal.h      (Revision 1390)
 > +++ include/asm-i386/hal.h      (Arbeitskopie)
 > @@ -169,6 +169,11 @@ static inline unsigned long long rthal_r
 >      return t;
 >  }
 >  #else  /* !CONFIG_X86_TSC */
 > +#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
 > +#error Please disable PC speaker driver (CONFIG_INPUT_PCSPKR).
 > +#error It conflicts with Xenomai's TSC emulation.
 > +#endif /* CONFIG_INPUT_PCSPKR */
 > +
 >  #define RTHAL_8254_COUNT2LATCH  0xfffe
 >  void rthal_setup_8254_tsc(void);
 >  rthal_time_t rthal_get_8254_tsc(void);

How about solving this in Kconfig ?


-- 


					    Gilles Chanteperdrix.

--RQWxUIqjVx
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-forbid-pcspkr-in-kconfig.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/Kconfig.frag
===================================================================
--- scripts/Kconfig.frag	(revision 1388)
+++ scripts/Kconfig.frag	(working copy)
@@ -2,6 +2,7 @@
 menu "Real-time sub-system"
 
 config XENOMAI
+	depends on CONFIG_X86_TSC || !X86 || !CONFIG_INPUT_PCSPKR
 	bool "Xenomai"
 	default y
         select IPIPE

--RQWxUIqjVx--

