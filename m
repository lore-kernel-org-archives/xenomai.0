References: <42c109690d5e4729812cc187a71dd5b0@P10-EX01.3DSystems.Internal>
 <1526523181.3850725.1374998144.0B5577D4@webmail.messagingengine.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ed5b3323-845b-51a6-8b25-afa3ccfd045a@siemens.com>
Date: Fri, 18 May 2018 09:00:29 +0200
MIME-Version: 1.0
In-Reply-To: <1526523181.3850725.1374998144.0B5577D4@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Boot failed on arm64 - xenomai_init --> ipipe_send_ipi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>, xenomai@xenomai.org

On 2018-05-17 04:13, Dmitriy Cherkasov wrote:
> On Wed, May 16, 2018, at 11:13 AM, Auel, Kendall wrote:
>> I'm trying to build a xenomai-enabled kernel for an arm64 (quad A53 
>> cores). Something is not configured correctly, but I haven't been able 
>> to get past a stall during xenomai_init. Any ideas on what I'm doing 
>> wrong? Thanks.
>>
>> [    0.729547] kvm [1]: 8-bit VMID
>> [    0.732121] kvm [1]: IDMAP page: 40c5e000
>> [    0.736134] kvm [1]: HYP VA range: 800000000000:ffffffffffff
>> [    0.742609] kvm [1]: Hyp mode initialized successfully
> 
> I don't think this patch has ever been tested with KVM/HYP mode. I
> would try and see if it works in SVC mode on the same hardware.
> 

It's unlikely that the presence of KVM is causing issues: Linux just
installs the needed hypervisor stub in EL2 but will continue in EL1 from
then on. Only when actually spawning a VM, that code will come into play
again.

I'm rather concerned to see gic_raise_softirq causing a Linux context
switch. I suppose there is some Linux synchronization mechanism in play,
and the patch lacks related adaptions of that.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

