Message-ID: <43A32305.8030004@domain.hid>
Date: Fri, 16 Dec 2005 21:26:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>	<438DE166.5090303@domain.hid>
	<438DE551.7080708@domain.hid>
In-Reply-To: <438DE551.7080708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: anders.blomdell@domain.hid, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Jan Kiszka wrote:
>>
>>> Hi Philippe,
>>>
>>> I'm afraid this one is serious: let the attached migration stress test
>>> run on likely any Xenomai since 2.0, preferably with
>>> CONFIG_XENO_OPT_DEBUG on. Will give a nice crash sooner or later (I'm
>>> trying to set up a serial console now).
>>>
> 
> Confirmed here. My test box went through some nifty triple salto out of 
> the window running this frag for 2mn or so. Actually, the semop 
> handshake is not even needed to cause the crash. At first sight, it 
> looks like a migration issue taking place during the critical phase when 
> a shadow thread switches back to Linux to terminate.
> 
>>
>>
>> As it took some time to persuade my box to not just reboot but to give a
>> message, I'm posting here the kernel dump of the P-III running
>> nat_migration:
>>
>> [...]
>> Xenomai: starting native API services.
>> ce649fb4 ce648000 00000b17 00000202 c0139246 cdf2819c cdf28070 0b12d310
>>        00000037 ce648000 00000000 c02f0700 00009a28 00000000 b7e94a70
>> bfed63c8
>>        00000000 ce648000 c0102fcb b7e94a70 bfed63dc b7faf4b0 bfed63c8
>> 00000000
>> Call Trace:
>>  [<c0139246>] __ipipe_dispatch_event+0x96/0x130
>>  [<c0102fcb>] work_resched+0x6/0x1c
>> Xenomai: fatal: blocked thread migration[22175] rescheduled?!
>> (status=0x300010, sig=0, prev=watchdog/0[3])
> 
> 
> This babe is awaken by Linux while Xeno sees it in a dormant state, 
> likely after it has terminated. No wonder why things are going wild 
> after that... Ok, job queued. Thanks.
> 
>>  CPU  PID    PRI  TIMEOUT  STAT      NAME
>>
>>> 0  0      0    0        00500080  ROOT
>>
>>
>>    0  22175  1    0        00300110  migration
>> Timer: none
>>
>> cea05ee4 d0842c62 cdcb0000 cea6d030 c02f0700 c035cbec c02f0700 00000286
>>        c0139246 00000022 c02f0700 cdf28070 cdf28070 00000022 00000001
>> c02f0700
>>        cea6d030 cdf28070 cea6d158 cea05f78 c02b26c0 cea04000 00000238
>> d1244537
>> Call Trace:
>>  [<c0139246>] __ipipe_dispatch_event+0x96/0x130
>>  [<c02b26c0>] schedule+0x2d0/0x720
>>  [<c0137b20>] watchdog+0x0/0x80
>>  [<c02b3967>] schedule_timeout+0x47/0xb0
>>  [<c0120070>] process_timeout+0x0/0x10
>>  [<c0120492>] msleep_interruptible+0x42/0x60
>>  [<c0137b70>] watchdog+0x50/0x80
>>  [<c012d0ab>] kthread+0x8b/0x90
>>  [<c012d020>] kthread+0x0/0x90
>>  [<c0100ef5>] kernel_thread_helper+0x5/0x10

Fixed. The cause was related to the thread migration routine to primary 
mode (xnshadow_harden), which would spuriously call the Linux 
rescheduling procedure from the primary domain under certain 
circumstances. This bug only triggers on preemptible kernels. This also 
fixes the spinlock recursion issue which is sometimes triggered when the 
spinlock debug option is active.

-- 

Philippe.

