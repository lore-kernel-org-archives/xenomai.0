MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
Date: Tue, 26 May 2009 15:55:35 +0200
Message-ID: <72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Tue, May 26, 2009 at 12:32 AM, Cristian Axenie
<cristian.axenie@domain.hid> wrote:
>
>
> ---------- Forwarded message ----------
> From: Cristian Axenie <cristian.axenie@domain.hid>
> Date: Tue, May 26, 2009 at 1:16 AM
> Subject: Re: [Xenomai-help] Driver testing procedure ?!
> To: Alexis Berlemont <berlemont.hauw@domain.hid>
>
>
>
>
> On Tue, May 26, 2009 at 1:10 AM, Alexis Berlemont <berlemont.hauw@domain.hid=
>
> wrote:
>>
>> Cristian Axenie <cristian.axenie@domain.hid> writes:
>>
>> > Hi,
>> >
>> > I finally figured out this aspect but I still have one problem, residi=
ng
>> > in the fact that I have no comedi devices in my dev list
>> > and so I cannot ./comedi_config /dev/comedi0 nipcimio !
>> >
>> > As I see it there are no comedi devices
>> >
>> > /usr/xenomai/sbin # cat /proc/devices
>>
>> You should not look at there. This proc file lists everything but RTDM
>> devices.
>>
>> >
>> > and the list
>> >
>> > /usr/xenomai/sbin # cat /proc/comedi/devices
>> > --=A0 Comedi devices --
>> >
>> > | idx | status | driver
>> > |=A0 00 | Unused | No driver
>> > |=A0 01 | Unused | No driver
>> > |=A0 02 | Unused | No driver
>> > |=A0 03 | Unused | No driver
>> > |=A0 04 | Unused | No driver
>> > |=A0 05 | Unused | No driver
>> > |=A0 06 | Unused | No driver
>> > |=A0 07 | Unused | No driver
>> > |=A0 08 | Unused | No driver
>> > |=A0 09 | Unused | No driver
>> > /usr/xenomai/sbin # cat /proc/comedi/drivers
>> > comedi_config=A0=A0 rtcanconfig=A0=A0=A0=A0 rtps
>> > /usr/xenomai/sbin # cat /proc/comedi/drivers
>> > --=A0 Comedi drivers --
>> >
>> > | idx | driver name
>> > |=A0 00 | pcimio
>> > |=A0 01 | comedi_8255
>> > |=A0 02 | comedi_loop
>> > |=A0 03 | comedi_fake
>> >
>> > Shouldn't the specific comedi devices be generated when installing
>> > Xenomai ?
>>
>> That is common comedi behaviour. So far, the comedi drivers are listed,
>> they are available in the kernel. However, you have to attach them so as
>> to make them reachable (thanks to comedi_config).
>>
>> Once the attach will be done, you will see your driver appear in
>> /proc/comedi/devices.
>>
>> If the comedi_config did not work, the problem is here. In such case,
>> could you send the traces?
>
> The problem is that the comedi devs are not present in /dev and so when I
> run comedi config
>
> /usr/xenomai/sbin # ./comedi_config /dev/comedi0 pcimio
> comedi_config: comedi_open failed ret=3D-19
>
> Shouldn't the comedi0, comedi1... devices be created when installing Xeno=
mai
> ?

Here, we are talking about RTDM devices not common Linux /dev files.
Have a look at /proc/xenomai/rtdm/comediXX.

Consequently, your comedi_config command line should be "comedi_config
comedi0 pcimio".

Alexis.

