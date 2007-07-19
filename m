Message-ID: <469FC65E.7070508@domain.hid>
Date: Thu, 19 Jul 2007 22:15:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>	
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>	
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>	
	<913919.1184311634860.JavaMail.ngmail@domain.hid>	
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>	
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>	
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>	
	<469F9CE2.9080603@domain.hid> <1184869450.28303.155.camel@domain.hid>
In-Reply-To: <1184869450.28303.155.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig59328CC09048548525204D5A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59328CC09048548525204D5A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-07-19 at 19:18 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2007-07-19 at 17:35 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Thu, 2007-07-19 at 14:40 +0200, Jan Kiszka wrote:
>>>>>> Philippe Gerum wrote:
>>>>>>>> And when looking at the holders of rpilock, I think one issue co=
uld be
>>>>>>>> that we hold that lock while calling into xnpod_renice_root [1],=
 ie.
>>>>>>>> doing a potential context switch. Was this checked to be save?
>>>>>>> xnpod_renice_root() does no reschedule immediately on purpose, we=
 would
>>>>>>> never have been able to run any SMP config more than a couple of =
seconds
>>>>>>> otherwise. (See the NOSWITCH bit).
>>>>>> OK, then it's not the cause.
>>>>>>
>>>>>>>> Furthermore, that code path reveals that we take nklock nested i=
nto
>>>>>>>> rpilock [2]. I haven't found a spot for the other way around (an=
d I hope
>>>>>>>> there is none)
>>>>>>> xnshadow_start().
>>>>>> Nope, that one is not holding nklock. But I found an offender...
>>>>> Gasp. xnshadow_renice() kills us too.
>>>> Looks like we are approaching mainline "qualities" here - but they h=
ave
>>>> at least lockdep (and still face nasty races regularly).
>>>>
>>> We only have a 2-level locking depth at most, thare barely qualifies =
for
>>> being compared to the situation with mainline. Most often, the more
>>> radical the solution, the less relevant it is: simple nesting on very=

>>> few levels is not bad, bugous nesting sequence is.
>>>
>>>> As long as you can't avoid nesting or the inner lock only protects
>>>> really, really trivial code (list manipulation etc.), I would say th=
ere
>>>> is one lock too much... Did I mention that I consider nesting to be
>>>> evil? :-> Besides correctness, there is also an increasing worst-cas=
e
>>>> behaviour issue with each additional nesting level.
>>>>
>>> In this case, we do not want the RPI manipulation to affect the
>>> worst-case of all other threads by holding the nklock. This is
>>> fundamentally a migration-related issue, which is a situation that mu=
st
>>> not impact all other contexts relying on the nklock. Given this, you
>>> need to protect the RPI list and prevent the scheduler data to be
>>> altered at the same time, there is no cheap trick to avoid this.
>>>
>>> We need to keep the rpilock, otherwise we would have significantly la=
rge
>>> latency penalties, especially when domain migration are frequent, and=

>>> yes, we do need RPI, otherwise the sequence for emulated RTOS service=
s
>>> would be plain wrong (e.g. task creation).
>> If rpilock is known to protect potentially costly code, you _must not_=

>> hold other locks while taking it. Otherwise, you do not win a dime by
>> using two locks, rather make things worse (overhead of taking two lock=
s
>> instead of just one).
>=20
> I guess that by now you already understood that holding such outer lock=

> is what should not be done, and what should be fixed, right? So let's
> focus on the real issue here: holding two locks is not the problem,
> holding them in the wrong sequence, is.

Holding two locks in the right order can still be wrong /wrt to latency
as I pointed out. If you can avoid holding both here, I would be much
happier immediately.

>=20
>>  That all relates to the worst case, of course, the
>> one thing we are worried about most.
>>
>> In that light, the nesting nklock->rpilock must go away, independently=

>> of the ordering bug. The other way around might be a different thing,
>> though I'm not sure if there is actually so much difference between th=
e
>> locks in the worst case.
>>
>> What is the actual _combined_ lock holding time in the longest
>> nklock/rpilock nesting path?
>=20
> It is short.
>=20
>>  Is that one really larger than any other
>> pre-existing nklock path?
>=20
> Yes. Look, could you please assume one second that I did not choose thi=
s
> implementation randomly? :o)

For sure not randomly, but I still don't understand the motivations
completely.

>=20
>>  Only in that case, it makes sense to think
>> about splitting, though you will still be left with precisely the same=

