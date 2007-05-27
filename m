From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46570185.3030406@domain.hid>
References: <4656E62F.3090603@domain.hid> <4656E887.7040406@domain.hid>
	<4656EABD.60601@domain.hid> <1180102373.20410.103.camel@domain.hid>
	<4656F037.4040704@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F547BA@is-hdq-exchange.marel.net>
	<46570185.3030406@domain.hid>
Content-Type: text/plain
Date: Sun, 27 May 2007 03:51:08 +0200
Message-Id: <1180230668.15146.65.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest
	termination	--	scalable sched?
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
Cc: Daniel Schnell <daniel.schnell@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2007-05-25 at 17:32 +0200, Jan Kiszka wrote:
> Daniel Schnell wrote:
> > Well, that may be related to the bug I am seeing when I am ending cyclictest with Ctrl-C, Recursive kernel Ooops and this is on plain 2.3.1
> > 
> 
> 2.3.1 is definitely affected by this bug as well, as it also gained the
> prio-coupling rework. But you have to have SCALABLE_SCHED enabled.
> 
> I got it. It is - as usual - a trivial one-liner:
> 

Actually, whatever we passed to the multi-level queue constructor was
lacking normalization wrt the priority scale currently used by the
client skin. I've sanitize this code for the most painful part, but we
need more than this for 2.4. Hey! nice, the bottom of my TODO list has
just reached the basement of my house...

> --- xenomai.orig/ksrc/nucleus/shadow.c
> +++ xenomai/ksrc/nucleus/shadow.c
> @@ -186,7 +186,7 @@ static inline void rpi_init(void)
>  
>  static inline void rpi_init_gk(struct __gatekeeper *gk)
>  {
> -	sched_initpq(&gk->rpislot.threadq, xnqueue_down, XNCORE_NR_PRIO);
> +	sched_initpq(&gk->rpislot.threadq, xnqueue_down, XNCORE_MAX_PRIO);
>  }
>  
>  static inline void rpi_none(xnthread_t *thread)
> 
> 
> Happy weekend, =8)
> 
> Jan
> 
> 
> PS: The maximum priority level has initialised to a wrong value, causing
> threads with prio 0 to be placed out of the queue array.
> 
-- 
Philippe.



