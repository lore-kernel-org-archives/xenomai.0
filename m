Message-ID: <4720F828.1030200@domain.hid>
Date: Thu, 25 Oct 2007 16:10:16 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090903040000090905090002"
Subject: [Xenomai-core] Proposed arch/powerpc/sysdev/uic.c patch
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

This is a multi-part message in MIME format.
--------------090903040000090905090002
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I applied the uic patch:

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index eeb38e2..5a38086 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -48,7 +48,7 @@ struct uic {
 	int index;
 	int dcrbase;

-	spinlock_t lock;
+	ipipe_spinlock_t lock;

 	/* The remapper for this UIC */
 	struct irq_host	*irqhost;

However, this would not compile because of a type mismatch.  I have added the attached patch, and it now compiles and runs.  But I'm not sure if this is the right way to fix it.  Comments?

	Steve



--------------090903040000090905090002
Content-Type: text/x-patch;
 name="new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new.patch"

--- /home/sfalco/uic.c	2007-10-25 15:59:35.000000000 -0400
+++ arch/powerpc/sysdev/uic.c	2007-10-25 16:06:16.000000000 -0400
@@ -231,7 +231,7 @@
 		return NULL; /* FIXME: panic? */
 
 	memset(uic, 0, sizeof(*uic));
-	spin_lock_init(&uic->lock);
+	uic->lock = IPIPE_SPIN_LOCK_UNLOCKED;
 	uic->of_node = of_node_get(node);
 	indexp = of_get_property(node, "cell-index", &len);
 	if (!indexp || (len != sizeof(u32))) {

--------------090903040000090905090002--

