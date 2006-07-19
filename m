Subject: Re: [Xenomai-core] uvm/vxworks and uvm/vrtx are still being built
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44BD77E6.6030004@domain.hid>
References: <44BD77E6.6030004@domain.hid>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 22:28:31 +0200
Message-Id: <1153340912.5032.30.camel@domain.hid>
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

On Wed, 2006-07-19 at 02:08 +0200, Jan Kiszka wrote:
> ...intentionally? I thought those two UVM components were obsoleted by
> the full user-space skin support.
> 

They are now obsolete, but a smooth transition requires to have both in
2.2, so that people having based some development over the UVM could get
a grace period before the UVM support is eventually removed. v2.2.1 will
mark it as deprecated in the configuration section.

> On the other hand, the rtai user-space back- and front-end look a bit
> "premature". Wouldn't it be better to feed this skin into the UVM build
> process meanwhile?

In fact, the UVM support is going to be removed from 2.3. The rationale
behind this is:

1- the UVM support was intended as being a work-around, so that skins
without direct syscall interface from user-space to the skin module
could still be usable in regular process context (i.e. and not only from
a kernel module). Now that the majority of the in-tree skins has been
given such interface, keeping the UVM support is indeed useless.
2- Because of #1, the UVM has some limitations, mainly due to design
issues. For instance, it's not possible to sanely and safely mix uses of
sandboxed skins running over a UVM with a regular skin, like the POSIX
or native ones. There are synchonization issues, which cannot be solved
without going for utterly overkill solutions. On the other hand, such
mix is perfectly fine with skins exhibiting a direct syscall interface
to their implementation module.
3- Now that the VxWorks skin has a direct call interface to the kernel
module, and provided that we are going to implement the pSOS and uITRON
counterparts, there is no sign on the mailing list that many people
would depend on the UVM anymore.
4- Maintaining the UVM - as a Xenomai pseudo-architecture - is a pure
PIA, with no reward, since it brings nothing more that normal user-space
callable skins, but actually much less, due to their sandboxed runtime
environment (e.g. one has hard time writing kernel space support to
extend a UVMed skin).

To sum up, the UVM support is hard to explain to potential users, adds a
fair amount of confusion when compared to using the direct syscall
interfaces from user-space, and can't evolve up to the point where I
could be happy with them.

PS: regarding the RTAI issue, most projects migrating from there to Xeno
are AFAIK, converting their applications to use the native skin
directly, or even the POSIX one. Fact is that RTAI is more than 300
calls, if you take into account all the interface variants. Given the
nature of what is actually a set of APIs, more than a single one, the
sandboxed environment the UVM brings does not fit the RTAI interfaces at
all. People really interested in having a 100% compatible RTAI skin over
Xenomai that accurately emulates LXRT should definitely implement the
direct syscall interface for it.

-- 
Philippe.



