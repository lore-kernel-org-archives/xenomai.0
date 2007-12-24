From: Paul <paul_c@domain.hid>
Date: Mon, 24 Dec 2007 13:54:43 +0000
References: <200712231747.35449.niklaus.giger@domain.hid>
In-Reply-To: <200712231747.35449.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jo7bH3iWbTVpRi6"
Message-Id: <200712241354.43936.paul_c@domain.hid>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_jo7bH3iWbTVpRi6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Niklaus

On Sunday 23 December 2007 16:47, Niklaus Giger wrote:
> > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c: In
> > function 'lbmStartIO':
> > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2165:
> > error: too many arguments to function 'lbmIODone'
<snip>
> > /var/buildbot/slave/ppc_f/linux-2.6-xenomai/drivers/net/via-rhine.c:44:1:
> > error: unterminated #ifndef make[3]: *** [drivers/net/via-rhine.o] Error

Attached patch resolves the two above errors - I too fell foul of them with an 
unpatched build (along with a couple in the USB code).

> > /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:341:
> > error: implicit declaration of function 'get_paca'

This one is from the Xenomai patch - get_paca is found in asm-powerpc/paca.h 
which is conditionally included when CONFIG_PPC64 is defined. I suspect line 
340 should read:

#if defined(CONFIG_IPIPE) && defined(CONFIG_PPC64)

It bit me at line 549 in arch/powerpc/kernel/smp.c...

Regards, Paul.



--Boundary-00=_jo7bH3iWbTVpRi6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="jfs_via-rhine_ppc-DENX.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="jfs_via-rhine_ppc-DENX.patch"

index 0041343..8f30c85 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -41,7 +41,6 @@
 static int debug = 1;	/* 1 normal messages, 0 quiet .. 7 verbose. */
 static int max_interrupt_work = 20;
 
-#ifndef PKT_ALIGN
 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
    Setting to > 1518 effectively disables this feature. */
 #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
index b1d1926..45dc960 100644
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -221,8 +221,8 @@ static const struct hc_driver ehci_au1xxx_hc_driver = {
 	.hub_status_data = ehci_hub_status_data,
 	.hub_control = ehci_hub_control,
 #ifdef	CONFIG_PM
-	.hub_suspend = ehci_hub_suspend,
-	.hub_resume = ehci_hub_resume,
+	.bus_suspend = ehci_bus_suspend,
+	.bus_resume = ehci_bus_resume,
 #endif
 };
 
index 463650e..c6f8599 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -73,8 +73,8 @@ static const struct hc_driver ehci_ppc_of_hc_driver = {
 	.hub_status_data = ehci_hub_status_data,
 	.hub_control = ehci_hub_control,
 #ifdef	CONFIG_PM
-	.hub_suspend = ehci_hub_suspend,
-	.hub_resume = ehci_hub_resume,
+	.bus_suspend = ehci_bus_suspend,
+	.bus_resume = ehci_bus_resume,
 #endif
 };
 
index 4f99b0e..1d40843 100644
--- a/drivers/usb/host/ehci-ppc-soc.c
+++ b/drivers/usb/host/ehci-ppc-soc.c
@@ -161,8 +161,8 @@ static const struct hc_driver ehci_ppc_soc_hc_driver = {
 	.hub_status_data = ehci_hub_status_data,
 	.hub_control = ehci_hub_control,
 #ifdef	CONFIG_PM
-	.hub_suspend = ehci_hub_suspend,
-	.hub_resume = ehci_hub_resume,
+	.bus_suspend = ehci_bus_suspend,
+	.bus_resume = ehci_bus_resume,
 #endif
 };
 
index 57c3b8a..59dbc5c 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2162,7 +2162,7 @@ static void lbmStartIO(struct lbuf * bp)
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
 		bio->bi_size = 0;
-		lbmIODone(bio, 0, 0);
+		lbmIODone(bio, 0);
 	} else {
 		submit_bio(WRITE_SYNC, bio);
 		INCREMENT(lmStat.submitted);

--Boundary-00=_jo7bH3iWbTVpRi6--

