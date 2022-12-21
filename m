Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFC2573
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671638656; bh=gTS0d2sUy3Y6XqnEjY00Vv6I24vf/0Yj9bE9YDLXiYA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=byj6bbaC1dyyzwPPxbCuFS5y/URlvYtct1RNS/z4kofEcMUsQG63vFqD3GtVP/nYj
	 SnWddR35ucIyukdoID+y25MH7kf0t8jeTlFmpklnpCDUHh6J7kiiKDTJKnF+BNkMrx
	 g/igjtvfAzYa/5CpxLmcZUePyAyRery4vrbVkp7K91Bq0fELDA6MbYLINIwx3dCaTa
	 rIrIHOtp4gpGqtUCv3+dyiCxpI1/RS+lCi+qa+iTgNrprwUIa8v49NA0OlYwwe/yJg
	 4CRxriRLUQ44LXBRmV4UN3mp0BamcrfW5AfZSxR5mk3qB9+O+pVy3Owh7K6hEnrhQC
	 beI/yt/muLtCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.73.153.142]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1oaKSJ1BtL-00c4jY; Wed, 21
 Dec 2022 17:04:16 +0100
Message-ID: <30fdc0c6-d807-c062-2e98-c63f3a9d55b7@web.de>
Date: Wed, 21 Dec 2022 17:04:15 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
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
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <7f782cbd-7353-7573-7768-e61a2c885c88@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjaJgfs45yzO9qXBvKgVRaPI6N3MGAWXmN6IBTnstl4NxOOWYb0
 8lTyzdyA+2Vq3WueQrk7IpJGPUm7GPt0SuIKhBcbjIFD5bsLMu5fgdAG6+a8v9UOR74Dr2E
 ldWFXslGE/HohfaS0l/jCWGawC90pL5hZjiDJqbv6Xo7GTZ3xUcMrldwsca08RmSY1SYnYs
 d3sSH+gYaEos19Nb946YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iJY/0yD21Sg=;pH+oilrdpPKMhSQF5aI3PyhVQzJ
 8J5s81jKYupCGAZKBmbjI3319aLJL/MeZc94Q/gTjoSU7F3esLOIGPnRTq4RvXbHhy5hz7gtN
 DdsOfVZTur4X9DKQ3AXjhtUMPCu9IL5LW3jIAJ0nYure3tXBQHUGLjpmJo9uynKrp53HvZNvh
 JxySd33PMvn0nwDnRu/r99JPm8kClVOR4RdbSdHr2ZtKtqmgmMXd5gpWSgrccYT2ik7NOjkxc
 H6RmqKBrWnmT7y6k885/01wqSMULvjTxPT3rUrEbscMD7P0hb3U262cEQ/0Vm2IQRhxH5hof7
 +3gqPjasCx54OddiJW2+sQ/x6cKz40WvX9/8yyHv4lzvogLDqUPmdvHPEcekTcWAXiYN9ozLd
 6ciCnn8SDSjIaSyLdbdYv4QG2M80QmU2Gv8qSuvfFa/aW60PGk7dLjMkHh6Yp8Q+JUCY56GIi
 B9QIIygTwZ684H3MYUgkBfNnVKzHyyEr2lNpbD7yOwDHwtp9owXeA3lMZpbkCUxYXSsZe3EB7
 ZfdYbl0By/Fv6Cs7FFu1BJjE7tUDGTMpeFTI/IiQSALrk1PEeV73j18ZpvONNGnB218EQkDZa
 p8BY+wrOC/+VfRsqOKUvsAbe1OUgA5fzAQVq7wbxh3NE4a2yd/gZocIVL0jsdO+d+74gv+U2w
 Yj0Csb08Pzn6LDtD/fJ1+/422/4/bs2hZOx5xpvAUnB54X90fbeNzjQXDgBy4/FvafwN9OiRE
 AlQ1NXzEFbU/a7o/2nMkmdLe7EbkEO2fruzGmeHZc4mmHZUlzSeQgSOny8Q8qeXqS8X8iA2Ty
 eTUBgcpypMwqNLg2DqPQN+VngowmbfvVZM5ZaPJnqyxXw9xBC1AsHUhRqQnDFEOLllZDaWBxg
 BGmwPOzBgRkelcLGcHAZ+KnvsNRYPZc3Zs9HTrY8Km5h2OopIP+4kOXhs8LSO0a44NnEsoCjY
 jjC3jAouvU099/6x9Fdq0APiFnP4Kps++VOjtDCqV0n1BFpkJOGmVMnocc9vgUfDgZZ4tA==

