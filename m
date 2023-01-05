Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411310785
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1672950488; 
        bh=lIypGJps71KopCB4gjqshAuVSS61IrGyQMefhUn9+MY=;
        h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:In-Reply-To;
        b=g5vohO3+kYsbeZSCgiOp+hGKOTTOTe9hrSZURdJmX4e2IyaCyO52IISzbO1t1/SMvxJF0pFtLsA1B/uVnl0rykPkc56hS4kB3urvOFmpOQQjbVnpwLhI+3puAhBvPRGL49kBo+Fl5tIhPzu4F2WgspJh8FlwZDRC3RAT80gcKPsSyth65M8mlfU7CHiUyYJw0HwQucPVcT01/cFjHyjb8i5Eg/pErwv7O1bCOnpILfHTi0uvM8SG3EbGEg4fTDENHIb5iAKcKLpnmUkmduBU78dQiPVHMm+8C8+JEzfVENIZZOnaCWtDpKSWakrB+m1+XGwPYLO66MoRAxb/+YnBPA==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuhffvfhevjgesmhdtreertdefjeenucfhrhhomhepfdforghurhhoucfurddfuceomhgruhdrshgrlhhvihesthhinhdrihhtqeenucggtffrrghtthgvrhhnpeeifefgvedtveeuleduheekueefudegkedthfdugfevleehjeetgfeiteetjeeghfenucffohhmrghinhepuggvnhigrdguvgenucfkphepkedvrdehvddrvddtuddrudekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedrudejkedrfeelngdpihhnvghtpeekvddrhedvrddvtddurddukeehpdhmrghilhhfrhhomhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrseifvggsrdguvgdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrvghvkffrpehhohhsthdqkedvqdehvddqvddtuddqudekhedrrhgvthgrihhlrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghokffrpefkvfdpoffvtefjohhstheprhgr
	iihorhdqohhuthdqthhinhdqtddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.178.39] (82.52.201.185) by mta-out-01.tin.it (5.8.812) (authenticated as mau.salvi@tin.it)
        id 6358E815065D3692; Thu, 5 Jan 2023 21:25:56 +0100
Content-Type: multipart/mixed; boundary="------------rgtPP1LwVNuT7d0jo8mcbFSo"
Message-ID: <1c345c13-bd40-b8b2-31c0-0fd87ab95162@tin.it>
Date: Thu, 5 Jan 2023 21:25:55 +0100
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
From: "Mauro S." <mau.salvi@tin.it>
To: xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
 <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
 <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
 <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
 <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
 <7f782cbd-7353-7573-7768-e61a2c885c88@tin.it>
 <30fdc0c6-d807-c062-2e98-c63f3a9d55b7@web.de>
 <641ab944-2cda-0f4b-00bd-73bd553495bb@tin.it>
 <ab51d02f-3403-7057-4403-f704ae278e74@web.de>
 <b8a7ea5c-1412-1bc6-8684-e8d2eacb2274@tin.it>
Cc: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <b8a7ea5c-1412-1bc6-8684-e8d2eacb2274@tin.it>

