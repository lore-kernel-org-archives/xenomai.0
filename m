MIME-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset="us-ascii"
From: Kurijn Buys <Kurijn.Buys@open.ac.uk>
In-Reply-To: <52A5E155.2040303@xenomai.org>
Date: Wed, 11 Dec 2013 14:23:38 +0000
Content-Transfer-Encoding: quoted-printable
Message-ID: <4453D563-1D0B-4C5E-BCF1-3E2E8068B514@open.ac.uk>
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
 <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
 <529DDB58.3090709@xenomai.org>
 <5B55252A-19D2-4A0D-82BE-FC77BFA6AEE1@open.ac.uk>
 <529DFEC3.1050106@xenomai.org>
 <90F2A7A6-5B5E-4A25-8D9D-3D50D0EC0826@open.ac.uk>
 <529E2801.5060505@xenomai.org> <529EEB7C.4090308@xenomai.org>
 <529EED06.4010108@xenomai.org> <529EF58A.8030003@xenomai.org>
 <529EF680.1040108@xenomai.org> <529EF89E.6000302@xenomai.org>
 <529EFB3D.6090900@xenomai.org> <529F03FC.8040409@xenomai.org>
 <529F04DD.2070201@xenomai.org> <529F0C48.20705@xenomai.org>
 <529F0DBC.9080905@xenomai.org> <529F13A1.5070403@xenomai.org>
 <529F1913.4030604@xenomai.org> <529F1974.60900@xenomai.org>
 <529F2BED.2030403@xenomai.org> <529F5254.8060501@xenomai.org>
 <529F69AD.6060003@xenomai.org>
 <CE87D5F4-FE47-4310-A74F-7F8E4CCEC92B@open.ac.uk>
 <52A05ED2.9050003@xenomai.org>
 <E8F821A2-2BD0-440D-BDA1-3751BD443662@open.ac.uk>
 <52A5E155.2040303@xenomai.org>
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org


Op 9-dec.-2013, om 15:27 heeft Gilles Chanteperdrix het volgende geschreven=
:

> On 12/09/2013 04:19 PM, Kurijn Buys wrote:
>> Op 5-dec.-2013, om 11:09 heeft Gilles Chanteperdrix het volgende geschre=
ven:
>>
>>> On 12/05/2013 01:44 AM, Kurijn Buys wrote:
>>>>
>>>> Op 4-dec.-2013, om 17:43 heeft Philippe Gerum het volgende geschreven:
>>>>
>>>>> On 12/04/2013 05:03 PM, Gilles Chanteperdrix wrote:
>>>>>> On 12/04/2013 02:19 PM, Philippe Gerum wrote:
>>>>>>> On 12/04/2013 01:00 PM, Gilles Chanteperdrix wrote:
>>>>>>>> Ok, could you push the branch somewhere so that I can try it?
>>>>>>>>
>>>>>>>
>>>>>>> testing/ipipe-3.8-i915-fix
>>>>>>
>>>>>> I could test it, I no longer get high latencies while moving a large
>>>>>> opengl window. So, it looks good.
>>>>
>>>> I've it running as well (with the priority coupling option disabled th=
is time).
>>>
>>> The options I asked you to change were meant to eliminate any possible
>>> source for high latencies in case of bug. You can return to a normal
>>> configuration now: re-enable SMP or APIC if you prefer to remain in
>>> single processor mode, disable the I-pipe tracer if you want to avoid
>>> the overhead, and re-enable priority coupling if you prefer to use it.
>>
>> Re-enabling SMP is fine, but doesn't necessarily seem to improve the lat=
ency.
>> While I'm still having some small pikes, they keep below 60us, so that i=
s fine to me.
>
> If your processor has hyper-threading, you may have much better results
> indeed in single processor mode, but enabling APIC and IO/APIC to avoid
> the spikes you got when using the legacy PIC.

I enabled APIC, and the latency peaks at 16us only now, and even less with =
load.
This also had an effect on my analogy problem, but not completely... I will=
 start a new thread for that...

Thanks a lot already for resolving this issue!
]{urijn

-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302).

