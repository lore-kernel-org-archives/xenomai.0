MIME-Version: 1.0
In-Reply-To: <CAFkYNwY9xwZ9iazzpgdg5854z-bwwLCsezFHj0TEiPRKrG8qCQ@mail.gmail.com>
References: <44k2rqz38u.fsf@be-well.ilk.org>
 <CAFkYNwYJ7ah+U97Pwuqwf9Phg=J0rTjr1txfGtg0FuoN2oP7cg@mail.gmail.com>
 <20150917133220.GB31663@hermes.click-hack.org>
 <CAFkYNwacX=h7trKNEBq=KZX627nRA7u6zk6YoEOLj8_J_LEa1Q@mail.gmail.com>
 <20150918074633.GA7301@hermes.click-hack.org>
 <CAFkYNwaBpwoC7rZBV4eRd7XEZ+c1GzNJZN9ZY_n9WO184A=pFQ@mail.gmail.com>
 <20150918122903.GC7301@hermes.click-hack.org>
 <CAFkYNwa+1ib=a+13PWYdNEwU35pvckchVwGa+Q8Ep7caSo7ioA@mail.gmail.com>
 <20150918124402.GD7301@hermes.click-hack.org>
 <CAFkYNwaSGcNOzKO=frN55CKj-RGSVixYMExRZqn4BaqOZ2PmzA@mail.gmail.com>
 <20150918130000.GG7301@hermes.click-hack.org>
 <CAFkYNwY9xwZ9iazzpgdg5854z-bwwLCsezFHj0TEiPRKrG8qCQ@mail.gmail.com>
Date: Sat, 19 Sep 2015 01:16:17 +1200
Message-ID: <CAFkYNwa_HaKmtTquOaMDQc_X5HOjXZGEJt1cQxVJhqfKO=nieQ@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,
Thank you so much. Finally, I got a working xenomai. Many thanks for the
help. Would this change be checked in?

Thank you once again.

On 19 September 2015 at 01:04, vibnwis <vibnwis@gmail.com> wrote:

> Thanks for sharing. Just finished compiling. Testing it soon.
>
> On 19 September 2015 at 01:00, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Sat, Sep 19, 2015 at 12:49:10AM +1200, vibnwis wrote:
>> > yes, found this in arch/arm/boot/dts/omap4.dtsi.
>> >
>> > global_timer: timer@48240200 {
>> >         compatible = "arm,cortex-a9-global-timer";
>> >         reg = <0x48240200 0x20>;
>> >         clocks = <&mpu_periphclk>;
>> >     };
>> >
>> >
>> > Everything seems to be in place right?
>>
>> Well, not really. Normally, the device tree for the global timer
>> should contain an irq declaration. We do not need it on omap4430
>> because drivers/clocksource/arm_gloabl_timer.c is badly hacked, but
>> the hack does not work on omap4460. The patch sent in another mail,
>> gets the hack also working on omap4460. But this is still a bad
>> hack.
>>
>> --
>>                                             Gilles.
>> https://click-hack.org
>>
>
>
