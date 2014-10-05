MIME-Version: 1.0
In-Reply-To: <20141004113116.GC7596@sisyphus.hd.free.fr>
References: <20141003072059.GA2450@sisyphus.hd.free.fr>
 <CACreCVLij_wUhe3pkpd7fjHKQV0=+NZf3a_EXoWzJu5v9Oon-Q@mail.gmail.com>
 <20141003085757.GI2450@sisyphus.hd.free.fr>
 <CACreCV+0uY+j2ZSGP7xUpQQ7_J=3tgtC+5UXxfqxd852719xXg@mail.gmail.com>
 <542EA6A2.306@xenomai.org>
 <CACreCVKe_nw=6p1xQkbziPne4cW74kx0EtUWG0kC4roS7+w+yw@mail.gmail.com>
 <20141003191454.GF9452@sisyphus.hd.free.fr>
 <CACreCVLi=QT72p0pca76_7tsJn+TazdQjyy7NHW_NwfxCYbuKA@mail.gmail.com>
 <20141003224829.GA6850@sisyphus.hd.free.fr>
 <CACreCV+TDzXxX=e7MpscYcGn1sTTye9N-mED0iPfqVB9Zm4xdQ@mail.gmail.com>
 <20141004113116.GC7596@sisyphus.hd.free.fr>
Date: Mon, 6 Oct 2014 06:00:23 +0800
Message-ID: <CACreCV+ok_Ogd3iFPGNS3n640hdLQC3C_Pyzz=w80St-7buXWQ@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Oct 4, 2014 at 7:31 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Sat, Oct 04, 2014 at 06:26:33PM +0800, GP Orcullo wrote:
>> On Sat, Oct 4, 2014 at 6:48 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Sat, Oct 04, 2014 at 06:45:08AM +0800, GP Orcullo wrote:
>> >> On Sat, Oct 4, 2014 at 3:14 AM, Gilles Chanteperdrix
>> >> <gilles.chanteperdrix@xenomai.org> wrote:
>> >> > On Fri, Oct 03, 2014 at 11:28:52PM +0800, GP Orcullo wrote:
>> >> >> I've added BUG_ON(!hard_irqs_disabled()) to the code and got the
>> >> >> kernel to oops at startup.
>> >> >>
>> >> >> Where shall I start looking for the offending code?
>> >> >
>> >> > The thing is, all the tracepoints you have are late after the
>> >> > fault. A better strategy is to replace BUG_ON(!hard_irqs_disabled)
>> >> > with:
>> >> >
>> >> > if (!hard_irqs_disabled()) {
>> >> >    ipipe_trace_panic_freeze();
>> >> >    ipipe_trace_panic_dump();
>> >> >    BUG();
>> >> > }
>> >> >
>> >>
>> >> The results are almost similar.
>> >>
>> >
>> >> [   15.550769] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
>> >
>>
>> This is due to user error - I've mixed up the module versions...
>>
>> > This is not caused by the code above. This is another bug.
>> >
>> > With the code above, you should see a line
>> > "BUG" or something.
>> >
>>
>> Getting this kernel to print any messages before lockup is very
>> difficult. Is there another way of debugging it beside using jtag?
>>
>
> I generally use printk or the I-pipe tracer in some creative way
> (trigger a trace freeze on some condition then BUG()). You could for
> instance check whether the Linux timer irq is still running by
> putting a printascii(".") there every HZ ticks. If it is not running
> check the same with the Xenomai timer irq, then finally the I-pipe
> timer ack function. On x86 we have the NMI watchdog to help with
> lockups, maybe someone could implement a similar functionality with
> FIQ on ARM.
>
> --
>                                             Gilles.


The cause of the lockups is due to CONFIG_PREEMPT. The board is
running for more than 6 hrs now after disabling it.

Thanks for all your help!

-- 
GP Orcullo

