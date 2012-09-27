Message-ID: <50647502.9020204@gmail.com>
Date: Thu, 27 Sep 2012 18:47:14 +0300
From: Jari Lietzen <jari.lietzen@gmail.com>
MIME-Version: 1.0
References: <5060AFD1.30303@gmail.com> <506373F6.80406@xenomai.org>
	<5063E8DE.8010303@gmail.com> <50640444.8010703@xenomai.org>
In-Reply-To: <50640444.8010703@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: xenomai@xenomai.org

27.09.2012 10:46, Gilles Chanteperdrix kirjoitti:
> On 09/27/2012 07:49 AM, Jari Lietzen wrote:
>
>> 27.09.2012 00:30, Gilles Chanteperdrix kirjoitti:
>>> On 09/24/2012 09:09 PM, Jari Lietzen wrote:
>>>
>>>> Hi!
>>>>
>>>> Kernel 2.6.37.6 and Xenomai 2.5.6 boots ok, though displaying the error
>>>> message: "MP-BIOS bug: 8254 timer not connected to IO-APIC".
>>>>
>>>> If I try to use Xenomai 2.6.1 the error message displayed is the same
>>>> and system just hangs after that. No other messages, keyboard doesn't
>>>> work, nothing. I started with the same kernel configuration, but I have
>>>> disabled a few options more (e.g. syscall auditing, shared interrupt
>>>> support).
>>>>
>>>> I'm using Intel Core 2 Duo processor with Asus P5LD2-VM motherboard.
>>>> Obviously I'm missing something, but I can't figure that out. Here is
>>>> the kernel config file:
>>>
>>>
>>> If you use one of the I-pipe patches whih ship with Xenomai 2.6.1, such
>>> as the patch for linux 3.2, do you also have the issue?
>>>
>>
>> Hi!
>>
>> Yes, I have patched the kernel with this:
>> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64
>> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37.6-x86-2.9-02.patch
>> --linux=/usr/src/linux
>>
>> xenomai being a link to xenomai-2.6.1 -directory. When I switch between
>> Xenomai 2.5.6 and 2.6.1 I remove the whole linux directory and extract
>> it from the source again and change the xenomai link accordingly. With
>> Xenomai 2.5.6 the patching was done with this:
>> /usr/src/xenomai/scripts/prepare-kernel.sh --arch=x86_64
>> --adeos=/usr/src/xenomai/ksrc/arch/x86/patches/adeos-ipipe-2.6.37-x86-2.9-00.patch
>>    --linux=/usr/src/linux
>
>
> So, could you try Xenoami 2.5.6 with the 2.9-02 patch, or 2.6.1 with the
> 2.9-00 patch, or with the patch for linux 3.2 ?
>

I booted 2.6.37.6 kernel patched with 2.9-00 patch and compiled Xenomai 
2.6.1 with the following commands:

    mkdir /usr/src/xbuild
   cd /usr/src/xbuild
   /usr/src/xenomai/configure --enable-x86-sep --enable-smp --enable-x86-tsc
   make install

xenomai is a soft link pointing to /usr/src/xenomai-2.6.1.

This is a snippet from dmesg:

[    0.443563] Xenomai: hal/x86_64 started.
[    0.443583] Xenomai: scheduling class idle registered.
[    0.443585] Xenomai: scheduling class rt registered.
[    0.444338] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    0.444478] Xenomai: SMI-enabled chipset found, but SMI workaround 
disabled
[    0.444480]          (check CONFIG_XENO_HW_SMI_WORKAROUND). You may 
encounter
[    0.444481]          high interrupt latencies!
[    0.444501] Xenomai: starting native API services.
[    0.444503] Xenomai: starting POSIX services.
[    0.444542] Xenomai: starting RTDM services.


Then running /usr/xenomai/bin/xeno-test says:

Started child 1755: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper 
/usr/xenomai/bin/xeno-test
++ echo 0
++ /usr/xenomai/bin/arith
Xenomai: incompatible ABI revision level
(user-space requires '4', kernel provides '3').

I could go on with Xenomai 2.5.6, and that's what I'm using right now. 
But I'd like to bring my environment up to date. The reason I'm using 
kernel 2.6.37.6 is that my applications are build on top of IgH EtherCAT 
Master http://www.etherlab.org/en/ethercat/index.php and the kernel 
version just comes from there.

-Jari