On 21.12.22 16:25, Mauro S. wrote:
> Il 21/12/22 16:11, Jan Kiszka ha scritto:
>> On 21.12.22 15:57, Mauro S. wrote:
>>> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>>>> On 21.12.22 15:45, Mauro S. wrote:
>>>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>>>> Copperplate and
>>>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>>>
>>>>>>> I have a main application, and another service application that
>>>>>>> connects
>>>>>>> to the main one using shared session.
>>>>>>>
>>>>>>> After some time the main application is running, the service
>>>>>>> application
>>>>>>> stops to connect to the main one with the error
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0"004.166| BUG in main_overla=
y(): [main] failed to
>>>>>>> allocate main
>>>>>>> tcb
>>>>>>>
>>>>>>> Digging a bit in the code, I found that the failing function is th=
e
>>>>>>> xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc()=
.
>>>>>>> If I understood correctly, this function tries to allocate some
>>>>>>> space
>>>>>>> from the shared heap. But the shared heap is almost free
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 # cat /proc/xenomai/heap
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 FREE=C2=A0 NAME
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 4194304=C2=A0=C2=A0 3616512=C2=A0 system =
heap
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 1048576=C2=A0=C2=A0 1041776=C2=A0 shared =
heap
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 1048576=C2=A0=C2=A0 1048480=C2=A0 private=
 heap[14505]
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36864=C2=A0=C2=A0=C2=A0=C2=A0=
 19968=C2=A0 xddp-pool@0
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24576=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 7680=C2=A0 xddp-pool@10
>>>>>>>
>>>>>>
>>>>>> This is the code that triggers the message:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pt=
hread_key_create(&threadobj_tskey, finalize_thread))
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early_panic("failed to allocate=
 TSD key");
>>>>>>
>>>>>> pthread_key_create has nothing to do with xnmalloc. That's a plain
>>>>>> glibc
>>>>>> service, and its documentation says:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The pthread_=
key_create() function shall fail if:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EAGAIN The s=
ystem lacked the necessary resources to create
>>>>>> another thread-specific data key, or the system-imposed limit on th=
e
>>>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been
>>>>>> exceeded.
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENOMEM Insuf=
ficient memory exists to create the key.
>>>>>>
>>>>>> Already checked THOSE conditions? Are you possibly creating threads
>>>>>> without cleaning them up completely?
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> thank you.
>>>>> Sorry but I can't figure out how the code you specified (that panics
>>>>> generating the message "failed to allocate TSD key") could trigger t=
he
>>>>> "failed to allocate main tcb" message.
>>>>>
>>>>
>>>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/=
threadobj.c#L86
>>>>
>>>> That's the only line in Xenomai which raises this message. If you don=
't
>>>> believe it triggered it, start your application in gdb and put a
>>>> breakpoint on that panic line.
>>>>
>>>> Jan
>>>>
>>>
>>> I believe thet this code triggers the message "failed to allocate TSD
>>> key".
>>>
>>> But I get the message "failed to allocate main tcb", that is in the sa=
me
>>> file, but at the line #1790.
>>>
>>
>> Ah, sorry, you are right. Didn't read careful enough.
>
> Ok, no problem :-)
>
>>
>> Could the heap be fragmented after lots and lots of
>> allocations/releases? But what is also a bit strange is that the main
>> thread is continuously mapped. Are you restarting the main application
>> for every request?
>>
>
> The main application is started once and keeps running, but internally
> creates and destroys many Xenomay tasks.
>
> During the main application lifetime (that can be long), the service
> application reads some statistics from the main application, prints
> these statistics and exits. Then, the main application is never
> restarted, and the service application is restarted for every request,
> that happens every 5 seconds (but the error seems not dependent on the
> service application restart period length).

Ok, so the service applications are mapping its main thread against
Xenomai, and that as pshared apps using the shared heap.

>
> On another device I have a similar (but not same) main application, and
> the same service application, and this problem does not show.
>
> Then, the problem should be located in the main application, but I can't
> figure out where the problem could be.

As the allocation happens against a shared, global heap, the issue may
be global as well. You could either try to trace the allocation/release
pattern against the shared heap and look for anomalies or even factor
out that pattern into a stand-alone reproducer.

Jan

