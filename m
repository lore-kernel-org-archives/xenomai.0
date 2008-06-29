Message-ID: <4867AA72.8080108@domain.hid>
Date: Sun, 29 Jun 2008 17:29:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
	<18496.31292.674733.417262@domain.hid>
	<3380.62.39.72.60.1213367793.squirrel@domain.hid>
	<2ff1a98a0806130843u17a146c5g38daf88bcd5ab7f6@domain.hid>
	<3842.81.252.86.91.1213598456.squirrel@domain.hid>
	<2ff1a98a0806160233o1e37d876xc5210aa16ade0f70@domain.hid>
	<7379.62.39.72.60.1213803323.squirrel@domain.hid>
In-Reply-To: <7379.62.39.72.60.1213803323.squirrel@domain.hid>
Content-Type: multipart/mixed; boundary="------------030603050702040407020009"
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030603050702040407020009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fabien MAHOT wrote:
> Hello,
> 
> I would like to know if you find something about my problem? Do you have
> more clues with the "frame pointers" debug?

Hi Fabien,

I found something. Could you try the attached patch, to see if we are
spotting the right bug ?

TIA,

-- 


					    Gilles.


--------------030603050702040407020009
Content-Type: text/x-patch;
 name="xeno-fix-harden-bug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-fix-harden-bug.diff"

Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 4002)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1002,6 +1002,8 @@ static int gatekeeper_thread(void *data)
 	up(&gk->sync);		/* Sync with xnshadow_mount(). */
 
 	for (;;) {
+		unsigned long flags;
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		up(&gk->sync);	/* Make the request token available. */
 		schedule();
@@ -1018,6 +1020,7 @@ static int gatekeeper_thread(void *data)
 		   by a signal before we have been able to process the
 		   pending request, just ignore the latter. */
 
+		local_irq_save(flags);
 		if (xnthread_user_task(thread)->state == TASK_INTERRUPTIBLE) {
 			rpi_pop(thread);
 			xnlock_get_irqsave(&nklock, s);
@@ -1034,6 +1037,7 @@ static int gatekeeper_thread(void *data)
 			xnpod_schedule();
 			xnlock_put_irqrestore(&nklock, s);
 		}
+		local_irq_restore(flags);
 	}
 
 	return 0;


--------------030603050702040407020009--