>> (rather a few cycles more) CPU-local latency. Is there really no chanc=
e
>> to split the lock paths?
>>
>=20
> The answer to your question is into the dynamics of migrating tasks
> between domains, and how this relates to the overall dynamics of the
> system. Migration needs priority tracking, priority tracking requires
> almost the same amount of work than updating the scheduler data. Since
> we can reduce the pressure on the nklock during migration which is a
> thread-local action additionally involving the root thread, it is _good=
_
> to do so. Even if this costs a few brain cycles more.

So we are trading off average performance against worst-case spinning
time here?

>=20
>>> Ok, the rpilock is local, the nesting level is bearable, let's focus =
on
>>> putting this thingy straight.
>> The whole RPI thing, though required for some scenarios, remains ugly
>> and error-prone (including worst-case latency issues).
>>  I can only
>> underline my recommendation to switch off complexity in Xenomai when o=
ne
>> doesn't need it - which often includes RPI.
>>  Sorry, Philippe, but I think
>> we have to be honest to the users here. RPI remains problematic, at
>> least /wrt your beloved latency.
>=20
> The best way to be honest to users is to depict things as they are:
>=20
> 1) RPI is there because we currently rely on a co-kernel technology, an=
d
> we have to make our best to fix the consequences of having two
> schedulers by at least coupling their priority scheme when applicable.
> Otherwise, you just _cannot_ emulate common RTOS behaviour properly.
> Additionally, albeit disabling RPI is perfectly fine and allows to run
> most applications the RTAI way, it is _utterly flawed_ at the logical
> level, if you intend to integrate the two kernels. I do understand that=

> you might not care about such integration, that you might even find it
> silly, and this is not even an issue for me. But the whole purpose of
> Xenomai has never ever been to reel off the "yet-another-co-kernel"
> mantra once again. I -very fundamentally- don't give a dime about
> co-kernels per se, what I want is a framework which exhibits real-time
> OS behaviours, with deep Linux integration, in order to build skins upo=
n
> it, and give users access to the regular programming model, and RPI doe=
s
> help here. Period.
>=20
> 2) RPI is not perfect, has been rewritten a couple of times already, an=
d
> has suffered a handful of severe bugs. Would you throw away any softwar=
e
> only on this basis? I guess not, otherwise you would not run Linux,
> especially not in SMP.

Linux code that broke (or still breaks) on concurrent execution on
multiple logical (PREEMPT[_RT]) or physical (SMP) CPUs underwent lots of
rewrites / disposals over the time because it is hard to get right and
efficient. For the same reasons, those features remained off whenever
the production scenario allowed it.

> 3) As time passes, RPI is stabilizing because it is now handled using
> the right core logic, albeit it involves tricky situations. Besides, th=
e
> RPI bug we have been talking about is nothing compared to the issue
> regarding the deletion path I'm currently fixing, which has much large
> implications, and is way more rotten. However, we are not going to
> prevent people from deleting threads instead in order to solve the bug,=

> are we?

No, we are redesigning the code to make it more robust. But we are also
avoiding certain code patterns in application that are know to be
problematic (e.g. asynchronous rt_task_delete...). Still, I wouldn't
compare thread deletion to RPI /wrt its necessity.

>=20
> Let's keep the issue on the plain technical ground:
> - is there a bug? You bet there is.
> - is the issue fixable? I think so.
> - is it worth investing some brain cycles to do so? Yes.
>=20
> I don't see any reason for getting nervous here.

Well, I wouldn't grumble if I complained for the first time, or maybe
also the second. In contrast to other more special features of Xenomai,
this one was first always on, then selectable due to my begging, and is
now still default y while known to be the root of multiple severe and
_very_ subtle issues over the last 3 years. And there is a noticeable
complexity increment to the worst-case paths even when RPI will be
finally correct.

Users widely don't know this (that's my guess), users generally don't
need it (I'm still _strongly_ convinced in this), but users stumble over
it. Ironically those - like Mathias - who are interested in hard
real-time, not integrated soft RT. That's, well, still improvable.

Domain migration is one, if not THE neuralgic point of any co-kernel
approach. It's where RTAI broke countless times (dunno know if it still
does, but they never audited code like we do), and it's where Xenomai
stumbled over and over again. I'm not arguing for the removal of RPI,
I'm only worried about those poor users who are not told what they are
running. Default-y features should have matured and provide a reasonable
gains/costs ratio. I was always sceptical about both points, and I'm
afraid I was right. Please prove me wrong, at least in the future.

Jan


--------------enig59328CC09048548525204D5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGn8ZeniDOoMHTA+kRAq+zAJ9OX3keGspJAknSEPM9YrxKBsJCnwCfQAM1
bmkra6QXkO2z8XpLONiuhEU=
=/SiK
-----END PGP SIGNATURE-----

--------------enig59328CC09048548525204D5A--

