Message-ID: <46BC1160.6040109@domain.hid>
Date: Fri, 10 Aug 2007 09:18:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig959838DA50709F7B8DB54015"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix doxygen complaints
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig959838DA50709F7B8DB54015
Content-Type: multipart/mixed;
 boundary="------------030109090702000007090107"

This is a multi-part message in MIME format.
--------------030109090702000007090107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


--------------030109090702000007090107
Content-Type: text/x-patch;
 name="doxy-fixes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="doxy-fixes.patch"

Index: xenomai/ksrc/skins/posix/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/skins/posix/clock.c	(Revision 2902)
+++ xenomai/ksrc/skins/posix/clock.c	(Arbeitskopie)
@@ -139,10 +139,10 @@ int clock_gettime(clockid_t clock_id, st
  *
  * This allow setting the CLOCK_REALTIME clock.
  *
- * @param clock_id, the id of the clock to be set, only CLOCK_REALTIME i=
s
+ * @param clock_id the id of the clock to be set, only CLOCK_REALTIME is=

  * supported.
  *
- * @param tp, the address of a struct timespec specifying the new date.
+ * @param tp the address of a struct timespec specifying the new date.
  *
  * @retval 0 on success;
  * @retval -1 with @a errno set if:
Index: xenomai/ksrc/arch/generic/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/generic/hal.c	(Revision 2902)
+++ xenomai/ksrc/arch/generic/hal.c	(Arbeitskopie)
@@ -173,7 +173,7 @@ int rthal_irq_request(unsigned irq,
=20
 /**
  * @fn int rthal_irq_release(unsigned irq)
- *                          =20
+ *
  * @brief Uninstall a real-time interrupt handler.
  *
  * Uninstalls an interrupt handler previously attached using the
@@ -208,7 +208,7 @@ int rthal_irq_release(unsigned irq)
=20
 /**
  * @fn int rthal_irq_host_request(unsigned irq,rthal_irq_host_handler_t =
handler,char *name,void *dev_id)
- *                          =20
+ *
  * @brief Install a shared Linux interrupt handler.
  *
  * Installs a shared interrupt handler in the Linux domain for the
@@ -244,7 +244,7 @@ int rthal_irq_release(unsigned irq)
=20
 /**
  * @fn int rthal_irq_host_release (unsigned irq,void *dev_id)
- *                          =20
+ *
  * @brief Uninstall a shared Linux interrupt handler.
  *
  * Uninstalls a shared interrupt handler from the Linux domain for the
@@ -274,7 +274,7 @@ int rthal_irq_release(unsigned irq)
=20
 /**
  * @fn int rthal_irq_host_pend (unsigned irq)
- *                          =20
+ *
  * @brief Propagate an IRQ event to Linux.
  *
  * Causes the given IRQ to be propagated down to the Adeos pipeline to
@@ -304,13 +304,13 @@ int rthal_irq_host_pend(unsigned irq)
=20
 /**
  * @fn int rthal_irq_affinity (unsigned irq,cpumask_t cpumask,cpumask_t =
*oldmask)
- *                          =20
+ *
  * @brief Set/Get processor affinity for external interrupt.
  *
  * On SMP systems, this service ensures that the given interrupt is
  * preferably dispatched to the specified set of processors. The
  * previous affinity mask is returned by this service.
- *=20
+ *
  * @param irq The interrupt source whose processor affinity is
  * affected by the operation. Only external interrupts can have their
  * affinity changed/queried, thus virtual interrupt numbers allocated
@@ -320,7 +320,7 @@ int rthal_irq_host_pend(unsigned irq)
  * representing the new affinity for this interrupt. A zero value
  * cause this service to return the current affinity mask without
  * changing it.
- *=20
+ *
  * @param oldmask If non-NULL, a pointer to a memory area which will
  * bve overwritten by the previous affinity mask used for this
  * interrupt source, or a zeroed mask if an error occurred.  This
@@ -365,7 +365,7 @@ int rthal_irq_affinity(unsigned irq, cpu
=20
 /**
  * @fn int rthal_trap_catch (rthal_trap_handler_t handler)
- *                          =20
+ *
  * @brief Installs a fault handler.
  *
  * The HAL attempts to invoke a fault handler whenever an uncontrolled
@@ -930,7 +930,7 @@ unsigned long long __rthal_generic_full_
=20
 /**
  * @fn int rthal_irq_enable(unsigned irq)
- *                          =20
+ *
  * @brief Enable an interrupt source.
  *
  * Enables an interrupt source at PIC level. Since Adeos masks and
@@ -961,7 +961,7 @@ unsigned long long __rthal_generic_full_
=20
 /**
  * @fn int rthal_irq_disable(unsigned irq)
- *                          =20
+ *
  * @brief Disable an interrupt source.
  *
  * Disables an interrupt source at PIC level. After this call has
@@ -986,8 +986,10 @@ unsigned long long __rthal_generic_full_
  * - Any domain context.
  */
=20
-/*!=20
- * \fn int rthal_timer_request(void (*tick_handler) (void), void (*mode_=
emul)(int mode, void *tdev), int (*tick_emul)(unsigned long delay, void *=
tdev), int cpu)
+/**
+ * \fn int rthal_timer_request(void (*tick_handler)(void),
+ *             void (*mode_emul)(enum clock_event_mode mode, struct ipip=
e_tick_device *tdev),
+ *             int (*tick_emul)(unsigned long delay, struct ipipe_tick_d=
evice *tdev), int cpu)
  * \brief Grab the hardware timer.
  *
  * rthal_timer_request() grabs and tunes the hardware timer in oneshot
@@ -1036,8 +1038,8 @@ unsigned long long __rthal_generic_full_
  * - Linux domain context.
  */
=20
-/*!=20
- * \fn void rthal_timer_release(void)
+/**
+ * \fn void rthal_timer_release(int cpu)
  * \brief Release the hardware timer.
  *
  * Releases the hardware timer, thus reverting the effect of a
@@ -1045,6 +1047,8 @@ unsigned long long __rthal_generic_full_
  * is shared with Linux, a periodic setup suitable for the Linux
  * kernel will be reset.
  *
+ * @param cpu The CPU number the timer was grabbed from.
+ *
  * Environments:
  *
  * This service can be called from:
Index: xenomai/doc/doxygen/Doxyfile-common.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/doc/doxygen/Doxyfile-common.in	(Revision 2902)
+++ xenomai/doc/doxygen/Doxyfile-common.in	(Arbeitskopie)
@@ -690,7 +690,8 @@ PREDEFINED             =3D DOXYGEN_CPP \
         CONFIG_XENO_OPT_POSIX_INTR \
         CONFIG_XENO_OPT_RTAI_FIFO \
         CONFIG_XENO_OPT_RTAI_SEM \
-        CONFIG_XENO_OPT_RTAI_SHM
+        CONFIG_XENO_OPT_RTAI_SHM \
+        CONFIG_GENERIC_CLOCKEVENTS
=20
 # If the MACRO_EXPANSION and EXPAND_ONLY_PREDEF tags are set to YES then=
=20
 # this tag can be used to specify a list of macro names that should be e=
xpanded.=20

--------------030109090702000007090107--

--------------enig959838DA50709F7B8DB54015
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGvBFlniDOoMHTA+kRAp4qAJ0YVn3L6KeVbktTs//dV2unh+SasgCeIDcu
lICs8TcA+kJeQ7/Q0lpbbfo=
=aeS8
-----END PGP SIGNATURE-----

--------------enig959838DA50709F7B8DB54015--

