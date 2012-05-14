Message-ID: <4FB0CD9A.2090702@domain.hid>
Date: Mon, 14 May 2012 11:17:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FB0BA7C.6070704@domain.hid>
In-Reply-To: <4FB0BA7C.6070704@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_create and rt_task delete re-scheduling
	calling task
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/14/2012 09:55 AM, Roberto Bielli wrote:
> P.S.  the imx25 now it's perfect. Was only the reentrant interrupt.

By the way, now that Linux runs all interrupt handlers with hardware irq
disabled, this option is completely useless: it will prevent a low
priority irq to interrupt a low priority irq while the high priority
interrupt handler is running, but since that handler is already running
with hardware interrupts off, this does not add anything.

-- 
					    Gilles.

