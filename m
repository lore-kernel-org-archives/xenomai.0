Message-ID: <48B32E0C.7000105@domain.hid>
Date: Tue, 26 Aug 2008 00:11:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48B313B5.9050308@domain.hid>
In-Reply-To: <48B313B5.9050308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnregistry_fetch & friends
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> trying to select a sane kernel-side looking scheme for fast native
> mutexes, I had a closer look at the registry usage in that skin (and
> many others). The typical pattern is
> 
> object = xnregistry_fetch(handle);
> perform_operation(object);
> 
> There is no lock around those two, both services do nklock acquisition
> only internally. So this is a bit racy against concurrent object
> destruction and memory releasing /

Nope.

 object reconstruction.

Yes, and no.

 Well, I guess
> the rational is: we test against object magics and the underlying memory
> is normally not vanishing (immediately) on destruction, right? 

We don't even care of that. The magic is intentionally garbled under nklock when
the object is freed, so it won't match.

Remains
> just object reconstruction. Not a real-life issue?
> 

Not for userland code calling syscall wrappers that fetch objects addresses from
handles, since we can't lock around code in the application to always make sure
that kernel space will certainly operate on the intended object, I mean, without
explicit care taken at user-space level. What helps, is that the registry does
not recycle handle values immediately, which is not 100% reliable if the slot
table is almost full, but still better than a LIFO option.

safe:

If paranoid or have a valid case for more safety, call xnregistry_remove_safe()
when deleting the object, along with xnregistry_get/put() to maintain safe
references on it.

> But then I wonder
> 
>  a) why xnregistry_fetch uses nklock at all (even for totally uncritical
>     XNOBJECT_SELF!)
> 

registry_validate() returns a pointer we want to dereference; we'd better keep
this unpreemptable, although it's useless for the self-fetching op (which is an
unused calling mode so far). If using xnregistry_remove() while fetching the
object, the worst case is that your action ends up acting upon an object of the
same type, instead of the initially intended one. If that's a problem, goto safe;

>  b) what the ideas/plans on unused xnregistry_put/get are.
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

