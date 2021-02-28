MIME-Version: 1.0
References: <CAFZ-hKipbe==Ca9FP5sbzO2QCamBp4vCbD3hfztcjV6-c_LF6A@mail.gmail.com>
 <CALLqZ8Qef6bxFp8oHbeGcujE_rXcrSePDbLsk=0hW6=+7fitAQ@mail.gmail.com>
 <CAFZ-hKgK8OhXObh+sSuUb7UQn5YsPPs=CNGc3J9u8uyb84vYHA@mail.gmail.com>
In-Reply-To: <CAFZ-hKgK8OhXObh+sSuUb7UQn5YsPPs=CNGc3J9u8uyb84vYHA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 28 Feb 2021 08:11:11 -0500
Message-ID: <CALLqZ8Tjo+GdjKjBsDSMd3N_RaYqhyUxf+Cj7hb07jEh4suhyw@mail.gmail.com>
Subject: Re: RTDM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Sun, Feb 28, 2021 at 4:59 AM Leandro Bucci <guestleandro11@gmail.com>
wrote:

> thanks for the reply, I'm a newbie in this field.  So if another device i=
s
> already using the Raspberry serial, it is possible that this is the cause
> of not having the rtser0 device.  maybe you could help me understand how =
to
> unload the drivers?
>
> Il dom 28 feb 2021, 02:22 Greg Gallagher <greg@embeddedgreg.com> ha
> scritto:
>
>>
>>
>> On Sat, Feb 27, 2021 at 7:44 PM Leandro Bucci via Xenomai <
>> xenomai@xenomai.org> wrote:
>>
>>> hello everyone, after installing xenomai on the Raspberry and inserting
>>> the
>>> kernel module related to the serial, in the folder / dev / rtdm / I don=
't
>>> have the rtser0 device.  How is it possible?
>>>
>> It=E2=80=99s possible that the device isn=E2=80=99t listed or enabled in=
 the device tree
>> or the device is in use by another driver. If it=E2=80=99s in use by ano=
ther driver
>> you=E2=80=99ll have to unbind that driver and then the serial driver sho=
uld load.
>> This is all assuming that the device is properly configured in the devic=
e
>> tree.
>>
>> Thanks
>>
>> Greg
>>
>
This link is fairly dated, but it helped me get started with rtdm and
serial drivers. Take a look and we can try and fill in the missing pieces
to get you going.

https://wiki.emacinc.com/wiki/Xenomai_RTSerial

Greg

>
