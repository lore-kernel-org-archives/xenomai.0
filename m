From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17473.3055.737663.656203@domain.hid>
Date: Sat, 15 Apr 2006 17:06:23 +0200
Subject: Re: [Xenomai-core] [PATCH] detect problematic kernel configs
In-Reply-To: <443E9A8D.2090300@domain.hid>
References: <443E9A8D.2090300@domain.hid>
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

Jan Kiszka wrote:
 > Hi,
 > 
 > this patch tries to reduce the traps newbies may tap by leaving (for us)
 > well-known problematic kernel switches on. And are there any futher I
 > forgot, e.g. on other archs?
 > 
 > Jan
 > Index: ksrc/arch/i386/Kconfig
 > ===================================================================
 > --- ksrc/arch/i386/Kconfig	(revision 924)
 > +++ ksrc/arch/i386/Kconfig	(working copy)
 > @@ -194,3 +194,19 @@ depends on XENO_OPT_NUCLEUS
 >  source "drivers/xenomai/Kconfig"
 >  
 >  endmenu
 > +
 > +if XENOMAI = y
 > +
 > +comment "WARNING: Potential latency killers detected!"
 > +        depends on PM || ACPI || CPU_FREQ
 > +
 > +comment "Power Management (PM)"
 > +        depends on PM
 > +
 > +comment "ACPI"
 > +        depends on ACPI

Only ACPI_PROCESSOR is a latency killer.

-- 


					    Gilles Chanteperdrix.

