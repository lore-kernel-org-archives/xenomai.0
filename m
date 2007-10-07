From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1191775890.22917.16.camel@domain.hid>
References: <4708FAC4.1010306@domain.hid> <1191772542.22917.9.camel@domain.hid>
	<47090C01.4000506@domain.hid>  <1191775890.22917.16.camel@domain.hid>
Content-Type: text/plain
Date: Sun, 07 Oct 2007 19:41:41 +0200
Message-Id: <1191778901.22917.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fix __ipipe_pin_range_globally
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
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Sun, 2007-10-07 at 18:51 +0200, Philippe Gerum wrote:
> On Sun, 2007-10-07 at 18:40 +0200, Jan Kiszka wrote:
> > > 
> > > I still have a problem with UP here, but this one is due to a
> Xenomai
> > > bug -- host timer is no more forwarded when the nucleus timer
> starts.
> > > Does disabling NOHZ & HIRES get things working on your setup?
> > > 
> > 
> > Yes, I have HIRES on, and I guess that's the point: My current
> > impression is that there are some bits in Xenomai missing to migrate
> > running hires timers from Linux's lapic clockevent device over
> xntimers. 
> > The effect here is that CPU0 continues (probably due to higher timer
> > load) while CPU1 stops scheduling timers:
> > 
> > CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
> > 0    2729        2727        31168      -          NULL
> [host-timer/0]
> > 0    11          10          305103844  1000000000  xnpod_watch
> [watchdog]
> > 1    11          10          309365472  1000000000  xnpod_watch
> [watchdog]
> > 
> 
> The issue I see would be different it seems. I can reproduce the
> problem
> in UP + PIT mode, LAPIC off.

Ok, there is very likely a basic flaw in the logic for sharing the
oneshot mode between the clock event manager and Xenomai, when it comes
to relaying the host tick from the latter; something like a silly catch
22 issue. I'll send more on this later, but this probably impacts all
setups, LAPIC enabled or not. More on this later, I need to sort out a
few things more.
 
-- 
Philippe.



