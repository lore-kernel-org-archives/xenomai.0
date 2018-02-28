MIME-Version: 1.0
In-Reply-To: <CAOuPNLjdRNXax22b7Bw=EsGcAmjeivFMmond_xzYbcqUn9RGvg@mail.gmail.com>
References: <CAOuPNLjTo8E7z=11ip8Dtjvt2dm=PU-+9urgwn8qgYCEcyxmMQ@mail.gmail.com>
 <75d25b2f-e82b-d7ab-da1f-48192862a5af@siemens.com>
 <CAOuPNLj+-UHQ__AxN_mBWk0NitRf0oLqUZOPOae4i_NSHPa5MA@mail.gmail.com>
 <CALLqZ8QFmD_rHhbaAFymoCJAdhK1EdLWFK6xWdqW+T7EykuQ=A@mail.gmail.com>
 <CAOuPNLjdRNXax22b7Bw=EsGcAmjeivFMmond_xzYbcqUn9RGvg@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 28 Feb 2018 17:46:16 +0530
Message-ID: <CAOuPNLhNkgL4iMzEvS_64yjsL3da6RseFzpZQxC3k-DyXGogLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am getting some error while building a RTDM driver. Please check my
inline reply.


On Tue, Feb 27, 2018 at 7:09 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Dear Greg & Jan,
>
> Thank you so much for your help. Yes I am looking into existing sample
> drivers to understand. I think I got some clue.
> Basically I am developing a dummy RTDM char driver for some
> experimentation and analysis purpose.
> As you said, since there is no proper documentation for developing a
> RTDM driver, I might be having some more silly queries (if I am
> stuck).
>
> 1)
>> What's confusing about the context?
> As I see, there is a context_size that we need to set in rtdm_driver stru=
cture.
> Is this really required to set ? Can I set it to 0 ?
> Anyways, I currently set like this (for time being):
> struct dummy_context {
>         unsigned char *buffer;
>         unsigned int len;
> };
> Hope this fine ?
>
> 2)
>> The other question is do you need at RTDM driver?
> Yes, I need to develop a RTDM driver because I need to compare it with
> normal kernel driver.
> Later I need to add some specific use case for some purpose.
>
> 3) How do we allocate memory in RTDM driver ?
>     I see rtdm_malloc()/free() is used. Is this in kernel allocation
> like kmalloc/vmalloc ?
>     Or, I need to directly use kmalloc/vmalloc itself , considering
> similar scenario like normal kernel approach.
>
> 4) ^^Most important^^: how to I compile a sample RTDM char driver?
>     Is it the same method like normal kernel Makefile and using the
> xeno_config in addition ?
>     Is there any RTDM Makefile reference available ?
>

Hi,

I get this errors when compiling a sample RTDM driver.

rtdummy.c:63:15: error: initialization from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   .write_rt =3D dummy_write,
               ^
/home/pintu/rtdummy.c:63:15: note: (near initialization for
=E2=80=98dummy_driver.ops.write_rt=E2=80=99)
cc1: some warnings being treated as errors


However, if I comment the write_rt part, the module is build successfully.
Why this error is coming only for write part, but not for read, open,
ioctl and others ?

This is my Makefile (simple Makefile used for building linux kernel module)
--------------------------------
EXTRA_CFLAGS    +=3D -I$(shell pwd)

obj-m :=3D rtdummy.o

KDIR :=3D /lib/modules/$(shell uname -r)/build
PWD :=3D $(shell pwd)

default:
        $(MAKE) -C $(KDIR) M=3D$(PWD) modules

clean:
        $(MAKE) -C $(KDIR) M=3D$(PWD) clean
--------------------------------

This is the structure used:

-------------------------------------------------------------
static struct rtdm_driver dummy_driver =3D {
        .profile_info           =3D       RTDM_PROFILE_INFO(dummy,
                                                          RTDM_CLASS_DUMMY,
                                                          RTDM_SUBCLASS_DUM=
MY,
                                                          0),
        .device_flags           =3D       RTDM_NAMED_DEVICE|RTDM_EXCLUSIVE,
        .device_count           =3D       1,
        .context_size           =3D       sizeof(struct dummy_context),
        .ops =3D {
                .open           =3D       dummy_open,
                .read_rt        =3D       dummy_read,
                .write_rt       =3D       dummy_write,
                .ioctl_rt       =3D       dummy_ioctl,
                .ioctl_nrt      =3D       dummy_ioctl,
                .close          =3D       dummy_close,
        },
};
-------------------------------------------------------------

Please let me know how to fix this error ?


Thanks,
Pintu


>
> 5) When I install the RTDM driver (using insmod or modprobe), will it
> create the /dev node automatically like "misc" ?
>     I am registering the driver using: RTDM_CLASS_MISC
>
>
> Thanks,
> Pintu
>
>
> On Mon, Feb 26, 2018 at 10:58 PM, Greg Gallagher <greg@embeddedgreg.com> =
wrote:
>> You'd have to decide what functionality you want with respect to rt
>> and non rt for your driver.  What's confusing about the context?  The
>> gpio driver is pretty up to date, you can look at it for some
>> guidance.  Unfortunately there isn't a lot of documentation at the
>> moment, so your best bet is to look at some of the existing drivers.
>> It's easier to answer specific questions you may have about the RTDM
>> framework.  The other question is do you need at RTDM driver?  Could
>> you use the UDD framework instead?  With the UDD framework you just
>> need to support a small RTDM driver and the rest of the driver lives
>> in user space.
>>
>> -Greg
>>
>> On Mon, Feb 26, 2018 at 12:20 PM, Pintu Kumar <pintu.ping@gmail.com> wro=
te:
>>> Dear Jan,
>>>
>>> This thread is about porting a normal misc char driver to rtdm model.
>>>
>>> Anyways I got some clue by looking into rtdmtest driver.
>>> But what is confusing to me is the rtdm context_ part and the rt, nrt p=
art.
>>> How can I map this eith my exusting driver?
>>> Can I leave the context part NULL and use only rt for all other calls.
>>>
>>> Thanks,
>>> Pintu
>>>
>>> On 26 Feb 2018 7:54 pm, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 2018-02-26 12:26, Pintu Kumar wrote:
>>>> > Hi,
>>>> >
>>>> > I have a sample linux char driver which I am registering using norma=
l
>>>> > misc_register/deregister function.
>>>> > In this driver, I have used, open, read, write, ioctl, release syste=
m
>>>> > calls.
>>>> >
>>>> > Now I wanted to convert this driver to RTDM interface and compare it=
.
>>>> > Later I wanted to add some more use cases related to interrupt
>>>> > processing by connecting some external peripheral.
>>>> >
>>>> > Firstly, please guide me how to easily convert an existing linux cha=
r
>>>> > driver to RTDM model.
>>>> >
>>>>
>>>> Conversion of existing Linux UART drivers to RTDM is not straightforwa=
rd
>>>> as the former relies on a larger hierarchy of Linux drivers, starting
>>>> with the tty core over the serial core and possibly some chip
>>>> abstractions (8250). RTDM, as you can see from the existing drivers in
>>>> kernel/drivers/serial, is rather compact and does not come with that
>>>> infrastructure, primarily as it has a confined use case. Best is to
>>>> study those drivers, use one as template and replace the required
>>>> hardware accesses.
>>>>
>>>> Jan
>>>>
>>>> --
>>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>>>> Corporate Competence Center Embedded Linux

