Subject: Re: [Xenomai-core] [bug] broken PI-chain
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F00125.40103@domain.hid>
References: <44EF2BA6.9040601@domain.hid>  <1156530834.4338.42.camel@domain.hid>
	<1156550618.4338.74.camel@domain.hid>  <44F00125.40103@domain.hid>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 10:44:21 +0200
Message-Id: <1156581861.4730.14.camel@domain.hid>
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

On Sat, 2006-08-26 at 10:07 +0200, Jan Kiszka wrote:

[...]

> Patch works fine for me.
> 
> But I still wonder what the idea is to officially claim a resource (i.e.
> add yourself to the claim queue) only when you boost. That doesn't seem
> to be intuitive. Isn't a thread always claiming the resource,
> independent of its prio delta?

Well, in this context, "claimed" is supposed to mean "actively required"
so that the current owner is paying attention to the waiter(s) needing
the resource, by undergoing a priority boost. When there is no risk of
priority inversion, the waiter is more "passive", it just sleeps without
changing anything else than its own state. In the logic I've used, what
you refer to is the "pendq" any waiter is linked to, regardless of its
priority delta with the current owner.

-- 
Philippe.



