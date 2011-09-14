MIME-Version: 1.0
In-Reply-To: <CAPASGLp2NiLJNX3rSiN1GixXPKeyFqjJ950TVBnKZEc8qK2sag@domain.hid>
References: <CANKLDms-kVpt6hk7adH880tK5xJL2=D9Y=M25Cn-0hBDueuUfQ@mail.gmail.com>
	<4E70A876.3020009@domain.hid>
	<CAPASGLp2NiLJNX3rSiN1GixXPKeyFqjJ950TVBnKZEc8qK2sag@domain.hid>
Date: Wed, 14 Sep 2011 15:42:16 +0200
Message-ID: <CANKLDmuDyAR8-YDyj1MZtsohxG0WwHCSqm6Oj+8GKKBpVhL=Lg@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] multicore: reserving core(s) for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Sep 14, 2011 at 3:24 PM, Eric Noulard <eric.noulard@domain.hid> wrot=
e:
> 2011/9/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> On 09/14/2011 02:18 PM, Henri Roosen wrote:
>>> We'll start experiments running our Xenomai application on a
>>> multi-core CPU (x86/ARM). I'm sure there are some Xenomai users who
>>> already have experience with it.
>>>
>>> What I would like to do is to run the Xenomai realtime threads on one
>>> core of the multi-core CPU. And I would like to reserve this core only
>>> for the Xenomai realtime threads.
>>>
>>> I'm using the Native API, so I can pass the CPU affinity flags for the
>>> Xenomai threads during task creation/shadow. But how can I make sure
>>> other threads will not make use of the same processor? I cannot call
>>> taskset for every task that is spawned... right?
>>>
>>> Are there any idea's on how this configuration could be made easier?
>>> It would be nice if there was a kernel config option to reserve
>>> core(s) for Xenomai that Linux will not use.
>>>
>>> Any ideas and help are welcome!
>>
>> The kernel has an "isolcpus" option, which allows to specify which cpus
>> should not be used by Linux.
>>
>> See Documentation/kernel-parameters.txt in the linux kernel sources for
>> an explanation.
>
> Here is a direct link
> http://lxr.linux.no/#linux+v2.6.39/Documentation/kernel-parameters.txt#L1=
063
>
> Would cpuset work with Xenomai as well?
> http://lxr.linux.no/#linux+v2.6.39/Documentation/cgroups/cpusets.txt
>
> Just curious,I did not tried.
>
>
> --
> Erk
> Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
> http://www.april.org
>

Thanks everyone for the quick and clear answers!
Exactly what I was looking for.

Henri.

