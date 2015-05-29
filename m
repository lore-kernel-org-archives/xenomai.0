From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Date: Fri, 29 May 2015 06:11:20 +0000
Message-ID: <C9F8415089354E4FB76F4548B3515AF48CD48DF5@edb1.wapice.localdomain>
References: <C9F8415089354E4FB76F4548B3515AF48CD382E9@edb0.wapice.localdomain>
 <C9F8415089354E4FB76F4548B3515AF48CD48B3E@edb1.wapice.localdomain>
 <55661E8E.1000300@xenomai.org>
In-Reply-To: <55661E8E.1000300@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [RFC] [PATCH] Backport for chained interrupt handling
 fix - Linux 3.1.10 PowerPC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: 27. toukokuuta 2015 22:44

> This might be the consequence of a domain mismatch. A related bug was
> fixed a few months ago, you should at least check the IRQ log syncer in
> the legacy pipeline code for this issue:
> http://git.xenomai.org/ipipe.git/commit/?h=3Dipipe-3.18&id=3D3a71c688d0e3=
3c2e1bbe3eee8cce898419043cac

I tried the patch you posted. We had several boards running last night and
no crashes or freezes so far. It seems that this fixed the crashes we had
after the backported latency fix patch was applied (the one I posted before=
).
It also makes sense according to the kernel oops like you said.

After all, it seems that the backported latency fix was OK but we only=20
saw this other bug after the latency fix was applied.=20

Many thanks!

For those interested, the backported version
(adeos-ipipe-3.1.10-powerpc-2.13-07.patch) of the patch "handle
domain downgrading in slow path of IRQ syncer" can be found below in
this mail.

BR,
Jouko Haapaluoma
Wapice Ltd


From: Jouko Haapaluoma
Date: Thu, 28 May 2015 12:40:20 +0300
Subject: [PATCH] Fix domain downgrading in IRQ syncer
---
 include/linux/ipipe.h |  2 ++
 kernel/ipipe/core.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index 253dcdf..45bd89d 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -69,9 +69,11 @@ static inline void ipipe_context_check_off(void) { }
 #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 #define IPIPE_WARN(c)		WARN_ON(c)
 #define IPIPE_WARN_ONCE(c)	WARN_ON_ONCE(c)
+#define IPIPE_BUG_ON(c)		BUG_ON(c)
 #else
 #define IPIPE_WARN(c)		do { (void)(c); } while (0)
 #define IPIPE_WARN_ONCE(c)	do { (void)(c); } while (0)
+#define IPIPE_BUG_ON(c)		do { (void)(c); } while (0)
 #endif
=20
 #ifdef CONFIG_IPIPE
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 327ebff..9c096c7 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1244,6 +1244,7 @@ void __ipipe_sync_stage(void)
 	struct ipipe_domain *ipd;
 	int irq;
=20
+respin:
 	ipd =3D __ipipe_current_domain;
 	p =3D ipipe_cpudom_ptr(ipd);
=20
@@ -1288,7 +1289,33 @@ void __ipipe_sync_stage(void)
 			local_irq_disable_hw();
 		}
=20
+		/*
+		 * We may have migrated to a different CPU (1) upon
+		 * return from the handler, or downgraded from the
+		 * head domain to the root one (2), the opposite way
+		 * is NOT allowed though.
+		 *
+		 * (1) reload the current per-cpu context pointer, so
+		 * that we further pull pending interrupts from the
+		 * proper per-cpu log.
+		 *
+		 * (2) check the stall bit to know whether we may
+		 * dispatch any interrupt pending for the root domain,
+		 * and respin the entire dispatch loop if
+		 * so. Otherwise, immediately return to the caller,
+		 * _without_ affecting the stall state for the root
+		 * domain, since we do not own it at this stage.  This
+		 * case is basically reflecting what may happen in
+		 * dispatch_irq_head() for the fast path.
+		 */
+
 		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
+		if (__ipipe_current_domain !=3D ipd) {
+			IPIPE_BUG_ON(ipd =3D=3D ipipe_root_domain);
+			if (test_bit(IPIPE_STALL_FLAG, &p->status))
+				return;
+			goto respin;
+		}
 	}
=20
 	if (ipd =3D=3D ipipe_root_domain)
--=20
1.8.4


