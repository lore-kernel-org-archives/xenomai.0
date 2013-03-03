Message-ID: <51331123.9070800@xenomai.org>
Date: Sun, 03 Mar 2013 10:00:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>	<5130E0C7.80709@siemens.com>
	<5130E6FE.2070905@siemens.com>	<1362185238.64750.YahooMailNeo@web171203.mail.ir2.yahoo.com>
	<5131B5A2.6000501@web.de> <5131DC27.80909@xenomai.org>
	<5131DE8D.4070701@web.de> <51320ACA.4070101@xenomai.org>
	<51320EDF.2090104@web.de> <51320F98.7010900@xenomai.org>
	<51330EB1.9030801@web.de>
In-Reply-To: <51330EB1.9030801@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/03/2013 09:49 AM, Jan Kiszka wrote:

> On 2013-03-02 15:41, Gilles Chanteperdrix wrote:
>> On 03/02/2013 03:38 PM, Jan Kiszka wrote:
>>
>>> On 2013-03-02 15:20, Gilles Chanteperdrix wrote:
>>>> On 03/02/2013 12:12 PM, Jan Kiszka wrote:
>>>>
>>>>> On 2013-03-02 12:01, Gilles Chanteperdrix wrote:
>>>>>> On 03/02/2013 09:17 AM, Jan Kiszka wrote:
>>>>>>
>>>>>>> On 2013-03-02 01:47, Gabriele Moabiti wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> ----- Messaggio originale -----
>>>>>>>>
>>>>>>>> Da: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>> On 2013-03-01 18:09, Jan Kiszka wrote:
>>>>>>>>> There is more broken, even in latest stable 3.5.7. See the patc=
hes at
>>>>>>>>> [1] for a tested version. Unfortunately, I cannot update my tre=
e for 3.8
>>>>>>>>> ATM as git services seem to be down on xenomai.org.
>>>>>>>>
>>>>>>>> Does this and other important patches will be backported to 3.2?=

>>>>>>>
>>>>>>> I'm planning to get them merged into 3.8 first of all, maybe also=
 into
>>>>>>> 3.5 (as this is our current production baseline). No plans exist =
beyond
>>>>>>> that. I'd rather like to leave older kernels alone to reduce main=
tenance
>>>>>>> efforts (porting is simple, proper testing takes time).
>>>>>>>
>>>>>>> Also note that 3.2 is lacking much more critical fixes than those=
 few
>>>>>>> around KVM. IOW: Don't use it for anything serious with x86.
>>>>>>
>>>>>>
>>>>>> Maybe reverting the mprotect/ipipe_pin_vma patches in the 3.2 bran=
ch, so
>>>>>> as to avoid the zero page corruption, but take some faults sometim=
es
>>>>>> would be a simple, feasible solution? 3.2 seems to have been chose=
n as a
>>>>>> long term stable branch.
>>>>>
>>>>> Again, the problem is not writing the patches
>>>>
>>>>
>>>> It is easy to forget a patch when (back)porting patches from an I-pi=
pe
>>>> to the other.
>>>>
>>>>> but testing all the stuff
>>>>> in all necessary combinations.
>>>>
>>>>
>>>> I can test 4 combinations at once: i686 UP, i686 SMP and x86_64 (UP =
or
>>>> SMP), this leaves only one combination to test.
>>>
>>> That's a small subset of the relevant variation. They come with enabl=
ing
>>> different config options or using certain features. Do you have a tes=
t
>>> setup for KVM on I-pipe e.g.? I'm not saying we catch them all with t=
he
>>> development head, but adding more versions to the test matrix doesn't=

>>> make it better.
>>
>>
>> I man 3, not 4 combinations. Anyway, I na=C3=AFvely test with only one=

>> .config, which recently switched from embedded like minimal kernel to
>> debian like config. Do you have a list of the options combinations whi=
ch
>> necessitate separate tests?
>=20
> I-pipe/Xenomai on/off,


That is 3 cases. But we can not really run xeno-regression-test with
Xenomai off. So, maybe a build-test for CONFIG_IPIPE alone and
CONFIG_IPIPE off would be enough?

> TSC/APIC on/off,


I do not think it really matters with TSC/APIC off. We have much worse
latencies with TSC off, due to the fact that we read the TSC often,
especially with stats enabled, and nobody complained (more exactly, some
people complained a long time ago, then discovered they had a tsc,
enabled it, then stopped complaining). The point is, if nobody noticed
it, it probably means that nobody uses it.

> instrumentations and tracers
> should be on for correctness checks, but not when comparing benchmark
> numbers.


It means we have to run xeno-regression-test with instrumentation on
Then xeno-test without instrumentation.

> I'm not sure about CONFIG_PREEMPT on/off.


I routinely use CONFIG_PREEMPT off on ARM, to achieve the best
latencies, but since it involves code in assembly, it has to be tested,
on each platform.

I also noticed that turning off CONFIG_HIGH_RES reduces latencies, and
it certainly involves different code paths in the I-pipe.

> Long-term, we will
> also have to test IPIPE_LEGACY on/off.

At this point we do not really care to test anything else than the
latest patch on -forge, or we do?

--=20
                                                                Gilles.


