From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1012210952150.8962@domain.hid>
References: <alpine.DEB.1.10.1012210952150.8962@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Dec 2010 10:24:46 +0100
Message-ID: <1292923486.2007.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 2.5.3++ on Blackfin: Irritating warning
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: Xenomai GNA <xenomai@xenomai.org>

On Tue, 2010-12-21 at 10:03 +0100, Kolja Waschk wrote:
> Hi,
> 
> I'm in the process of upgrading my Blackfin uclinux dist base from 2009R1.1 to 2010R1. This also includes a kernel and Xenomai upgrade.
> 
> The kernel is now 2.6.34 with I-pipe 1.14.02. With Xenomai 2.5.3, my application told me "Xenomai: User-space support anterior to 2.5.2 detected" on startup. I looked into newer Xenomai and found that there might have been related code changes, so I tried 2.5.5.2 (and also upgraded to I-pipe 1.15-01, but that doesn't seem to make a difference).
> 
> Now with 2.5.5.2, the warning when starting the application is gone, but I still get one when killing the application using SIGINT for the first time. The attached small example allows me to reliably reproduce the problem (please inform me if attachment didn't get through, it's only 30 lines).
> 
> When starting it after system reboot and then killing it with Ctrl-C after a few seconds, the warning is printed:
> 
> / # /tmp/try
> press ctrl-c to stop
> press ctrl-c to stop
> press ctrl-c to stop
> ^CXenomai: User-space support anterior to 2.5.2 detected, may corrupt memory upon
> thread termination. Upgrade is recommended
> / #
> 
> The warning doesn't appear when starting and killing "try" a the second time.

Mmf, commit 90b3e7cf6 does not do what it says it does. It should read:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 5ac182b..449a9a4 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2214,7 +2214,7 @@ static void handle_shadow_exit(void)
 	 */
 	if (thread->u_mode && !warned) {
 		warned = 1;
-#ifndef CONFIG_MMU
+#ifdef CONFIG_MMU
 		printk(KERN_WARNING
 		       "Xenomai: User-space support anterior to 2.5.2"
 		       " detected, may corrupt memory upon\n"
> 
> I also experience some other problems with debugging, console output duplication and (probably) memory fragmentation, maybe they're related but I have not been able to reproduce them with a small example yet.
> 
> Thanks in advance for any hints in advance!
> Kolja
> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



