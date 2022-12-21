Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C191C13
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1671633958; 
        bh=we1Jj7E7XbOqORM7qg9l2zPrn1f4eVG+xfJSv9nVfVs=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=twKVSjcPZiAcOloz0sP//ZfEhRE3DSGJhYt/81cMnDWnwmcONosUe2OU5Y3kYtvefyMKKpwAVI0GMxRRhYa1jeGOOmCkIks/Zaac8UMBa8TmUKYcR7By+vNvwoGKTo9gmvjie7QWUtAsdAwN6GgfUwodh1gMKq0ZCW8WYXxhQTwBnDasc6Ift+sMusOrjLh6AmYps4d1MGF9zHo5Mpxm3JsjddtmZIL9JgVFkmzEUZ9GYC8g01hcJ7gkzVgmj7YHCsllVm61kIXLxggE4LE5TTh5gi21Qpvf3wEa1vnRr5ghie2OvpzGCMhde1w1Drasmyjwg2sfB5Bj8vL9pxTnPQ==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffngfevqffokffvtefnkfetpdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpedfofgruhhrohcuufdrfdcuoehmrghurdhsrghlvhhisehtihhnrdhitheqnecuggftrfgrthhtvghrnhepudevveekffevleeugfegudeuhfejveefgeeuvdegteekteeileefudetheetkeffnecukfhppeekvddrudekkedrvdehvddrvddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegluddtrddtrdeiledrudekngdpihhnvghtpeekvddrudekkedrvdehvddrvddvjedpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepvddprhgtphhtthhopehjrghnrdhkihhsiihkrgesfigvsgdruggvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgvvhfkrfephhhoshhtqdekvddqudekkedqvdehvddqvddvjedrsghushhinhgvshhsrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghokffrpefkvfdpoffvtefjohhstheprhgriihorhdqohhuthdqthhinhdqtddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [10.0.69.18] (82.188.252.227) by mta-out-01.tin.it (5.8.812) (authenticated as mau.salvi@tin.it)
        id 6358E81505412125; Wed, 21 Dec 2022 15:45:55 +0100
Message-ID: <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
Date: Wed, 21 Dec 2022 15:45:53 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: "failed to allocate main tcb" error
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
Content-Language: it-IT
From: "Mauro S." <mau.salvi@tin.it>
In-Reply-To: <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/12/22 15:29, Jan Kiszka ha scritto:
> On 21.12.22 10:05, Mauro S. wrote:
>> Hi all,
>>
>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with Copperplate and
>> pshared enabled. Linux kernel is 5.4.181.
>>
>> I have a main application, and another service application that connects
>> to the main one using shared session.
>>
>> After some time the main application is running, the service application
>> stops to connect to the main one with the error
>>
>>      0"004.166| BUG in main_overlay(): [main] failed to allocate main tcb
>>
>> Digging a bit in the code, I found that the failing function is the
>> xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc().
>> If I understood correctly, this function tries to allocate some space
>> from the shared heap. But the shared heap is almost free
>>
>>    # cat /proc/xenomai/heap
>>      TOTAL      FREE  NAME
>>    4194304   3616512  system heap
>>    1048576   1041776  shared heap
>>    1048576   1048480  private heap[14505]
>>      36864     19968  xddp-pool@0
>>      24576      7680  xddp-pool@10
>>
> 
> This is the code that triggers the message:
> 
>          if (pthread_key_create(&threadobj_tskey, finalize_thread))
>                  early_panic("failed to allocate TSD key");
> 
> pthread_key_create has nothing to do with xnmalloc. That's a plain glibc
> service, and its documentation says:
> 
>         The pthread_key_create() function shall fail if:
> 
>         EAGAIN The system lacked the necessary resources to create
> another thread-specific data key, or the system-imposed limit on the
> total number of keys per process {PTHREAD_KEYS_MAX} has been exceeded.
> 
>         ENOMEM Insufficient memory exists to create the key.
> 
> Already checked THOSE conditions? Are you possibly creating threads
> without cleaning them up completely?
> 
> Jan
> 

Hi Jan,

thank you.
Sorry but I can't figure out how the code you specified (that panics 
generating the message "failed to allocate TSD key") could trigger the 
"failed to allocate main tcb" message.

Thanks again, regards

-- 
Mauro S.

