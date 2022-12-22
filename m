Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DB5CBB
	for <xenomai@lists.linux.dev>; Thu, 22 Dec 2022 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671718273; bh=FyBAPoZHFpu9Qc05xVVXVPHZebrU1CGh6Oq+bbsIRuw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=CCXwCDEg/mfOo6E6f86un4GKbLnxXaVxuoUdlCB6gUvr3bQYUP+ZwukVUXWoeFGpt
	 i0Ea6ZX1u6H2QxMc7rfJc3hfyCF5XtwXn/KcQgVVHghcG60ufBcUQKOEZl5StJTNsf
	 /BwBhrdJU330ximr0XpqKoA6ZJD+ibWfVI5Nu76U2wWaBkT2G4ReL4JxO/5bC6j/+y
	 8W064lFSwPZJre0hE3rpx6XLrAxabF+y86yKc2YDuWOC+54k+QRdteUCc1qBHYmFwK
	 TzCSW00uFc9Izhszdo/posdAbakj8FoBqnDIOQK9sx1jxfoxSArGyBgAc92ohqqpzI
	 Zorph5uba/jFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.73.153.142]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Pda-1pA0z91hl8-003tFQ; Thu, 22
 Dec 2022 15:11:13 +0100
Message-ID: <ab51d02f-3403-7057-4403-f704ae278e74@web.de>
Date: Thu, 22 Dec 2022 15:11:12 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: "failed to allocate main tcb" error
Content-Language: en-US
To: "Mauro S." <mau.salvi@tin.it>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
 <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
 <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
 <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
 <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
 <7f782cbd-7353-7573-7768-e61a2c885c88@tin.it>
 <30fdc0c6-d807-c062-2e98-c63f3a9d55b7@web.de>
 <641ab944-2cda-0f4b-00bd-73bd553495bb@tin.it>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <641ab944-2cda-0f4b-00bd-73bd553495bb@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:drkjiiol/UJQD78oquVqwAezcFiyS/afP8lQqf/Rxh4oI/0BCfc
 sV1y14zOvEzWa9ha6b/xflR2gW+NVfLGyvJMIVid4ehHNNl1WAWgr4KrZxRtYeHoKCZCPbP
 L62UAr1tvCGzL6rwd2S4tnxR5KTm6DxfRWo/rjUDwU8rrQo4DtLk4jl4cL9c1iLr4iExRnF
 wgtY11cID/HcIOEurcb2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r/bDorLYrwk=;RCpxDhIVqcle6zPYwBf1Qf7pbAV
 JAxaubmcnUNJpeMAedBEOg11UTPXQFRsZdc7IRbAjwB7lJ95drNVOmnZSzOMc2/BYtmfScsXt
 KLmj2xZbL5PzjeC2rhACNSmkCdCgxfO/l2i1wTLOfGNRe8x+h4v7F6yUwDpa3n2caszVhPc4Q
 EB0QKk7EJSxg+Gw7UXXbbkvGVlVel941jstcySenHHWgpT138a+ywIiGuAqi1WnvfMgM8tltX
 d867twQWMNEaP3+phgUpH4menn3Ac6ayZxI2UFvdxZFXwzlxgrOIjupWR3XXHEGwEtoQsmm4g
 rxRi/1NJ0PIqviSa5GrDeQ1nuyoKSQQghLwG0Mxa/LZYFfVc2b3JnKwmmCnfQPt0U4uDVcGTx
 TdYsYo3XvGjOnbeu+Ah7VQRXu6wQfIOXiG54SfXPqNDyq32SSFpgtE5mZijbyDCDQ3BTUpMXs
 T72bEjjfMxJKLpBMDB54AMjAXN9NOX4dkhsVcB7en1xsmkcCUPZ/UpKtRx+H/jlTNpMEr7Mmu
 GXVcF2dTHTlHAF+5wXwl9CLWa8X4iX8PAEMu0MvNWjpBLn4KGCPt5iR4ytCMxhc+uqm2zYXCo
 iFBOULhnTzf4zu29FhYz0q93Q/KEDA6CzRxKVw0zRqOBI+2d9pMaX+zd3e30w8EBKP6F/EH3/
 Eh4mGKL55u7TYFwnAwykNsDqmbVKAddfQJOoD9LmGjB3ooyMFvqLrFSJwBCL6Tm/0hH85daDk
 /0ja9ol4wBERrviGqZWShofA+EKrxzVnjUCN76vnHcOTKYbn94xVoz0jDssOullpOGqG62Far
 kycUAOA4BKYfga7SObdKCHe37kziW98KE+oS/Hgh/JhvSnxNC6BIm16rW8Cl/ke4eUEFcINes
 1oELiJGqOMKZdOUKZ6AilXR+ILsNDL+eRyJgenlxWcAmFuLpEw+oEBbqmvTn+MBm4v7iH8E1h
 P5s+Vfb8UWV44jtbfdROGnq3asjMZsi3GUcS5+4BvRazfDc+6ypdMHU74HC0gcg7k1HDlA==

