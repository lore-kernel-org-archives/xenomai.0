Message-ID: <479D93D5.2040207@domain.hid>
Date: Mon, 28 Jan 2008 09:35:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4788C279.1020607@domain.hid> <479A5D78.6040701@domain.hid>
	<479CA23F.7000601@domain.hid> <479D7D48.1050200@domain.hid>
In-Reply-To: <479D7D48.1050200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9DEE9C41EE20452D1380D15C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [BUG] evsync is not SMP-safe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DEE9C41EE20452D1380D15C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> Philippe,
>>>>
>>>> this
>>>>
>>>> int fastcall __ipipe_dispatch_event (unsigned event, void *data)
>>>> ...
>>>> 	ipipe_cpudom_var(next_domain, evsync) |=3D (1LL << event);
>>>> 	local_irq_restore_hw(flags);
>>>> 	propagate =3D !evhand(event, start_domain, data);
>>>> 	local_irq_save_hw(flags);
>>>> 	ipipe_cpudom_var(next_domain, evsync) &=3D ~(1LL << event);
>>>>
>>>> doesn't fly on SMP. While the invoked event handler is running, it m=
ay
>>>> happen that the caller gets migrated to another CPU. The result is a=
n
>>>> inconsistent evsync state that causes ipipe_catch_event to stall (te=
st
>>>> case: invoke Jerome's system() test a few times, them try to unload
>>>> Xenomai skins and nucleus).
>>>>
>>>> First idea (I've nothing implemented to far, would happily leave it =
to
>>>> someone else's hand): Track event handler entry/exit with an, say, 8=
 bit
>>>> per-cpu counter. On event deregistration, just summarize over the
>>>> per-cpu counters and wait for the sum to become 0. This has just the=

>>>> drawback that it may cause livelocks on large SMP boxes when trying =
to
>>>> wait for a busy event. I've no perfect idea so far.
>>> Second approach to solve this (currently) last known ipipe issue clea=
nly:
>>>
>>> As long as some task in the system has __ipipe_dispatch_event (and th=
us
>>> some of the registered event handlers) on its stack, it is not safe t=
o
>>> unregister some handler. For simplicity reasons, I don't think we sho=
uld
>>> make any difference which handlers are precisely busy. So, how to fin=
d
>>> out if there are such tasks?
>>>
>>> I checked the code and derived three classes of preconditions for the=

>>> invocation of __ipipe_dispatch_event:
>>>
>>>  1) ipipe_init_notify and ipipe_cleanup_notify -> no preconditions
>>>
>>>  2) ipipe_trap_notify -> some Linux task has PF_EVNOTIFY set or
>>>                          there are tasks with custom stacks present
>>>
>>>  3) all other invocations -> some Linux task has PF_EVNOTIFY set
>=20
> 4) ipipe_syscall_watched_p used in syscall pipelining -> PF_EVNOTIFY ||=

> non-regular syscall

Damn it.

>=20
>>> This means by walking the full Linux task list and checking that are =
no
>>> more PF_EVNOTIFY-tasks present, we can easily exclude 3). In fact, 2)=

>>> can also be excluded this way because we can reasonably demand that a=
ny
>>> I-pipe user fiddling with event handlers has killed all non-Linux tas=
ks
>>> beforehand.
>>> This leaves us with 1) which should be handled via classic
>>> RCU as Linux offers it. Viable? It would even shorten the fast path a=
 bit!
>>>
>>> Still no code, I would like to collect feedback on this new idea firs=
t.
>> OK, here is some code. Seems to work fine (now that I fixed the cleanu=
p
>> race in Xenomai as well - the issue happened to pop up right after
>> applying this patch :-/).
>>
>=20
> This patch changes the predicate from "a given registered handler shoul=
d
> no be currently running" to "no task in the system should be currently
> asking for any kind of I-pipe notification", which has not quite the
> same scope. For instance, we could no more deregister a handler only fo=
r
> a particular event leaving others installed. It becomes an "all or
> nothing" test, even if that still remains compatible with the way
> Xenomai works though.
>=20
> However, we have a real problem with the syscall event. This one has an=

> additional precondition to PF_EVNOTIFY which is unfortunately dynamic,
> i.e. syscall_nr >=3D NR_SYSCALL. This is used to relay non-regular
> syscalls to whoever it may concern in the pipeline, when PF_EVNOTIFY is=

> not set. Xenomai uses this property for its shadow binding syscall,
> which will eventually set PF_EVNOTIFY for the caller. IOW, an attempt t=
o
> bind to the skin from userland while the nucleus is deregistering the
> syscall handler would escape the RCU sync with the current patch.
>=20
> But holding a read-side RCU lock to postpone the quiescent RCU
> state won't fly, since the syscall handler may reschedule Linux-wise.
>=20
> Looking back at the actual issue, we only have a single case to handle
> for the current code to be correct: detect when a handler appears to
> linger indefinitely on a given CPU (albeit it does not really), due to =
a
> migration.
>=20
> This should be done in a way that does not require complex
> locking/tracking on the fast path since we are really dealing with a
> corner case here. The attached patch does this by allowing a grace
> period before assuming that the handler will never complete on the
> current CPU, looking for some quiescent state. The latter part is almos=
t
> overkill, since clearing the handler in the domain struct already avoid=
s
> livelocking and would prevent such a handler to be fired quite early
> anyway. The underlying assumption is that tasks which should be notifie=
d
> of system events will be killed before someone attempts to deregister
> the event handlers they rely on, so they should not be able to run/slee=
p
> more than the grace period on behalf of the notifier.
>=20
> Does this patch also fix the case you pointed out?

May solve my particular test case, but given sleeping event handlers,
its clear to me now that the whole bit-flag based locking scheme remains
fragile once you have >1 tasks on one CPU inside the same
to-be-unregistered handler. Then the first leaving task will release the
lock, shadowing the existence of further tasks inside the handler. We
would need SRCU-like locking here if if were available for our
environment...

Jan


--------------enig9DEE9C41EE20452D1380D15C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHnZPaniDOoMHTA+kRAvPZAJ97AH/FQvBaDKuHDNoQbtr11vlkVwCeINxX
QITHMXYGe+E36/OnE4cUW44=
=cZzJ
-----END PGP SIGNATURE-----

--------------enig9DEE9C41EE20452D1380D15C--

