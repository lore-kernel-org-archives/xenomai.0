Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of
	periodic timers
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D19F3D.9060700@domain.hid>
References: <44D19F3D.9060700@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 19:01:39 +0200
Message-Id: <1154624499.5010.102.camel@domain.hid>
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

On Thu, 2006-08-03 at 09:01 +0200, Jan Kiszka wrote:
> A simple patch, just like suggested by Gilles, to avoid looping over
> periodic xntimer handlers in case of overruns.
> 
> It saves the current TSC on loop entry and uses this value later when
> forwarding the timer. Is is the overhead of re-reading the TSC on all
> archs negligible and should we rather go that way?
> 

The configuration for which reading the TSC is fairly expensive is x86
+TSC emulation, since this incurs reading and writing a couple of
8254-related i/o ports. This is not an issue for other
archs/x86-configs.

> Jan
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



