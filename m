MIME-Version: 1.0
In-Reply-To: <CAK4EZFShB5_8bGMJV+mQNw3pG+1BAxxxKttyU4t6QVZY0CmL6Q@mail.gmail.com>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <201402240022.11419.paul_c@tuxcnc.org>
 <CAK4EZFTC3-gENQYJy65WM=tzovSK7dnBQ+06uMKrEF_tLofWMg@mail.gmail.com>
 <CAK4EZFShB5_8bGMJV+mQNw3pG+1BAxxxKttyU4t6QVZY0CmL6Q@mail.gmail.com>
Date: Sun, 23 Feb 2014 20:20:57 -0500
Message-ID: <CAK4EZFRFamYurRWxN6Oh+tcUpUTKrNYUOxm0Jbrvn-LZmGcmfg@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I just recompiled 3.8.13 without the patch at [1], and my memory was
apparently correct.  The system stalls as shown in [1] with
dwc_otg.fiq_fix_enable=0
without the patch.

[1]  https://github.com/raspberrypi/linux/issues/355


On Sun, Feb 23, 2014 at 7:53 PM, Adam Vaughan <vaughana@umich.edu> wrote:

> Regarding Paul's question, it doesn't matter if the dwc_otg.fiq_fix_enable=1
> or 0.  The same issue is still there.
>
>
> On Sun, Feb 23, 2014 at 7:47 PM, Adam Vaughan <vaughana@umich.edu> wrote:
>
>> It's a separate issue, but I just rebuilt a Xenomai RPi 3.8.13 kernel
>> with the patch at [1], and it now boots with the USB FIQ disabled.  It has
>> been a while, but I'm pretty sure it wasn't booting with FIQ disabled
>> before, as detailed in [1].  I am able to run my FIQ code after retargeting
>> the module for the more recent kernel (my stopgap solution was to use
>> 3.5.7).
>>
>> Gilles, can you include KrfVan's patch at [1] with any modifications you
>> make to the official Xenomai RPi patches to address the issue Gregory
>> pointed out?  Also, for what its worth, I also see the same issue Gregory
>> sees in the kernel logs:
>>
>> ...
>> [    1.167969] hub 1-0:1.0: 1 port detected
>> [    1.171818] ------------[ cut here ]------------
>> [    1.175376] WARNING: at kernel/irq/handle.c:146
>> handle_irq_event_percpu+0x198/0x1c0()
>> [    1.179042] irq 75 handler usb_hcd_irq+0x0/0x84 enabled interrupts
>> ...
>>
>> [1]  https://github.com/raspberrypi/linux/issues/355
>>
>>
>
