Message-ID: <50640444.8010703@xenomai.org>
Date: Thu, 27 Sep 2012 09:46:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5060AFD1.30303@gmail.com> <506373F6.80406@xenomai.org>
	<5063E8DE.8010303@gmail.com>
In-Reply-To: <5063E8DE.8010303@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel 2.6.37.6 + Xenomai 2.5.6 is ok,
 but with Xenomai 2.6.1 it won't boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jari Lietzen <jari.lietzen@gmail.com>
Cc: xenomai@xenomai.org

On 09/27/2012 07:49 AM, Jari Lietzen wrote:

> 27.09.2012 00:30, Gilles Chanteperdrix kirjoitti:
>> On 09/24/2012 09:09 PM, Jari Lietzen wrote:
>>
>>> Hi!
>>>
>>> Kernel 2.6.37.6 and Xenomai 2.5.6 boots ok, though displaying the error
>>> message: "MP-BIOS bug: 8254 timer not connected to IO-APIC".
>>>
>>> If I try to use Xenomai 2.6.1 the error message displayed is the same
>>> and system just hangs after that. No other messages, keyboard doesn't
>>> work, nothing. I started with the same kernel configuration, but I have
>>> disabled a few options more (e.g. syscall auditing, shared interrupt
>>> support).
>>>
>>> I'm using Intel Core 2 Duo processor with Asus P5LD2-VM motherboard.
>>> Obviously I'm missing something, but I can't figure that out. Here is
>>> the kernel config file:
>>
>>
>> If you use one of the I-pipe patches whih ship with Xenomai 2.6.1, such
>> as the patch for linux 3.2, do you also have the issue?
>>
> 
> Hi!
> 
> Yes, I have patched the kernel with this: 
> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64 
> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37.6-x86-2.9-02.patch 
> --linux=/usr/src/linux
> 
> xenomai being a link to xenomai-2.6.1 -directory. When I switch between 
> Xenomai 2.5.6 and 2.6.1 I remove the whole linux directory and extract 
> it from the source again and change the xenomai link accordingly. With 
> Xenomai 2.5.6 the patching was done with this: 
> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64 
> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37-x86-2.9-00.patch 
>   --linux=/usr/src/linux


So, could you try Xenoami 2.5.6 with the 2.9-02 patch, or 2.6.1 with the
2.9-00 patch, or with the patch for linux 3.2 ?

-- 
                                                                Gilles.

