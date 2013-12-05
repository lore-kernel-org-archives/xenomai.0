Message-ID: <52A05E08.10105@xenomai.org>
Date: Thu, 05 Dec 2013 12:05:44 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
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
 <BBB3C87A-FD9C-47B4-BE9F-BFE18DD0D6F3@open.ac.uk>
In-Reply-To: <BBB3C87A-FD9C-47B4-BE9F-BFE18DD0D6F3@open.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kurijn Buys <Kurijn.Buys@open.ac.uk>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/05/2013 11:28 AM, Kurijn Buys wrote:
>
> Op 5-dec.-2013, om 00:44 heeft Kurijn Buys het volgende geschreven:
>
>>
>> Op 4-dec.-2013, om 17:43 heeft Philippe Gerum het volgende geschreven:
>>
>>> On 12/04/2013 05:03 PM, Gilles Chanteperdrix wrote:
>>>> On 12/04/2013 02:19 PM, Philippe Gerum wrote:
>>>>> On 12/04/2013 01:00 PM, Gilles Chanteperdrix wrote:
>>>>>> Ok, could you push the branch somewhere so that I can try it?
>>>>>>
>>>>>
>>>>> testing/ipipe-3.8-i915-fix
>>>>
>>>> I could test it, I no longer get high latencies while moving a large
>>>> opengl window. So, it looks good.
>>
>> I've it running as well (with the priority coupling option disabled this time). The latency test results in a worst value of 52us (no idea if this is normal, the lat max globally stays between 10 and 30us), but I have no higher pikes under load in each case...
>> The other test I mentioned before still has a few measurements that occur at 10us in stead of 1000us... maybe it's an issue with this test...
>>
>> I have the same oddity as the other time I installed a 3.8 kernel on Ubuntu 10.04:
>> -the /proc/ipipe files don't look how they should I guess. The Linux file is full of lines with "__ipipe_do_IRQ" and near the end a line with "__ipipe_do_critical_sync"...
>> -the version file only states "1"

Which is expected, the ipipe now reports its core release number. It 
looks like we forgot to bump it a couple of times though.

>> -the xenomai file mainly has lines with "..." and also this critical sync line near the end.
>>
>> Also, I tried to enable the ipipe tracer but without the "tracing on boot" option, but I can't get it to work now. When I do "echo < 1 /proc/ipipe/trace/enable" (as root), the flag stays on 0. and the frozen file remains empty.
>

You likely mean:

# echo 1 > /proc/ipipe/trace/enable

> For some unknown reason, now the tracer works (I didn't even do a reboot en the mean time), and now I have difficulties setting trace/enable to 0.
>
> Another latency test had a pike of 62us (but pikes are very rare now, and not dependent on load anymore), which seems related to the ipipe frozen line:
> -56!    44.220  __ipipe_spin_lock_irqsave+0x5 (mask_and_ack_8259A+0x22)
>

Accessing the legacy 8259 PIC is slow.

# cat /proc/interrupt

?

-- 
Philippe.

