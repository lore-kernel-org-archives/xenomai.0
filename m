Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC12573
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1671636339; 
        bh=FbXBtj2hp3oZC/feruFETKIfq0lqr/cG2gO7tj3QKW8=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ft/GVFOjEKkemI/NIs7wEeG5OfoE4Rrys6Glq0dwI7y8MwHu9G8LBUCHpUoem2A5QTSVj6qwA0bY9q5YAK3D//8DMEQf5MDg1pl9FksWQ566SZ2Ls0v/bXqssXzuNOfpEPhVE7nDQoxbm1gwB4or1Ctba+GowDuZJeNMFF51pWfZCxJ+WPGz/RdSGCcJvAAanJGUwO5RZId7SzLEWHRwN2Nwbz4ayBlB/fKt4jhHWhmKnDCPrUwaBPpIcEahDaJKfjGLO3Q/09DwCikJvjGwWwUOySrvffoTOpr1Q0eF7F8+z1CgP8RNhJSPKQAGeL/kXNt/m/jIgMNFI0mGJcgHjw==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffngfevqffokffvtefnkfetpdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpedfofgruhhrohcuufdrfdcuoehmrghurdhsrghlvhhisehtihhnrdhitheqnecuggftrfgrthhtvghrnheptdeftdelteetleeglefgffduheejjeffuefgveejheeiueeuffefieeftdeugeelnecuffhomhgrihhnpeguvghngidruggvnecukfhppeekvddrudekkedrvdehvddrvddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegluddtrddtrdeiledrudekngdpihhnvghtpeekvddrudekkedrvdehvddrvddvjedpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepvddprhgtphhtthhopehjrghnrdhkihhsiihkrgesfigvsgdruggvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgvvhfkrfephhhoshhtqdekvddqudekkedqvdehvddqvddvjedrsghushhinhgvshhsrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghokffrpefkvfdpoffvtefjohhstheprhgr
	iihorhdqohhuthdqthhinhdqtddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [10.0.69.18] (82.188.252.227) by mta-out-01.tin.it (5.8.812) (authenticated as mau.salvi@tin.it)
        id 6358E81505421603; Wed, 21 Dec 2022 16:25:37 +0100
Message-ID: <7f782cbd-7353-7573-7768-e61a2c885c88@tin.it>
Date: Wed, 21 Dec 2022 16:25:36 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: "failed to allocate main tcb" error
Content-Language: it-IT
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
 <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
 <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
 <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
 <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
From: "Mauro S." <mau.salvi@tin.it>
In-Reply-To: <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/12/22 16:11, Jan Kiszka ha scritto:
> On 21.12.22 15:57, Mauro S. wrote:
>> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>>> On 21.12.22 15:45, Mauro S. wrote:
>>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>>> Copperplate and
>>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>>
>>>>>> I have a main application, and another service application that
>>>>>> connects
>>>>>> to the main one using shared session.
>>>>>>
>>>>>> After some time the main application is running, the service
>>>>>> application
>>>>>> stops to connect to the main one with the error
>>>>>>
>>>>>>        0"004.166| BUG in main_overlay(): [main] failed to allocate main
>>>>>> tcb
>>>>>>
>>>>>> Digging a bit in the code, I found that the failing function is the
>>>>>> xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc().
>>>>>> If I understood correctly, this function tries to allocate some space
>>>>>> from the shared heap. But the shared heap is almost free
>>>>>>
>>>>>>      # cat /proc/xenomai/heap
>>>>>>        TOTAL      FREE  NAME
>>>>>>      4194304   3616512  system heap
>>>>>>      1048576   1041776  shared heap
>>>>>>      1048576   1048480  private heap[14505]
>>>>>>        36864     19968  xddp-pool@0
>>>>>>        24576      7680  xddp-pool@10
>>>>>>
>>>>>
>>>>> This is the code that triggers the message:
>>>>>
>>>>>            if (pthread_key_create(&threadobj_tskey, finalize_thread))
>>>>>                    early_panic("failed to allocate TSD key");
>>>>>
>>>>> pthread_key_create has nothing to do with xnmalloc. That's a plain
>>>>> glibc
>>>>> service, and its documentation says:
>>>>>
>>>>>           The pthread_key_create() function shall fail if:
>>>>>
>>>>>           EAGAIN The system lacked the necessary resources to create
>>>>> another thread-specific data key, or the system-imposed limit on the
>>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been exceeded.
>>>>>
>>>>>           ENOMEM Insufficient memory exists to create the key.
>>>>>
>>>>> Already checked THOSE conditions? Are you possibly creating threads
>>>>> without cleaning them up completely?
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> Hi Jan,
>>>>
>>>> thank you.
>>>> Sorry but I can't figure out how the code you specified (that panics
>>>> generating the message "failed to allocate TSD key") could trigger the
>>>> "failed to allocate main tcb" message.
>>>>
>>>
>>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/threadobj.c#L86
>>>
>>> That's the only line in Xenomai which raises this message. If you don't
>>> believe it triggered it, start your application in gdb and put a
>>> breakpoint on that panic line.
>>>
>>> Jan
>>>
>>
>> I believe thet this code triggers the message "failed to allocate TSD key".
>>
>> But I get the message "failed to allocate main tcb", that is in the same
>> file, but at the line #1790.
>>
> 
> Ah, sorry, you are right. Didn't read careful enough.

Ok, no problem :-)

> 
> Could the heap be fragmented after lots and lots of
> allocations/releases? But what is also a bit strange is that the main
> thread is continuously mapped. Are you restarting the main application
> for every request?
> 

The main application is started once and keeps running, but internally 
creates and destroys many Xenomay tasks.

During the main application lifetime (that can be long), the service 
application reads some statistics from the main application, prints 
these statistics and exits. Then, the main application is never 
restarted, and the service application is restarted for every request, 
that happens every 5 seconds (but the error seems not dependent on the 
service application restart period length).

On another device I have a similar (but not same) main application, and 
the same service application, and this problem does not show.

Then, the problem should be located in the main application, but I can't 
figure out where the problem could be.

Thanks in advance

-- 
Mauro S.

