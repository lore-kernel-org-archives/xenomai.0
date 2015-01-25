In-Reply-To: <54C4B411.3030307@xenomai.org>
References: <129277905.Ag2XebZWbK@soho> <1882941.jW5kVZFuDr@indiana>
 <20150123172739.GA12812@hermes.click-hack.org>
 <201501241756.28192.leo@alaxarxa.net> <54C4B411.3030307@xenomai.org>
MIME-Version: 1.0
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Sun, 25 Jan 2015 12:14:16 +0100
Message-ID: <2B26277C-0A61-4059-8776-994BFC297530@alaxarxa.net>
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

But I was thinking in performance aspects comparing a system with cobalt vs=
 a system with mercury=2E

On 25 de gener de 2015 10=2E14=2E57 CET, Philippe Gerum <rpm@xenomai=2Eorg=
> wrote:
>On 01/24/2015 06:56 PM, Leopold Palomo-Avellaneda wrote:
>> A Divendres, 23 de gener de 2015, Gilles Chanteperdrix va escriure:
>>> On Fri, Jan 23, 2015 at 05:50:07PM +0100, Leopold Palomo-Avellaneda
>wrote:
>>>> El Divendres, 23 de gener de 2015, a les 16:52:31, Gilles
>Chanteperdrix
>>>> va
>>>>
>>>> escriure:
>>>>> On Fri, Jan 23, 2015 at 01:09:41PM +0100, Leopold
>Palomo-Avellaneda=20
>> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> now that I have some kernel to boot, I would like to ask some
>aspects
>>>>>> of Xenomai-3 in order to package it=2E
>>>>>>
>>>>>> Reading the documentation, now the new libxenomai could use two
>kind
>>>>>> of kernels: the patched one (Cobalt) or the preempt_rt (Mercury)=2E
>>>>>
>>>>> a preempt_rt kernel is a patched kernel too=2E
>>>>
>>>> Writing the email I thought, both are patches, but I thought
>preempt_rt
>>>> was integrated in mainline=2E
>>>
>>> No it is not=2E
>>>
>>>>>> 1) Is it possible to have _only_ one library (binary) that uses
>one
>>>>>> or another kernel in function which is running?
>>>>>
>>>>> No, you could want to run a kernel with both patches=2E So basing
>the
>>>>> decision on which patch you are running does not make sense=2E
>>>>
>>>> I don't want to run a kernel with both patches=2E It has no sense=2E
>But I
>>>> could have binary packages that could work with both kernels=2E That
>was
>>>> my idea=2E
>>>
>>> To the contrary, it has a lot of sense=2E You get one grade of
>>> real-time for cobalt task, and another grade of real-time for tasks
>>> scheduled by Linux=2E
>>=20
>> Maybe =2E=2E=2E it could be interesting as an experiment=2E
>
>No, it's not just an experiment=2E I'm aware of production setups which
>have been running this configuration since 2009=2E I did the mixed
>ipipe+prempt-rt port for them=2E
>
>>=20
>> Just for curiosity, have you had the test comparing in mercury and
>cobalt in=20
>> the same harware with the same problem?
>>=20
>
>Yes, without any issue=2E Just use two different install roots, one for
>cobalt, the other for mercury=2E
>
>--=20
>Philippe=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
