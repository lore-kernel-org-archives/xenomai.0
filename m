Message-ID: <423E7517.3040304@domain.hid>
Date: Mon, 21 Mar 2005 09:17:43 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090207020302030803060100"
Subject: [Adeos-main] PATCH: adeos ppc r6c15 oops handling
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------090207020302030803060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Adeos prevents (most) oopses from other domains from printing. The 
attached patch should fix the behaviour.

-- Heikki Lindholm

--------------090207020302030803060100
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="adeos-ppc-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adeos-ppc-oops.patch"

--- arch/ppc/kernel/traps.c.orig	2005-03-21 09:16:15.783031455 +0200
+++ arch/ppc/kernel/traps.c	2005-03-21 09:16:22.182984961 +0200
@@ -78,6 +78,12 @@
 {
 	static int die_counter;
 	int nl = 0;
+
+#ifdef CONFIG_ADEOS_CORE
+	/* lets us see Oopses from other domains, too */
+	if (adp_current != adp_root)
+		adeos_set_printk_sync(adp_current);
+#endif /* CONFIG_ADEOS_CORE */
 	console_verbose();
 	spin_lock_irq(&die_lock);
 #ifdef CONFIG_PMAC_BACKLIGHT

--------------090207020302030803060100--

