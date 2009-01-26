Message-ID: <497D5538.7070704@domain.hid>
Date: Mon, 26 Jan 2009 07:16:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8e2adebc0901251942q75a08473m6121fcd2d296f598@domain.hid>
In-Reply-To: <8e2adebc0901251942q75a08473m6121fcd2d296f598@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] NULL ptr dereference: porting
	I-pipe to ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mandar Thite <mandarthite@domain.hid>
Cc: xenomai@xenomai.org, adeos-main@gna.org

Mandar Thite wrote:
> Hello everyone,
> 
> I am trying to boot Linux kernel ver. 2.6.26 patched with ADEOS ipipe
> (...)
> [<c005ac5c>] (tick_nohz_stop_sched_tick+0x0/0x3a4) from [<c0023318>]
> (cpu_idle+0x38/0x60)

Do not use nohz with 2.6.26. It is broken on ARM.

-- 
					    Gilles.

