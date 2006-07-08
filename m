Subject: Re: [Xenomai-core] [PATCH] add ipipe-domain mode to irqbench
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AECD18.4070809@domain.hid>
References: <44AECD18.4070809@domain.hid>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 10:49:42 +0200
Message-Id: <1152348582.5065.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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

On Fri, 2006-07-07 at 23:07 +0200, Jan Kiszka wrote:
> Another test mode for irqbench: this patch allows to run the irq loopback ahead of
> Xenomai in its own domain. Relies on latest ipipe patch which made non-heading irq
> handlers interruptible, requires CONFIG_XENO_OPT_PIPELINE_HEAD=n (but will simply fail
> on mode request if not).
> 
> I tried to pick up the rthal versions of all ipipe-related stuff, please remark
> potential misuse.

Merged, thanks.

-- 
Philippe.



