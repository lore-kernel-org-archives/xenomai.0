Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
	<1243374524.22014.74.camel@domain.hid>
	<9c789a000905261525q45cbaa3ag25855befde1cb130@domain.hid>
	<9c789a000905261531m67dee7dah9740d825cce04cbc@domain.hid>
	<9c789a000905261535v56d5ac5i4fa1a41f4e678849@domain.hid>
	<9c789a000905271447i3998c3d3xf5ce93d1d8783031@domain.hid>
	<72cf3fb0905272338s6ef295fch9239989091ac85ca@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 04 Jun 2009 02:23:08 +0200
In-Reply-To: <72cf3fb0905272338s6ef295fch9239989091ac85ca@domain.hid>
	(Alexis Berlemont's message of "Thu\,
	28 May 2009 08\:38\:46 +0200")
Message-ID: <871vq0kftf.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Alexis Berlemont <berlemont.hauw@domain.hid> writes:

> Hi,
>
> On Wed, May 27, 2009 at 11:47 PM, Cristian Axenie
> <cristian.axenie@domain.hid> wrote:
>> Hi!
>>
>> Without no modiffications (just some printks) I've got a new trace point=
ing
>> that the problem is at another location :
>>
>> and the location from the kernel dissasembly points to :
>>
>> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/dri=
vers/xenomai/comedi/transfer.c:317
>> c02399d8:=C2=A0=C2=A0=C2=A0 38 00 00 00 =C2=A0=C2=A0=C2=A0 li=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 r0,0
>> c02399dc:=C2=A0=C2=A0=C2=A0 60 00 ff ff =C2=A0=C2=A0=C2=A0 ori=C2=A0=C2=
=A0=C2=A0=C2=A0 r0,r0,65535
>> c02399e0:=C2=A0=C2=A0=C2=A0 81 23 00 08 =C2=A0=C2=A0=C2=A0 lwz=C2=A0=C2=
=A0=C2=A0=C2=A0 r9,8(r3)
>> c02399e4:=C2=A0=C2=A0=C2=A0 81 69 00 1c =C2=A0=C2=A0=C2=A0 lwz=C2=A0=C2=
=A0=C2=A0=C2=A0 r11,28(r9)
>> c02399e8:=C2=A0=C2=A0=C2=A0 7f 8b 00 00 =C2=A0=C2=A0=C2=A0 cmpw=C2=A0=C2=
=A0=C2=A0 cr7,r11,r0
>> c02399ec:=C2=A0=C2=A0=C2=A0 41 9e 00 1c =C2=A0=C2=A0=C2=A0 beq-=C2=A0=C2=
=A0=C2=A0 cr7,c0239a08 <comedi_request_irq+0x48>
>>
>>
>> Do you have any idea what is the source for this random erroneous behavi=
our
>> ?
>
> Ok. Thanks, I will have a look at that location. By the way, I think
> there was another mistake (I made) in the attach procedure
> (comedi_init_drv() called twice).
>
> But do not expect any git update today, I am unavailable until tonight.

I updated my git repository (comedi branch). Could you test it?

Alexis.

