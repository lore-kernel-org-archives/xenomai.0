Message-ID: <b647ffbd0707030713x7eec10d2j5355e6257445f970@domain.hid>
Date: Tue, 3 Jul 2007 16:13:43 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4688E373.5020205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4687F466.2020901@domain.hid>
	<b647ffbd0707020435oc733ee2m2facf281ee0c5cbb@domain.hid>
	<4688E373.5020205@domain.hid>
Subject: Re: [Xenomai-core] [PATCH-STACK] Missing bits for -rc1
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
Cc: xenomai@xenomai.org

On 02/07/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Dmitry Adamushko wrote:
> > On 01/07/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Hi all,
> >>
> >> I've just uploaded my rebased patch stack, including specifically the
> >> last bits that should go in before -rc1,

a few comments:

(1) in xnintr_irq_handler()

+	xnlock_get(&xnirqs[irq].lock);
+
+#ifdef CONFIG_SMP
+	/* In SMP case, we have to reload the cookie under the per-IRQ lock
+	   to avoid racing with xnintr_detach. */
+	intr = rthal_irq_cookie(&rthal_domain, irq);
+	if (unlikely(!intr)) {
+		s = 0;
+		goto unlock_and_exit;
+	}
+#else
+	intr = cookie;
+#endif

I think, it would be better to check 'intr' for NULL at this point so
to cover 'cookie == NULL' (who knows.. and it's better not to rely on
the lower layer here), I guess.


(2) use cases of xnintr_sync_stat_references() in xnintr_irq_detach()

+
+	xnlock_get(&xnirqs[irq].lock);
+
+	err = xnarch_release_irq(intr->irq);
+	xnintr_sync_stat_references(intr);
+	xnlock_put(&xnirqs[irq].lock);

Why do you call xnintr_sync_stat_references() inside the locked section here?
Does xnintr_sync_stat_references() really need to be protected by
'intr->lock' (it's been already detached) ?


>
> Jan
>

-- 
Best regards,
Dmitry Adamushko

