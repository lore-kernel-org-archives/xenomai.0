References: <57898ff1-afda-849d-dbd6-be3a480d44a8@univ-grenoble-alpes.fr>
 <CALLqZ8QjpDNEyr0kkEaktkd87gJ6+gjZB3bQ5UaXE8Fh4++xXA@mail.gmail.com>
From: Jean-Marc Lenoir <jean-marc.lenoir@univ-grenoble-alpes.fr>
Message-ID: <4875254d-fa4b-9160-aecf-9f9dc624d708@univ-grenoble-alpes.fr>
Date: Wed, 18 Apr 2018 11:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QjpDNEyr0kkEaktkd87gJ6+gjZB3bQ5UaXE8Fh4++xXA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Questions about IRQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for the explanations! It's clear for me now.
UDD seems to be exactly what I would like, so if you find some examples 
please tell me.

Jean-Marc

Le 17/04/2018 à 18:38, Greg Gallagher a écrit :
>      This API is the API for the cobalt kernel and used in kernel
> space.  These functions aren't available in user space.  Your user
> program is failing to build because the data structures exist in the
> kernel and not in user space.
>      You can create an RTDM driver to handle the IRQs from the PCI
> board and then a user space program to read data from the driver.
> Usually you can't have the Linux driver and the xenomai driver loaded
> at the same time, for drivers like RTnet, serial and SPI I have to
> unload the Linux driver or else the Xenomai probe function won't be
> called because the Linux driver has registered itself for the
> hardware.  I guess there could be exceptions to that rule.
>      If you want examples for RTDM drivers look in the drivers
> directory.  You can also look at using UDD driver to control the
> device from user space. When I get time I'll look through the code
> base and see if I can point you to some examples.  In the meantime the
> UDD source files contain some documentation about how the functions
> work if you want to get some more information.
>
> -Greg
>
> On Tue, Apr 17, 2018 at 10:59 AM, Jean-Marc Lenoir
> <jean-marc.lenoir@univ-grenoble-alpes.fr> wrote:
>> Hello,
>>
>> I would like to make a program which handle the interrupt requests of a PCI
>> board with Xenomai 3. I'm trying to use this Xenomai API:
>> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__core__irq.html
>> but there are some points that are not clear at all for me.
>>
>> 1) There is already a Linux driver that handle the IRQ of this board and I
>> need to keep this driver running because I use it for the board
>> configuration. So, if both a Linux driver and a Xenomai program try to
>> handle the same IRQ, what happen? Does Xenomai always have the priority? Or
>> do I need to configure something to give the priority to Xenomai?
>>
>> 2) This API works on kernel mode or user mode? (Actually, I'm not sure there
>> is a kernel mode, I'm a beginner with Xenomai.)
>>
>> 3) When I'm trying to make a simple program with this API (in user mode), I
>> am unable to compile it: there is some missing definitions like the
>> structure xnintr. I think I need to change something when I build the
>> Xenomai libraries but I don't know what (the current libraries are compiled
>> with the options "./configure --with-core=cobalt --enable-smp
>> --enable-pshared"). Any idea?
>>
>> 4) If someone know where I can find an example of program using this API, it
>> could help me a lot.
>>
>> Thanks for your help,
>> Jean-Marc
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai


