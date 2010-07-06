From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C335199.7000401@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<4C234A15.2030708@domain.hid>
	<1277654519.2305.7.camel@domain.hid>
	<4C28AC49.3080209@domain.hid>
	<1278431097.1939.7.camel@domain.hid>
	<4C335199.7000401@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Jul 2010 18:41:06 +0200
Message-ID: <1278434466.1939.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mayday support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

On Tue, 2010-07-06 at 17:54 +0200, Jan Kiszka wrote:
> >> CONFIG_XENO_OPT_WATCHDOG=y
> >> CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=60
> > 
> > 60s seems way too long to have a chance of recovering from a runaway
> > loop to a reasonably sane state.
> 
> That's required for debugging the kernel.
> 

I don't understand this requirement. Any insight?

> > Do you still see the issue with shorter
> > timeouts?
> 
> Yes, I usually lower the timeout before triggering the issue.
> 
> OK, I will try to find some time to look closer at this.
> 
> Jan
> 

-- 
Philippe.



