MIME-Version: 1.0
In-Reply-To: <CAEMXjGyDGUf6nGNGfibgv0NzRD=EdFfKBwa2DiS17caskPzsaw@mail.gmail.com>
References: <CAEMXjGxz2YZFL0mqpq=8c9ojUvNdw6mUSOy8cQCd5HYWHz06fQ@mail.gmail.com>
 <CAEMXjGzwez_k+3Qo-_ZJ4FvbOtLV2MjR0aV_tkeiRdGGaq4MAQ@mail.gmail.com>
 <CAEMXjGxtHB43N5oWL58F2y5rOH-yMycNaWtr+EDs009y1QJUcw@mail.gmail.com>
 <CAEMXjGykL_xTAteJ=Bz10jjL0xr9Uw1YBJpV=sV43Fkw=GAwug@mail.gmail.com>
 <9cf75cdcc753b7abfa0763ebd5ae1d91@grandegger.com>
 <3f27a9331a6514bb01d05d67fca0da4f@grandegger.com>
 <CAEMXjGyDGUf6nGNGfibgv0NzRD=EdFfKBwa2DiS17caskPzsaw@mail.gmail.com>
Date: Fri, 13 Feb 2015 16:40:11 -0800
Message-ID: <CAEMXjGymm-vZz-0enXbMy1MAm+f+_2EbhwK9xpZbC=pskDeqQQ@mail.gmail.com>
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
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Feb 12, 2015 at 11:53 PM, Steve B <sbattazzo@gmail.com> wrote:

>
>
> On Thu, Feb 12, 2015 at 11:14 PM, Wolfgang Grandegger <wg@grandegger.com>
> wrote:
>
>> On Fri, 13 Feb 2015 08:10:23 +0100, Wolfgang Grandegger
>> <wg@grandegger.com> wrote:
>> ...
>> > Maybe unbinding the Linux device from the driver as shown below (for
>> > another
>> > device) already helps:
>> >
>> > # echo f0002400.serial \
>> >    /sys/devices/f000.soc5200/f0002400.serial/driver/unbind
>>
>> Oops, the redirection ">" is missing!
>>
>> Wolfgang,
>>
>>
>>
> Thanks Wolfgang, I will give that a try. Otherwise I think it looks
> promising that just playing with the device tree settings may be enough to
> get the peripheral clock and power enabled without actually binding the
> driver!
>
> Steve
>

Hmm, unfortunately this one didn't work. I think it un-did the clock enable.

By doing something ugly as I mentioned before with the device tree I can
get the driver running and the register reads/writes seem OK, but for some
reason I'm not seeing any IRQs, so I can't get any bytes out on TX.

I tried adding the right IRQ number into my "sacrificed" UART's device tree
entry and that caused some other issue entirely.
