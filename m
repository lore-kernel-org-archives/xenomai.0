Subject: Re: AW: [Xenomai-help] delete queues "offline"; /proc/stat
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17580.64278.6862.15230@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
	<17580.62092.647925.100612@domain.hid>
	<44ACF432.7090200@domain.hid>
	<17580.64278.6862.15230@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:11:08 +0200
Message-Id: <1152187868.4978.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2006-07-06 at 13:59 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > > Yes, all resources specific to a process are deleted automatically, so,
>  > > any message queue descriptor or shared memory descriptor is
>  > > closed. Named objects are not deleted though, since they may be shared
>  > > between several processes, only non-pshared anonymous objects and named
>  > > objects *descriptors* are deleted. This is the only reasonable
>  > > implementation I could find.
>  > 
>  > What about a usage counter maintained on creation/binding vs.
>  > closing/destruction? I would prefer to get them cleaned up automatically
>  > as well somehow, or we really need tool support for IPC cleanup, and
>  > that is ugly in my eyes.
> 
> I am not sure one would expect a named object to be unlinked when one only
> calls its "close" service, without calling its "unlink" service. If, on
> the other hand, one calls the "unlink" service, then the object will be
> automatically destroyed when the last descriptor is closed, as mandated
> by the specification.

I agree with this interpretation. Think of some application "loader"
process that just creates the basic infrastructure, like shared mem
segs, then exits, leaving the actual use of such resources to some other
processes. I did see this a few times in customer designs.

> 
> Moreover, the existence of such objects is not a leak that will grow
> over time, if one do not use the O_EXCL flag when opening objects,
> existing objects will simply be reused. If one use the O_EXCL flag,
> opening will fail.
> 
> This behaviour is the same as Linux behaviour.
> 
-- 
Philippe.



