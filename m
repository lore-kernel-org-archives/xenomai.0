MIME-Version: 1.0
In-Reply-To: <CAOuPNLj+-UHQ__AxN_mBWk0NitRf0oLqUZOPOae4i_NSHPa5MA@mail.gmail.com>
References: <CAOuPNLjTo8E7z=11ip8Dtjvt2dm=PU-+9urgwn8qgYCEcyxmMQ@mail.gmail.com>
 <75d25b2f-e82b-d7ab-da1f-48192862a5af@siemens.com>
 <CAOuPNLj+-UHQ__AxN_mBWk0NitRf0oLqUZOPOae4i_NSHPa5MA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 26 Feb 2018 12:28:43 -0500
Message-ID: <CALLqZ8QFmD_rHhbaAFymoCJAdhK1EdLWFK6xWdqW+T7EykuQ=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [RTDM] Converting existing Linux char driver to rtdm
	driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

You'd have to decide what functionality you want with respect to rt
and non rt for your driver.  What's confusing about the context?  The
gpio driver is pretty up to date, you can look at it for some
guidance.  Unfortunately there isn't a lot of documentation at the
moment, so your best bet is to look at some of the existing drivers.
It's easier to answer specific questions you may have about the RTDM
framework.  The other question is do you need at RTDM driver?  Could
you use the UDD framework instead?  With the UDD framework you just
need to support a small RTDM driver and the rest of the driver lives
in user space.

-Greg

On Mon, Feb 26, 2018 at 12:20 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Dear Jan,
>
> This thread is about porting a normal misc char driver to rtdm model.
>
> Anyways I got some clue by looking into rtdmtest driver.
> But what is confusing to me is the rtdm context_ part and the rt, nrt part.
> How can I map this eith my exusting driver?
> Can I leave the context part NULL and use only rt for all other calls.
>
> Thanks,
> Pintu
>
> On 26 Feb 2018 7:54 pm, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>
>> On 2018-02-26 12:26, Pintu Kumar wrote:
>> > Hi,
>> >
>> > I have a sample linux char driver which I am registering using normal
>> > misc_register/deregister function.
>> > In this driver, I have used, open, read, write, ioctl, release system
>> > calls.
>> >
>> > Now I wanted to convert this driver to RTDM interface and compare it.
>> > Later I wanted to add some more use cases related to interrupt
>> > processing by connecting some external peripheral.
>> >
>> > Firstly, please guide me how to easily convert an existing linux char
>> > driver to RTDM model.
>> >
>>
>> Conversion of existing Linux UART drivers to RTDM is not straightforward
>> as the former relies on a larger hierarchy of Linux drivers, starting
>> with the tty core over the serial core and possibly some chip
>> abstractions (8250). RTDM, as you can see from the existing drivers in
>> kernel/drivers/serial, is rather compact and does not come with that
>> infrastructure, primarily as it has a confined use case. Best is to
>> study those drivers, use one as template and replace the required
>> hardware accesses.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux

