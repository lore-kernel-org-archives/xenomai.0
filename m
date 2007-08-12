Message-ID: <46BF49EB.5050705@domain.hid>
Date: Sun, 12 Aug 2007 19:56:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000a01c7dcf3$e6096ed0$c124a986@domain.hid>
In-Reply-To: <000a01c7dcf3$e6096ed0$c124a986@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1CD53BE349F28A39A6B096D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
 threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?windows-1252?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1CD53BE349F28A39A6B096D
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Torsten Kr=F6ger wrote:
>> One simple answer: if your distributed system relies on priority
> inversion
>> "solutions" and "real" synchronous message passing the way you
> describe,
>> it's a bad design!
>>
>> And don't expect your RTOS to solve that bad design by adding more and=

> more
>> "features", especially "priority inversion" features... Priority
> inversion
>> efficiency and determinism simply don't scale with increased
> distribution.
>> As soon as you want to use message passing in a distributed
> environment,
>> design your system such that it is _robust_ against priority
> inversions. if
>> it is not, your system will not survive future extensions, ports to
> newer
>> hardware etc.
>>
>> What you want to achieve (I think) with "real" synchronous message
> passing
>> is that the receiver handles a message as soon as the sender has sent
> it,
>> right? Well, if your specification involves _really_ this form of
> coupling
>> between sender and receiver, the _only_ good solution is to serialize
> them
>> both in the same thread... Taking this discussion a bit further, this
>> synchronous message passing issue is key to the longlasting discussion=

>> between micro-kerels and monolithic kernels: the former can be more
>> _robust_ in a distributed way but in practice don't achieve the
>> _efficiency_ of the monolithic kernel.
>=20
> I think we have different opinions on this :-)
>=20
> Thanks to Herman, Jan, Philippe, and Gilles for their recent answers. I=

> know that this posting is quite long, but I hope you can find time and
> interest to read it.
>=20
> I'm not suggesting to add more and more features, I just think that
> there might be the possibility of an important improvement in the
> Xenomai send/receive/reply-messaging principle. May be I'm wrong, I hav=
e
> never designed an operating system, I am no expert in this field but
> from the user's point of view I would like to try to explain it like
> this:
>=20
> It=92s the task of the scheduler that the task with the highest priorit=
y
> gets scheduled as soon as the task needs the CPU. If this is not
> possible, because one or more other tasks with lower priorities are
> working in critical sections, which are also supposed to be used by the=

> highest-priority task, the priority inheritance protocol rules [1]. But=

> when looking at synchronous message passing, we have a different
> situation. We don=92t have critical sections here. A receiver (server)
> works for a sender (client) from the reception of a message
> ('rt_task_receive') on until it calls 'rt_task_reply', i.e. the section=

> from 'rt_task_receive' to 'rt_task_reply' is not the same as a section
> protected by a mutex or a semaphore. Everything a receiver does within
> this section, is done on behalf of the client and should be done with
> the priority of the client except there are other higher-priority
> clients waiting for the receiver.
>=20
> In the following I would like to explain, (i) the way it is implemented=

> right now and (ii) the way I would expect synchronous message passing t=
o
> work. Again, I don't want to 'play' with priorities or to add more and
> more features, I would just like to make a (perhaps important)
> suggestion or to understand, why my opinion on this is wrong.=20
>=20
> Suppose T1, T2, T3, T4, and T5 are five tasks in ascending order of
> priority. T3 is 'receive' blocked ('rt_task_receive').
>=20
> ------------
> (i)
> "A receiving task only inherits the priority a sender, if its _current
> priority_ is lower than the one of the sender. This inheritance rules
> until 'rt_task_reply' has been called by the receiver."
>=20
> Example 1:
> If task T3 is 'receive' blocked, and T4 'sends' a message to T3, the
> priority of T4 will be assigned to T3 until T3 calls 'rt_task_reply'. I=
f
> T5 should also send a message to T3, while T3 is still between
> 'rt_task_receive' and 'rt_task_reply' (for the message from T4), the
> message of T5 will be queued and the priority of T3 will be raised to
> the one of T5. After T3 has called 'rt_task_reply' for the message of
> T4, it remains at the priority of T5, receives the message from T5,
> works on it, replies it, and then its priority is set back to its basic=

> one. We don't have priority inversion here.
>=20
> Example 2:
> Another situation would be that T1 sends a message to T3, which would
> then remain at its basic priority, even if T2 changes its state to read=
y
> while T3 is processing the message for T1. As result, T2 would not be
> scheduled, and we have priority inversion here. Exactly this priority
> inversion problem can be avoided.
>=20
> ------------
> (ii)
> "A receiving task inherits the highest priority of all tasks that have
> sent a message to it. This inheritance rules until 'rt_task_reply' has
> been called by the receiver."
>=20
> Example 1:
> Same behavior as above.
>=20
> Example 2:
> If T1 sends a message to T3, T3 inherits the priority of T1 until T3
> calls 'rt_task_reply'. If T2 gets ready while T3 works on the message
> from T1, T2 would be scheduled, and we don't have the priority inversio=
n
> problem anymore. If T2 would then get pre-empted by T5 for example, and=

> if T5 should also send a message to T3, T3's priority would raise to th=
e
> one of T5 of course - i.e. the same way as in (i) and the
> highest-priority task is always privileged.
> ------------
>=20
> I do understand that when we work with static priorities, the developer=

> is able to prevent this situation by assigned appropriate priorities to=

> all tasks. But therefore, he needs to know the entire system and the
> dependencies between _all_ tasks. In small systems, this is indeed
> possible, of course, but in large systems with many tasks, the
> probability of miss-configuring the system increases rapidly, and in
> very big systems real-time capability cannot be guaranteed when using
> synchronous message passing. This problem becomes even bigger, when
> looking at distributed systems, of course.

Well, relying on OS services to solve design issues of larger system is
/fairly/ risky. All this dynamic scheduling, prio-inheriting, etc.
doesn't come for free. So you can't simply rely on something like "hey,
it worked for 10 threads, now I'm adding 10 more, so it can be at worst
half as fast". You _do_ have to reconsider your whole (RT-)system unless
you want to live with increasing uncertainties (soft RT...). And if the
system is getting too large, use tools. OK, granted, Xenomai yet doesn't
provide such tools nor at least models to feed 3rd-party software. Yet
another nice area to work on. :)

>=20
> The only disadvantage I see is that we always have to perform a
> rescheduling in (ii), when a task receives a message sent from another
> task with another priority. In (i) we only perform a rescheduling when =
a
> higher-priority task sends a message to a receiver. As result the
> efficiency _slightly_ decreases when low priority tasks communicate wit=
h
> high-priority tasks via synchronous message passing, but=20
>=20
> - the system is still deterministic, and
> - we don't have priority inversions anymore(!)
>=20
> In the following I would kindly like to answer on some of the recent
> postings on this objective. Again, please don't hesitate to tell me,
> that I'm wrong.
>=20
>> Jan Kiszka wrote:
>> Note that we do _not_ play with the receiver priorities, we rather
>> prefer a stable _static_ system configuration. That's better for hard
>> RT, and prio-inheriting MPI generally doesn't help about worst-case
>> latencies anyway (given a non-broken static prio design).
>=20
> The worst-case latencies should be the same in both cases, (i) and (ii)=
=2E
> If a middle-priority task receives a message from a low-priority task
> and gets immediately after its message reception interrupted by a
> high-priority task, the receiver inherits the high priority, but first
> it has to work on the low-priority message. Hence, the maximum
> predictable delay is the execution time for the section between
> 'rt_task_receive' and 'rt_task_reply' of the receiver task while workin=
g
> for the low priority task. The result should be the same for (i) and
> (ii).

My point is that worst-case is not much different if the receiver gets
the required static priority right from the beginning. You just add the
management overhead in the dynamic case (which is noticeable if message
handling is short).


BTW, did you already asked yourself why your receiver has to handle
messages of different priority with the same thread? If there is
actually something important aside unimportant stuff to transmit from A
to B, you may as well let B provide two endpoints with two threads: one
to handle to important messages and the other the rest. Please don't
tell me too quickly, you need far too many classification levels for
this. Check it thoroughly first! Too many priorities are a good sign for
indeterministic and inefficient system design.

Note that this pattern can have a nice advantage: lower worst-case
latency. As you can now let the two threads of B synchronise on the
_real_ critical section, ie. where shared data is handled, and not where
whole messages get parsed etc., that section often gets shorter! (A
reason why microkernel-like server design doesn't scale that well.)

>=20
>> Herman Bruyninckx wrote:
>> One simple answer: if your distributed system relies on priority
> inversion
>> "solutions" and "real" synchronous message passing the way you
> describe,
>> it's a bad design!
>=20
> That's exactly, what I want to do - synchronous message passing in a
> distributed environment. When doing distributed communication, the
> scheduler should be involved at each communication partner. If a
> low-priority client on node A sends a message to a server task on node
> B, the scheduler of node B should know the priority of the client on
> node A, such that the message can be assigned correctly to the
> corresponding receiver queue, and that therewith the receiver can be
> scheduled correctly. I think, this is the same discussion as above: if
> the developer knows the entire system and assigns all priorities to
> _all_ tasks on _all_ nodes correctly, the system is real-time capable.
> But with an increasing number of nodes and tasks the risk of priority
> inversions increases immensely. And, what is more important for me: the=

> system is _inflexible_. When adding new tasks, you always have to care
> for a non-broken static priority design of the _entire_ system.
>=20
>> Herman Bruyninckx wrote:
>> And don't expect your RTOS to solve that bad design by adding more and=

> more
>> "features", especially "priority inversion" features... Priority
> inversion
>> efficiency and determinism simply don't scale with increased
> distribution.
>=20
> This ties in with the former paragraph. It should be the task of a
> distributed real-time system, that (a) the highest-priority task on a
> node gets scheduled (without priority inversion) and (b) that a message=

> of a task with a specified priority is handled with the same priority o=
n
> its remote node (the communication medium has to be real-time capable
> too - of course). If this is given, one can always calculate the
> worst-case execution time of the highest-priority thread. And if the
> behavior of the highest priority task is known, one can calculate the
> worst-case time for the task with the second-highest priority etc. As
> result, we obtain a deterministic system.
> =20
>> Herman Bruyninckx wrote:
>> As soon as you want to use message passing in a distributed
> environment,
>> design your system such that it is _robust_ against priority
> inversions. if
>> it is not, your system will not survive future extensions, ports to
> newer
>> hardware etc.
>=20
> I totally agree! That's my major reason for writing this posting :-)
>=20
>> Herman Bruyninckx wrote:
>> What you want to achieve (I think) with "real" synchronous message
> passing
>> is that the receiver handles a message as soon as the sender has sent
> it,
>> right? Well, if your specification involves _really_ this form of
> coupling
>> between sender and receiver, the _only_ good solution is to serialize
> them
>> both in the same thread...
>=20
> I hope, I could describe my idea of "real" synchronous message passing
> above. I want the receiver to work on the next message in the receive
> queue, while having the priority of the highest priority among all
> sender priorities. This can be right after the sending (but not
> necessarily). Serializing both in the same thread would be a quite
> inflexible design, I think. The real-time capable distribution of
> services would become almost impossible this way.
>=20
>> Herman Bruyninckx wrote:
>> Taking this discussion a bit further, this
>> synchronous message passing issue is key to the longlasting discussion=

>> between micro-kerels and monolithic kernels: the former can be more
>> _robust_ in a distributed way but in practice don't achieve the
>> _efficiency_ of the monolithic kernel.
>=20
> That's correct. But I think the way synchronous message passing works i=
s
> an issue of the kernel - in both cases, monolithic and micro. And the
> principles should be the same in both cases. But, of course, I don't
> want to start a discussion about this (quite philosophical) question of=

> operating system architectures here :-)=20
>=20
> ------------------
> Summary
>=20
> I suggested a slight change the inheritance of priorities during
> synchronous message passing operations that prevents from priority
> inversion problems during such communication operations.=20
>=20
> Besides an ongoing discussion, I hope that this subject will end like
> this:
>=20
> 1. The approach above is correct and leads to an improvement.
>=20
> or
>=20
> 2. I am wrong in my opinion.

Though I would personally avoid designing systems like you want to, I
would also refrain from calling your opinion wrong. There can be valid
scenarios for many patterns (e.g. if existing software dictates the
design :-/). So let's get back to the Xenomai aspect of this thread:

>=20
> Before I close, I would like to acknowledge the work of all Xenomai
> developers. I don't want to criticize, but to encourage further
> developments in this important open source field. And I am really
> grateful for this interesting discussion.

If you are seriously interested in prio-inheritance for the native
message passing API, the best you can do is to work actively on a patch
proposal. This would

 - demonstrate how unintrusive this addition could be (preferably, PI
   will be optional and use existing low-level services), while being
   so useful for certain scenarios

 - accelerate the testing cycle (_you_ have the scenario at hand)

 - raise the chances that Xenomai gains this feature soon (core
   developers are generally busy with many things)

Posting patches early will allow you gain concrete feedback on the
design. And we will not sit there and watch you pulling hairs while
you're stuck. But hacking some Xenomai skin is also no black magic,
given the well defined nucleus API. Give it a try!

Jan


--------------enigD1CD53BE349F28A39A6B096D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGv0nsniDOoMHTA+kRAnx7AJoD6PG3UBKbTrpKUXprg4qyt/fk3QCeK1rs
1SDz5zZAB3amEwRUoBVTbvY=
=ZZbO
-----END PGP SIGNATURE-----

--------------enigD1CD53BE349F28A39A6B096D--

