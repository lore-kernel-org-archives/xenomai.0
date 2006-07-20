Subject: Re: [Xenomai-core] uvm/vxworks and uvm/vrtx are still being built
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44BEAD52.8040309@domain.hid>
References: <44BD77E6.6030004@domain.hid> <1153340912.5032.30.camel@domain.hid>
	<44BEAD52.8040309@domain.hid>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 08:47:02 +0200
Message-Id: <1153378022.5132.3.camel@domain.hid>
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

On Thu, 2006-07-20 at 00:08 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > ...
> > To sum up, the UVM support is hard to explain to potential users, adds a
> > fair amount of confusion when compared to using the direct syscall
> > interfaces from user-space, and can't evolve up to the point where I
> > could be happy with them.
> > 
> 
> Thanks for clarifying. I never looked that deep into the UVM (except
> when I broke something with an arch patch). I just wrote that mail while
> waiting on the user-space part for being built ;). The UVM lib is
> default=y, maybe something we should change soon as well.

True. It's going to be tagged as deprecated in 2.2.1, and switched off
by default.

> 
> > PS: regarding the RTAI issue, most projects migrating from there to Xeno
> > are AFAIK, converting their applications to use the native skin
> > directly, or even the POSIX one. Fact is that RTAI is more than 300
> > calls, if you take into account all the interface variants. Given the
> > nature of what is actually a set of APIs, more than a single one, the
> > sandboxed environment the UVM brings does not fit the RTAI interfaces at
> > all. People really interested in having a 100% compatible RTAI skin over
> > Xenomai that accurately emulates LXRT should definitely implement the
> > direct syscall interface for it.
> > 
> 
> AFAIK no one insisted yet on user-space support for the RTAI skin. So
> this seconds that porting actually takes place at the application level.
> I guess it would take a rather large RTAI app so that writing a really
> compatible skin becomes worth the effort.
> 

Same views here.

> Jan
> 
-- 
Philippe.



