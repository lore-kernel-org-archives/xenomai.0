Message-ID: <485F73E1.9070604@domain.hid>
Date: Mon, 23 Jun 2008 11:58:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b3ff56212c0949c864c7170fd01e8254@domain.hid>
In-Reply-To: <b3ff56212c0949c864c7170fd01e8254@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> Hi
> 
> I would like to know if there is a sheduler per CPUs or one scheduler for
> all CPUs ? I understand that there is one sheduler per skin for all CPUs,
> so it's only to be sure...

One global scheduler, per-CPU scheduling runqueues, per-skin timing obtained
through separate time bases, see /proc/xenomai/timebases. The reason why we have
time bases is documented:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__timebase.html

> 
> Well, my application has two working mode. One with a PCI hardware that
> send an interrupt to tickAnnounce the Scheduler ; one with no hardware and
> something that will simulate this hardware interrupt (something like a
> periodic xenomai real-time task that send this same interrupt). So I need
> to use an interrupt to tickAnnounce vxworks scheduler. I think that I have
> to disabe the periodic tick (but I don't know how), and I need an interrupt
> handler that send a tickAnnounce. It is during the execution that the
> presence of the PCI hardware is tested and whether a hardware interrupt or
> software interrupt is used. Can somebody explain me if it's possible, and
> in that case, how can I disable the automatic vxworks tick ?
>

modprobe xeno_vxworks tick_arg=0

> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

