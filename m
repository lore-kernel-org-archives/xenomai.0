MIME-Version: 1.0
In-Reply-To: <CAEMXjGxtHB43N5oWL58F2y5rOH-yMycNaWtr+EDs009y1QJUcw@mail.gmail.com>
References: <CAEMXjGxz2YZFL0mqpq=8c9ojUvNdw6mUSOy8cQCd5HYWHz06fQ@mail.gmail.com>
 <CAEMXjGzwez_k+3Qo-_ZJ4FvbOtLV2MjR0aV_tkeiRdGGaq4MAQ@mail.gmail.com>
 <CAEMXjGxtHB43N5oWL58F2y5rOH-yMycNaWtr+EDs009y1QJUcw@mail.gmail.com>
Date: Thu, 12 Feb 2015 18:36:14 -0800
Message-ID: <CAEMXjGykL_xTAteJ=Bz10jjL0xr9Uw1YBJpV=sV43Fkw=GAwug@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] 16550 serial driver on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On Thu, Feb 12, 2015 at 5:03 PM, Steve B <sbattazzo@gmail.com> wrote:

> Nevermind, the shift looks OK, I guess that the 0xFA in the uppermost byte
> of the address is because of the ioremap call?
>
> Steve
>
> On Thu, Feb 12, 2015 at 4:51 PM, Steve B <sbattazzo@gmail.com> wrote:
>
>> Hello Gilles,
>> I tried your patch to 16550A_io.h from the discussion with Terje Frosya
>> in November and I believe I can see why it didn't work.
>>
>> I added a couple of printk statements to verify that the driver is
>> reading and writing to the intended addresses, and here's what I got:
>>
>> [   40.594119] xeno_16550A: Init IO at address 0x481AA000
>> [   40.594159] xeno_16550A: Writing: FA1AA004. Regwidth 2 Regshift 2
>> [   40.594169] xeno_16550A: Reading: FA1AA008. Regwidth 2 Regshift 2
>> [   40.594183] Unhandled fault: external abort on non-linefetch (0x1028)
>> at 0xfa1aa008
>>
>> It looks like the regshift is operating on the most significant byte of
>> the base address rather than the least significant! Perhaps it's something
>> to do with the endianness, but I still haven't wrapped my brain around why.
>> Of course it makes sense that you are getting a segfault because the code
>> is trying to read/write entirely the wrong address.
>>
>> Any thoughts?
>>
>> PS, Terje I think I saw on a Google Groups thread elsewhere that you had
>> given up on this and found a different solution, but I am including you on
>> this in case you may be curious about it.
>>
>> Thanks,
>>
>> Steve
>>
>>
>> On Wed, Feb 11, 2015 at 8:02 PM, Steve B <sbattazzo@gmail.com> wrote:
>>
>>> Hello all,
>>> Was there ever a resolution to running the 16550 driver on Beaglebone
>>> Black? I see that there was a discussion on this in November but I don't
>>> see anything saying that somebody got it to work.
>>>
>>> Thanks,
>>>
>>> Steve
>>>
>>
>>
>
Hello again,
I was not able to run a C program to directly set the one register that
needs to be set to turn on the UART clock, but I was able to get
xeno_16550A to load by sort of tricking the OS into enabling the UART clock
without loading the regular driver for a given UART.
I had to sacrifice one UART that I'm not using, which is not ideal in the
long run but will work for now.

Here's what I did:
Commented out the UART that I want to use from the device tree
(serial5/uart6).
Replaced the line ti,hwmods="uart3"; with ti,hwmods="uart6"; for the one
that I do want to use.
This is evidently what causes the power/clock management driver to enable
the clock for that particular module.

This causes a segfault when trying to enable UART3 because it's obviously
not turned on with this little hack.

If there is a way to create a sort of dummy device tree entry with only the
ti,hwmods part then I think the problem may be solved.
The problem right now is each entry begins something like serial@481a8000{
or similar, which evidently links the driver to the address which we don't
want.

Cheers,

Steve
