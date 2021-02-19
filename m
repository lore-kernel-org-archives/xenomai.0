MIME-Version: 1.0
References: <CAFZ-hKgw2hNEHshGnw4q7c3suT3wO_92P1pPw0o2e86Rn=Z2uA@mail.gmail.com>
 <CALLqZ8QnoL314ZgmwCaTF7NhcrF94zS3Gpucc0BzQwP5LFK+GQ@mail.gmail.com>
 <CAFZ-hKjjbRMPw4fFn4rZh0ev+xdPQb+_5ftAhfWOuU_Qt8GxJw@mail.gmail.com>
 <CALLqZ8T8gnu7UmQoC3KeM1sPjrj9cAkVan_U+KQdhCGDvwC+EQ@mail.gmail.com>
In-Reply-To: <CALLqZ8T8gnu7UmQoC3KeM1sPjrj9cAkVan_U+KQdhCGDvwC+EQ@mail.gmail.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Fri, 19 Feb 2021 17:21:26 +0100
Message-ID: <CAFZ-hKiz=E+EP4xWMWku2BDzCLCJoiqzZ66FjB=Fdvgfc1jKfg@mail.gmail.com>
Subject: Re: real time serial communication
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

great thanks for the help

Il giorno ven 19 feb 2021 alle ore 17:07 Greg Gallagher <
greg@embeddedgreg.com> ha scritto:

>
>
> On Fri, Feb 19, 2021 at 11:04 AM Leandro Bucci <guestleandro11@gmail.com>
> wrote:
>
>> ok so i have to recompile the kernel enabling what i need right?
>>
>> Il giorno ven 19 feb 2021 alle ore 16:57 Greg Gallagher <
>> greg@embeddedgreg.com> ha scritto:
>>
>>>
>>>
>>> On Fri, Feb 19, 2021 at 10:33 AM Leandro Bucci via Xenomai <
>>> xenomai@xenomai.org> wrote:
>>>
>>>> Hi.
>>>> I have Xenomai on the raspberry PI 3 B +. I would like to use the serial
>>>> port to make two raspberry (both with xenomai) communicate. If I use the
>>>> serial0 device everything works but I get huge latencies caused by the
>>>> modeswitches. I saw that it is possible to do serial communication even
>>>> using only the Xenomai domain. But I can't, in fact even the example in
>>>> the
>>>> Demo folder, "cross-link", works and I get the error "can't open / dev /
>>>> rtdm / rtser0". The problem is that I certainly didn't insert the rtdm
>>>> module when compiling the kernel. Can I somehow fix it without having to
>>>> reinstall xenomai all over again?
>>>> Thanks for your help
>>>>
>>> Hi,
>>>   You should be able to rebuild it as a module and insert it.
>>>
>>> -Greg
>>>
>>
> Yes, recompile kernel and mark that driver to be built as a module. You
> should be able to copy the module over and insert it at runtime.
>
> -Greg
>
>>
