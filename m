Message-ID: <50F65508.9090605@xenomai.org>
Date: Wed, 16 Jan 2013 08:21:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJN_JFwe5Td7oCN0YS-07hys7-v2OEhZ=SUebUtm4Af=q9tmrw@mail.gmail.com>
In-Reply-To: <CAJN_JFwe5Td7oCN0YS-07hys7-v2OEhZ=SUebUtm4Af=q9tmrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Build error for kernel 3.5.3 with xenomai 2.6.2 (arch
 i686) : gpio-pch.ko undefined
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Smith <prs247au@gmail.com>
Cc: xenomai@xenomai.org

On 01/16/2013 04:02 AM, Paul Smith wrote:

> I'm building linux kernel 3.5.3 patched with xenomai 2.6.2 stable and the
> provided 3.5.3 i-pipe patch. The kernel build is bombing out with;
> 
> ERROR: "__fixup_irq_handler" [drivers/gpio/gpio-pch.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2


We are missing an EXPORT_SYMBOL_GPL(__fixup_irq_handler) in
kernel/irq/chip.c

-- 
                                                                Gilles.

