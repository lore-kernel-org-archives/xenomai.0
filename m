Message-ID: <50DCAC78.2060601@xenomai.org>
Date: Thu, 27 Dec 2012 21:15:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAFjfccCyg_nbnNB3UGxEbWy3+SV+wp9T5iuj87DBN1Do08C7DQ@mail.gmail.com>
	<loom.20121227T200150-371@post.gmane.org>
	<50DCA303.7090303@xenomai.org>
In-Reply-To: <50DCA303.7090303@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Kernel compilation error due to Adeos patch error in
 'io_apic.c'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/27/2012 08:35 PM, Gilles Chanteperdrix wrote:
> On 12/27/2012 08:06 PM, Wim wrote:
>
>>
>>> Vanilla Kernel: 3.2.21
>>> Adeos Patch: ipipe-core-3.2.21-x86-1.patch
>>> gcc --version: 4.7.0
>>> Xenomai Version: 2.6.1
>>>
>>> Patch applies itself cleanly.
>>>
>>> Compilation error during initial kernel 'make':
>>> arch/x86/kernel/apic/io_apic.c: In function
>>> ‘irq_remap_modify_chip_defaults’:
>>> arch/x86/kernel/apic/io_apic.c:2763:1: error: expected expression before
>>> ‘}’ token
>>>
>>> Problem:
>>> Commas instead of semi-colons at the end of lines inside CONFIG_IPIPE 'if'
>>> directives in 'io_apic.c'.
>>
>>
>>
>> Thanks Steve, this really helped!
>>
>> I can confirm that this problem still exists with yesterday's
>> stable Xenomai release 2.6.2, ipipe-core-3.2.21-x86-2.patch, a vanilla 3.2.21
>> kernel, ang gcc 4.6.3 on Ubuntu 12.04.
>
>
> Ok, do you have the issue with I-pipe core 3.4 and 3.5 ?
>
>

No, it's fixed there. This patch was not backported to 3.2.
2.6.2.1 is likely on its way.

-- 
Philippe.

