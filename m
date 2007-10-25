Message-ID: <4720AFF2.9090309@domain.hid>
Date: Thu, 25 Oct 2007 17:02:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4720A719.7090100@domain.hid> <4720AB1B.4060300@domain.hid>
	<4720AC27.9040705@domain.hid>
In-Reply-To: <4720AC27.9040705@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] kernel BUG running cyclictest on powerpc 405
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> Thanks!  I'll try your patch and report if I still have trouble.
> 
> I've attached my patch for PPC405.
> 

Thanks. You may also want to upgrade to this I-pipe patch; it should
apply properly against -rc7:

http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.23-powerpc-DENX-2.0-02.patch

You would still need the quick fix for the UIC on top of that one, though.

>     Steve
> 
> Philippe Gerum wrote:
>> Steven A. Falco wrote:
>>   
>>> I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai 2.4-rc3. 
>>> Architecture is powerpc, processor is a 405GP.
>>>
>>> I had to make some additions to arch/powerpc/kernel/head_40x.S, and I
>>> can submit a patch if someone tells me where to post it.
>>>
>>>     
>>
>> Here would be nice, or to the Adeos list, indifferently - I would pick
>> it from both anyway.
>>
>>   
>>> However, while the kernel boots and runs, the xenomai user apps do not
>>> work correctly.  Specifically, when running cyclictest, I get the following:
>>>
>>>     
>>
>> This patch should fix this issue.
>>
>> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
>> index eeb38e2..5a38086 100644
>> --- a/arch/powerpc/sysdev/uic.c
>> +++ b/arch/powerpc/sysdev/uic.c
>> @@ -48,7 +48,7 @@ struct uic {
>>  	int index;
>>  	int dcrbase;
>>
>> -	spinlock_t lock;
>> +	ipipe_spinlock_t lock;
>>
>>  	/* The remapper for this UIC */
>>  	struct irq_host	*irqhost;
>>   
>>> How do I debug this?  I have done a little kernel hacking, but I am a
>>> noob when it comes to Xenomai...
>>>
>>>     
>>
>> Well, actually, it's shame on me. I did not notice that the universal
>> interrupt controller code was missing some bits in post-2.6.21 I-pipe
>> patches.
>>
>>   


-- 
Philippe.

