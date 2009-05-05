MIME-Version: 1.0
In-Reply-To: <49FFEF47.4070307@domain.hid>
References: <ff1d78710905040459u56772812kb95fb6083a2ee0c5@domain.hid>
	<200905041409.01179.smolorz@domain.hid>
	<ff1d78710905040630r754df1ffme2f56f51fada6302@domain.hid>
	<200905041539.35371.smolorz@domain.hid>
	<ff1d78710905050041sea4479eu219fa6791fae263d@domain.hid>
	<49FFEF47.4070307@domain.hid>
Date: Tue, 5 May 2009 14:04:56 +0200
Message-ID: <ff1d78710905050504u3b685de3g54f0fefc046078a@domain.hid>
From: Steven Kauffmann <steven.kauffmann@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel lockup when shared IRQ is enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, May 5, 2009 at 9:48 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Steven Kauffmann wrote:
>> 2009/5/4 Sebastian Smolorz <smolorz@domain.hid>:
>>> Steven Kauffmann wrote:
>>>> 2009/5/4 Sebastian Smolorz <smolorz@domain.hid>:
>>>>> Steven Kauffmann wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> As some other people on this mailing list, we also have system lockups
>>>>>> with the latest 2.4 branch. For some people the problems seems to be
>>>>>> solved when using the adeos-ipipe-2.6.28.9-x86-2.2-07.patch. So we
>>>>>> tried that but the system still freezes. The console output on another
>>>>>> machine reports nothing when the system freezes but at computer
>>>>>> startup we found this line:
>>>>>>
>>>>>> Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disabling IRQ line.
>>>>>>
>>>>>> lspci shows us that the peak CAN card and the ethernet controller use
>>>>>> the same IRQ.
>>>>> Generally, it is problematic to share IRQs between RT and NRT devices.
>>>>> You better try to decouple these two devices WRT IRQ sharing.
>>>>>
>>>>>> Every time we try to bring up the ethernet device the system freezes.
>>>>>> Is this related with the above kernel log message and that both cards
>>>>>> use the same IRQ?
>>>>> Are you sure that the system freezes? Do you happen to be logged in over
>>>>> the net?
>>>> Yes I'm sure. I cannot ping to the system anymore ...
>>> That is not a sign of a freezed system. The ping does not get replied because
>>> the ethernet IRQ is not handled any more. I bet the system continues to work.
>>> You can check this by using a serial console or a local keyboard.
>>
>> The system doesn't react when I try to switch to the first virtual terminal.
>
> The sharing of IRQs between real-time and non real-time hardware is in
> fact an FAQ: "What can I do if Xenomai and Linux devices share the same
> IRQ?"
>
> http://www.xenomai.org/index.php/FAQs
>
> The lockup you get could come from this first problem. So, you should
> eliminate this problem before concluding that Xenomai has a bug on your
> hardware.

What I didn't mention in my previous mails is that I can trigger the
lockup of my system by starting eclipse.

I tried to get a unique IRQ for the CAN card, but it looks like it
always shares it IRQ with another device (USB controller or VGA
controller or ... ). At the moment it shares the IRQ (IRQ 10) with the
VGA controller but the system runs fine now (I can start eclipse). Why
can it share the IRQ with the VGA controller without having the lockup
or is it just good luck?

I also tried it on another patched kernel (2.6.27.19-ipipe-2.2-06) and
now my CAN card gets another IRQ (IRQ 16) and again shares it with the
VGA controller. Are the kernel options CONFIG_X86_LOCAL_APIC and
CONFIG_X86_IO_APIC responsible for the differences of the IRQ between
the two kernels?

But if I try to open eclipse in this kernel my system freezes again.
Even if I unplug the CAN card (the only PCI card in my system) the
system freezes when I try to start eclipse.

