From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1240479431.6990.30.camel@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 11:42:04 +0200
Message-Id: <1240479724.6990.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] adeos patch 2.6.28.9-x86-2.2-07 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2009-04-23 at 11:37 +0200, Philippe Gerum wrote:
> On Thu, 2009-04-23 at 11:20 +0200, vikesh rambaran wrote:
> > Hi
> > 
> > Thanx for the updated patch. Some feedback ...
> > 
> > I tested it with Xenomai 2.4.7 under Ubuntu 8.04.2  on three different
> > platforms 
> > (AMD Athlon Desktop, Intel Core 2 Desktop, Intel Core Duo Laptop)
> > 
> > Typical system lockups when in the gnome desktop do NOT occur
> > anymore ! Great :)
> > 
> > Initial observations when compared to Xenomai 2.4.5 with
> > adeos-ipipe-2.6.24-x86-2.0-07.patch.  :
> > 
> > 1. Latency test shows a slight increase of about 5 to 10 % on the
> > Intel platforms. 
> > (Still need to do the comparison on the AMD platform). This translates
> > to less than 5 uS 
> > so it's ok for our case.
> > 
> > 2. On the Intel Core 2 Desktop, our application has a much more
> > significant max scheduling jitter
> > of about 125 uS (compared with < 60uS for Xenomia 2.4.5). This
> > 'increased jitter' does not
> > show up on the other two platforms. Still trying to trace this one.
> 
> Time for an I-pipe tracer log, with latency -f. I guess this
> pathological jitter should trigger with standard tests as well; if it
> does not, well, there might be other regression spots in the APIs.

Actually, 2.4.5 -> 2.4.7 should only introduce maintenance fixes, so no
heavy changes that might trigger such blatant regression. Usual suspect
in that case is the I-pipe again, due to the 2.6.24 -> 2.6.29
transition, and less likely the Xenomai core.

In any case, 125 us is pathological.
 
> 
> .config would help as well. TIA,
> 

This still applies.

> >  Already played around with 
> > different ACPI and SMI settings, but no joy (:
> > 
> > 
> > Keep well
> > Vicki
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