On 22.12.22 14:57, Mauro S. wrote:
> Il 21/12/22 17:04, Jan Kiszka ha scritto:
>> On 21.12.22 16:25, Mauro S. wrote:
>>> Il 21/12/22 16:11, Jan Kiszka ha scritto:
>>>> On 21.12.22 15:57, Mauro S. wrote:
>>>>> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>>>>>> On 21.12.22 15:45, Mauro S. wrote:
>>>>>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>>>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>>>>>> Copperplate and
>>>>>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>>>>>
>>>>>>>>> I have a main application, and another service application that
>>>>>>>>> connects
>>>>>>>>> to the main one using shared session.
>>>>>>>>>
>>>>>>>>> After some time the main application is running, the service
>>>>>>>>> application
>>>>>>>>> stops to connect to the main one with the error
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0"004.166| BUG in mai=
n_overlay(): [main] failed to
>>>>>>>>> allocate main
>>>>>>>>> tcb
>>>>>>>>>
>>>>>>>>> Digging a bit in the code, I found that the failing function is
>>>>>>>>> the
>>>>>>>>> xnmalloc() call in
>>>>>>>>> lib/copperplate/threadobj.c:__threadobj_alloc().
>>>>>>>>> If I understood correctly, this function tries to allocate some
>>>>>>>>> space
>>>>>>>>> from the shared heap. But the shared heap is almost free
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # cat /proc/xenomai/heap
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOTAL=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 FREE=C2=A0 NAME
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4194304=C2=A0=C2=A0 3616512=C2=A0=
 system heap
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1048576=C2=A0=C2=A0 1041776=C2=A0=
 shared heap
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1048576=C2=A0=C2=A0 1048480=C2=A0=
 private heap[14505]
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36864=C2=A0=C2=A0=C2=
=A0=C2=A0 19968=C2=A0 xddp-pool@0
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24576=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 7680=C2=A0 xddp-pool@10
>>>>>>>>>
>>>>>>>>
>>>>>>>> This is the code that triggers the message:
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (pthread_key_create(&threadobj_tskey,
>>>>>>>> finalize_thread))
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early_panic("failed to=
 allocate TSD key");
>>>>>>>>
>>>>>>>> pthread_key_create has nothing to do with xnmalloc. That's a plai=
n
>>>>>>>> glibc
>>>>>>>> service, and its documentation says:
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The =
pthread_key_create() function shall fail if:
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EAGA=
IN The system lacked the necessary resources to
>>>>>>>> create
>>>>>>>> another thread-specific data key, or the system-imposed limit on
>>>>>>>> the
>>>>>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been
>>>>>>>> exceeded.
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENOM=
EM Insufficient memory exists to create the key.
>>>>>>>>
>>>>>>>> Already checked THOSE conditions? Are you possibly creating threa=
ds
>>>>>>>> without cleaning them up completely?
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> thank you.
>>>>>>> Sorry but I can't figure out how the code you specified (that pani=
cs
>>>>>>> generating the message "failed to allocate TSD key") could
>>>>>>> trigger the
>>>>>>> "failed to allocate main tcb" message.
>>>>>>>
>>>>>>
>>>>>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplat=
e/threadobj.c#L86
>>>>>>
>>>>>> That's the only line in Xenomai which raises this message. If you
>>>>>> don't
>>>>>> believe it triggered it, start your application in gdb and put a
>>>>>> breakpoint on that panic line.
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>>> I believe thet this code triggers the message "failed to allocate TS=
D
>>>>> key".
>>>>>
>>>>> But I get the message "failed to allocate main tcb", that is in the
>>>>> same
>>>>> file, but at the line #1790.
>>>>>
>>>>
>>>> Ah, sorry, you are right. Didn't read careful enough.
>>>
>>> Ok, no problem :-)
>>>
>>>>
>>>> Could the heap be fragmented after lots and lots of
>>>> allocations/releases? But what is also a bit strange is that the main
>>>> thread is continuously mapped. Are you restarting the main applicatio=
n
>>>> for every request?
>>>>
>>>
>>> The main application is started once and keeps running, but internally
>>> creates and destroys many Xenomay tasks.
>>>
>>> During the main application lifetime (that can be long), the service
>>> application reads some statistics from the main application, prints
>>> these statistics and exits. Then, the main application is never
>>> restarted, and the service application is restarted for every request,
>>> that happens every 5 seconds (but the error seems not dependent on the
>>> service application restart period length).
>>
>> Ok, so the service applications are mapping its main thread against
>> Xenomai, and that as pshared apps using the shared heap.
>>
>
> Yes, exactly.
>
>>>
>>> On another device I have a similar (but not same) main application, an=
d
>>> the same service application, and this problem does not show.
>>>
>>> Then, the problem should be located in the main application, but I can=
't
>>> figure out where the problem could be.
>>
>> As the allocation happens against a shared, global heap, the issue may
>> be global as well. You could either try to trace the allocation/release
>> pattern against the shared heap and look for anomalies or even factor
>> out that pattern into a stand-alone reproducer.
>
> Thanks for your suggestions. Trace the allocation/release pattern would
> be a huge work for this application, then I started with a simple test:
> enlarge the heap sizes.
> Before I had a 4096kb system heap, 1024kb shared heap, 1024kb private he=
ap.
> Now I have a 8192kb system heap, 4096kb shared heap, 2048kb private heap=
.
> Nothing, the error happens again. Could this be a clue that this is not
> a fragmentation problem and could be a heap corruption problem?

Not impossible. The control structures should be heading the allocated
memory blocks, thus could get corrupted if some other user overwrites
its assigned block.

>
> During tests, I also noted that when the error starts to happen, no
> tasks in main applications are created/deleted. But there are some
> queues and pipes communications active, then the heap could be used by
> them.

All objects that could now be used across processes are allocated on the
shared heap if pshared is on. So we are not only looking at task objects
and their life cycles.

>
> I will continue investigating on this problem. If you have some other
> ideas/hints, I'll be glad to hear them.

Try reducing factors that could contribute to it, e.g. the types of
objects used. That may help narrowing down the actual trigger.

Jan

