From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Wed, 8 Feb 2006 17:35:24 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602081603.10267.lbocseg@domain.hid> <43EA37E9.8060101@domain.hid>
In-Reply-To: <43EA37E9.8060101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602081735.24478.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Em Quarta 08 Fevereiro 2006 16:26, Jan Kiszka escreveu:

>>>> ...
>>>> Jan, actually I didn't like the /dev/zero hack. If someone else is
>>>> using /dev/zero it will result in a problem... I think it would be
>>>> better to
>>>
>>> Why? It isn't an exclusive device. And I'm only invoking open/close on
>>> the original instance (which even have no handlers associated, see
>>> drivers/char/mem.c), mmap gets overloaded.
>>
>> I'm a little confused here. I noted you have made a backup of the
>> file_operations struct and private_data. So, I've concluded, wrongly, th=
at
>> those handlers would be used by every process that called that open
>> handler. But, looking at the mem.c code, I think that those data (file_o=
ps
>> and private_data) are different structs each time the user issues a call
>> to open.
>
>Yep, that's the point. Actually, I was inspired by some other mmap'ing
>driver which does a similar overloading on it's own device type.
>
>> If that is true, I don't see any problem in using your approach. But I
>> don't see neither any needs for making that backup...
>
>On first sight this is true and the backup is redundant. But it is
>cleaner to not rely on a specific kernel implementation.

But if the kernel implementation will change it won't be safer to operate t=
his=20
way... Because someone else could try to use the /dev/zero while you change=
d=20
the handlers... If this happens some day, you could change /dev/zero to som=
e=20
file descriptor or your own then.

>Instead it's=20
>saner to look at the model: I'm changing the fops without knowing what
>the open handler did, so make sure that a possible release handler can
>run. And this is also not very costly here. :)

Ok, I got your point. You mean if the driver rely on fops when releasing. O=
k,=20
I think that the approach you suggested is great. As I've said I would only=
=20
change the return of rtdm_mmap_to_user to NULL on error. Then you could add=
=20
it to RTDM...

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



