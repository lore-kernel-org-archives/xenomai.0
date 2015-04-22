Message-ID: <55372E49.10106@siemens.com>
Date: Wed, 22 Apr 2015 07:14:49 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <20150313171211.GH1497@hermes.click-hack.org>	<CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>	<20150402191555.GK31175@hermes.click-hack.org>	<CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>	<20150402204139.GL31175@hermes.click-hack.org>	<CAPRPZsDr__xN4EX8hXn8Wn+j67ip+eAzEOB4so9crCuz8_E+sA@mail.gmail.com>	<55264097.2010203@siemens.com>	<5526430E.8030808@siemens.com>	<20150409124110.GY20752@hermes.click-hack.org>	<55267547.7080206@siemens.com>	<20150409125838.GA20752@hermes.click-hack.org>	<55267832.7010804@siemens.com>
 <CAPRPZsAjhPeDboNL7fdzwjm2cYVx-rVURbFzATgWi11o5f2Meg@mail.gmail.com>
In-Reply-To: <CAPRPZsAjhPeDboNL7fdzwjm2cYVx-rVURbFzATgWi11o5f2Meg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-04-21 23:14, Jeroen Van den Keybus wrote:
> Sorry to tell, but it happened again after 181 hours.
> 
> Of course, we can try to disable APEI (but not in BIOS AFAICT) but
> maybe it's better to find the root cause. I double checked that the
> patch is included in this kernel. The disassembly shows it's there
> allright. Hope you can make more out of it.

Yeah, too bad, I missed on turn of the code. This should work better:

diff --git a/lib/ioremap.c b/lib/ioremap.c
index f5331c0..1575d3e 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -88,9 +88,9 @@ int ioremap_page_range(unsigned long addr,
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	/* APEI may invoke this for temporarily remapping pages in NMI
+	/* APEI may invoke this for temporarily remapping pages in interrupt
 	 * context - nothing we can and need to propagate globally. */
-	if (!in_nmi()) {
+	if (!in_interrupt()) {
 		__ipipe_pin_range_globally(start, end);
 		flush_cache_vmap(start, end);
 	}

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

