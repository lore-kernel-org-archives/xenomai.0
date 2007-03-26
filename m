Message-ID: <4607E038.8070505@domain.hid>
Date: Mon, 26 Mar 2007 17:01:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Spinlock question.
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


Hi,

I am porting a network driver from Linux to RTnet, and I have a sudden
doubt about what I am doing: is it safe to call a function like
wake_up_interruptible, from a non real-time context, with CONFIG_PREEMPT
enabled, while holding an rthal spinlock ? Do not I risk a rescheduling
with the spinlock locked ?

-- 
                                                 Gilles Chanteperdrix

