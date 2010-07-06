Message-ID: <4C336373.6010805@domain.hid>
Date: Tue, 06 Jul 2010 19:10:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid>	
	<1276080083.18906.52.camel@domain.hid>	
	<4C234A15.2030708@domain.hid>	
	<1277654519.2305.7.camel@domain.hid>	
	<4C28AC49.3080209@domain.hid>	
	<1278431097.1939.7.camel@domain.hid>	
	<4C335199.7000401@domain.hid>
	<1278434466.1939.8.camel@domain.hid>
In-Reply-To: <1278434466.1939.8.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

Philippe Gerum wrote:
> On Tue, 2010-07-06 at 17:54 +0200, Jan Kiszka wrote:
>>>> CONFIG_XENO_OPT_WATCHDOG=y
>>>> CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=60
>>> 60s seems way too long to have a chance of recovering from a runaway
>>> loop to a reasonably sane state.
>> That's required for debugging the kernel.
>>
> 
> I don't understand this requirement. Any insight?

While you step though a Xenomai task context, timers continue to tick.
So the period spent in that context gets huge, and soon the task will be
shot by the watchdog. Likely a limitation of kvm (interrupts should be
blockable in singlestep mode). Haven't looked at all details yet, just
picked the lazy workaround.

Of course, we don't use this value on real HW.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