This is a multi-part message in MIME format.
--------------rgtPP1LwVNuT7d0jo8mcbFSo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/12/22 16:42, Mauro S. ha scritto:
> Il 22/12/22 15:11, Jan Kiszka ha scritto:
>> On 22.12.22 14:57, Mauro S. wrote:
>>> Il 21/12/22 17:04, Jan Kiszka ha scritto:
>>>> On 21.12.22 16:25, Mauro S. wrote:
>>>>> Il 21/12/22 16:11, Jan Kiszka ha scritto:
>>>>>> On 21.12.22 15:57, Mauro S. wrote:
>>>>>>> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>>>>>>>> On 21.12.22 15:45, Mauro S. wrote:
>>>>>>>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>>>>>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>>>>>>>> Copperplate and
>>>>>>>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>>>>>>>
>>>>>>>>>>> I have a main application, and another service application that
>>>>>>>>>>> connects
>>>>>>>>>>> to the main one using shared session.
>>>>>>>>>>>
>>>>>>>>>>> After some time the main application is running, the service
>>>>>>>>>>> application
>>>>>>>>>>> stops to connect to the main one with the error
>>>>>>>>>>>
>>>>>>>>>>>          0"004.166| BUG in main_overlay(): [main] failed to
>>>>>>>>>>> allocate main
>>>>>>>>>>> tcb
>>>>>>>>>>>
>>>>>>>>>>> Digging a bit in the code, I found that the failing function is
>>>>>>>>>>> the
>>>>>>>>>>> xnmalloc() call in
>>>>>>>>>>> lib/copperplate/threadobj.c:__threadobj_alloc().
>>>>>>>>>>> If I understood correctly, this function tries to allocate some
>>>>>>>>>>> space
>>>>>>>>>>> from the shared heap. But the shared heap is almost free
>>>>>>>>>>>
>>>>>>>>>>>        # cat /proc/xenomai/heap
>>>>>>>>>>>          TOTAL      FREE  NAME
>>>>>>>>>>>        4194304   3616512  system heap
>>>>>>>>>>>        1048576   1041776  shared heap
>>>>>>>>>>>        1048576   1048480  private heap[14505]
>>>>>>>>>>>          36864     19968  xddp-pool@0
>>>>>>>>>>>          24576      7680  xddp-pool@10
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is the code that triggers the message:
>>>>>>>>>>
>>>>>>>>>>              if (pthread_key_create(&threadobj_tskey,
>>>>>>>>>> finalize_thread))
>>>>>>>>>>                      early_panic("failed to allocate TSD key");
>>>>>>>>>>
>>>>>>>>>> pthread_key_create has nothing to do with xnmalloc. That's a 
>>>>>>>>>> plain
>>>>>>>>>> glibc
>>>>>>>>>> service, and its documentation says:
>>>>>>>>>>
>>>>>>>>>>             The pthread_key_create() function shall fail if:
>>>>>>>>>>
>>>>>>>>>>             EAGAIN The system lacked the necessary resources to
>>>>>>>>>> create
>>>>>>>>>> another thread-specific data key, or the system-imposed limit on
>>>>>>>>>> the
>>>>>>>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been
>>>>>>>>>> exceeded.
>>>>>>>>>>
>>>>>>>>>>             ENOMEM Insufficient memory exists to create the key.
>>>>>>>>>>
>>>>>>>>>> Already checked THOSE conditions? Are you possibly creating 
>>>>>>>>>> threads
>>>>>>>>>> without cleaning them up completely?
>>>>>>>>>>
>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> thank you.
>>>>>>>>> Sorry but I can't figure out how the code you specified (that 
>>>>>>>>> panics
>>>>>>>>> generating the message "failed to allocate TSD key") could
>>>>>>>>> trigger the
>>>>>>>>> "failed to allocate main tcb" message.
>>>>>>>>>
>>>>>>>>
>>>>>>>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/threadobj.c#L86
>>>>>>>>
>>>>>>>> That's the only line in Xenomai which raises this message. If you
>>>>>>>> don't
>>>>>>>> believe it triggered it, start your application in gdb and put a
>>>>>>>> breakpoint on that panic line.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>>> I believe thet this code triggers the message "failed to allocate 
>>>>>>> TSD
>>>>>>> key".
>>>>>>>
>>>>>>> But I get the message "failed to allocate main tcb", that is in the
>>>>>>> same
>>>>>>> file, but at the line #1790.
>>>>>>>
>>>>>>
>>>>>> Ah, sorry, you are right. Didn't read careful enough.
>>>>>
>>>>> Ok, no problem :-)
>>>>>
>>>>>>
>>>>>> Could the heap be fragmented after lots and lots of
>>>>>> allocations/releases? But what is also a bit strange is that the main
>>>>>> thread is continuously mapped. Are you restarting the main 
>>>>>> application
>>>>>> for every request?
>>>>>>
>>>>>
>>>>> The main application is started once and keeps running, but internally
>>>>> creates and destroys many Xenomay tasks.
>>>>>
>>>>> During the main application lifetime (that can be long), the service
>>>>> application reads some statistics from the main application, prints
>>>>> these statistics and exits. Then, the main application is never
>>>>> restarted, and the service application is restarted for every request,
>>>>> that happens every 5 seconds (but the error seems not dependent on the
>>>>> service application restart period length).
>>>>
>>>> Ok, so the service applications are mapping its main thread against
>>>> Xenomai, and that as pshared apps using the shared heap.
>>>>
>>>
>>> Yes, exactly.
>>>
>>>>>
>>>>> On another device I have a similar (but not same) main application, 
>>>>> and
>>>>> the same service application, and this problem does not show.
>>>>>
>>>>> Then, the problem should be located in the main application, but I 
>>>>> can't
>>>>> figure out where the problem could be.
>>>>
>>>> As the allocation happens against a shared, global heap, the issue may
>>>> be global as well. You could either try to trace the allocation/release
>>>> pattern against the shared heap and look for anomalies or even factor
>>>> out that pattern into a stand-alone reproducer.
>>>
>>> Thanks for your suggestions. Trace the allocation/release pattern would
>>> be a huge work for this application, then I started with a simple test:
>>> enlarge the heap sizes.
>>> Before I had a 4096kb system heap, 1024kb shared heap, 1024kb private 
>>> heap.
>>> Now I have a 8192kb system heap, 4096kb shared heap, 2048kb private 
>>> heap.
>>> Nothing, the error happens again. Could this be a clue that this is not
>>> a fragmentation problem and could be a heap corruption problem?
>>
>> Not impossible. The control structures should be heading the allocated
>> memory blocks, thus could get corrupted if some other user overwrites
>> its assigned block.
>>
>>>
>>> During tests, I also noted that when the error starts to happen, no
>>> tasks in main applications are created/deleted. But there are some
>>> queues and pipes communications active, then the heap could be used by
>>> them.
>>
>> All objects that could now be used across processes are allocated on the
>> shared heap if pshared is on. So we are not only looking at task objects
>> and their life cycles.
>>
>>>
>>> I will continue investigating on this problem. If you have some other
>>> ideas/hints, I'll be glad to hear them.
>>
>> Try reducing factors that could contribute to it, e.g. the types of
>> objects used. That may help narrowing down the actual trigger.
>>
>> Jan
>>
> 
> Thanks Jan, I will do some tests and (hopefully) come back with results.

Hi Jan,

sorry for the delay.

Attached there is the code of two small test programs able to reproduce 
the problem. There is also the script to start them.

Briefly, the "xeno-test-tcb-allocate-mainproc" application creates two 
rt buffers (request and response) and waits indefinitely on the request 
buffer. On the request buffer, the "xeno-test-tcb-allocate-secproc" 
writes a request and waits for the response on the response buffer. When 
the request is received by the "mainproc", the "mainproc" sends a 
response with an incremental counter on the response buffer, and returns 
to wait requests. "secproc" receives the response, prints its content 
and exits.

"secproc" is launched every 0.5 seconds. After about four minutes 
running, the "secproc" starts to fail at launch with the error

    BUG in main_overlay(): [main] failed to allocate main tcb

Thanks in advance, regards

-- 
Mauro S.

--------------rgtPP1LwVNuT7d0jo8mcbFSo
Content-Type: application/gzip; name="tcb_allocate_test.tar.gz"
Content-Disposition: attachment; filename="tcb_allocate_test.tar.gz"
Content-Transfer-Encoding: base64

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
KbMkG5aylKUsZSlLWcpS3kr+AVQnxf8AKAAA

--------------rgtPP1LwVNuT7d0jo8mcbFSo--
