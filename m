Subject: Re: IPIPE patch causes hang during initrd boot; Ubuntu 18 desktop
 system
References: <SN6PR09MB3069382F832609A66E69622A80100@SN6PR09MB3069.namprd09.prod.outlook.com>
 <4b6996dc-e425-cdfd-b95e-48c2aaa100d6@web.de>
 <SN6PR09MB3069402961C0EE909D4D891480EC0@SN6PR09MB3069.namprd09.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1c7d17c8-f018-cbc9-3740-1a2ad0ad49d3@siemens.com>
Date: Wed, 12 Jun 2019 15:05:15 +0200
MIME-Version: 1.0
In-Reply-To: <SN6PR09MB3069402961C0EE909D4D891480EC0@SN6PR09MB3069.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Proctor, Frederick M. (Fed)" <frederick.proctor@nist.gov>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12.06.19 14:37, Proctor, Frederick M. (Fed) via Xenomai wrote:
>> On 07.06.19 15:02, Proctor, Frederick M. (Fed) via Xenomai wrote:
>>> I am installing Xenomai + Cobalt with the IPIPE patch on a Ubuntu
>>> 18-based x86/64 desktop system. I have these versions:
>>>
>>> Linux kernel 4.14.71 PREEMPT_RT patch 4.14.71-rt44 IPIPE 4.14.71
>>
>> Latest stable I-pipe version is ipipe-core-4.14.111-x86-3.
>>
> 
> I was using 4.14.71 since it has patches for both IPIPE and PREEMPT_RT. I had used 4.14.111 also, but had the same kernel hang problem at boot time.
> 

OK.

>>>
>>> I have compiled the kernel three different ways: the stock
>>> configuration, with the PREEMPT_RT patch, and with the IPIPE patch (no
>>> PREEMPT_RT). I have configured out the ACPI processor, CPU_FREQ, and
>>> CPU_IDLE options in all cases. The first two boot fine (stock kernel,
>>> PREEMPT_RT). The IPIPE-patched kernel hangs during the initrd loading
>>> phase.
>>>
>>> I've tailored the kernel configuration somewhat based on the hardware
>>> I have, but nothing has worked to get a booting IPIPE kernel.
>>>
>>> Does anyone have guidance on setting up the IPIPE patch on an x86/64
>>> kernel on a desktop Ubuntu 18 machine? I am planning on continuing to
>>> trim down the kernel config options, but before I do this, I want to
>>> ask this group if anyone has had a similar problem.
>>>
>>
>> Does yous system start to boot again when the I-pipe kernel is built without
>> CONFIG_IPIPE and CONFIG_XENOMAI? If no, compare the config to a
>> working one, step-wise aligning to it.
>>
>> Jan
> 
> Yes it does - with the kernel patched with IPIPE and Xenomai, but with IPIPE and Xenomai *not selected* in the kernel config, the kernel boots fine. With IPIPE and Xenomai *selected* in a subsequent kernel config, that kernel hangs. Here's the diff on the config files:
> 

Can you share the full config? Maybe something subtly incompatible with I-pipe 
is enabled, maybe I can reproduce in KVM (ie. with a chance to debug).

Jan

-- 
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

