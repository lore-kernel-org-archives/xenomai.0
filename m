Message-ID: <2ff1a98a0708100246q6f136ce3u99ed8378d47726aa@domain.hid>
Date: Fri, 10 Aug 2007 11:46:31 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46BC1160.6040109@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46BC1160.6040109@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix doxygen complaints
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
Cc: xenomai-core <xenomai@xenomai.org>

> -/*!
> - * \fn int rthal_timer_request(void (*tick_handler) (void), void (*mode_emul)(int mode, void *tdev), int (*tick_emul)(unsigned long delay, void *tdev), int cpu)
> +/**
> + * \fn int rthal_timer_request(void (*tick_handler)(void),
> + *             void (*mode_emul)(enum clock_event_mode mode, struct ipipe_tick_device *tdev),
> + *             int (*tick_emul)(unsigned long delay, struct ipipe_tick_device *tdev), int cpu)

Doxygen does not like when the function arguments are not on one line.
At least some version that was used in the past.


-- 
                                               Gilles Chanteperdrix

