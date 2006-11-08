Message-ID: <4551FE90.2040808@domain.hid>
Date: Wed, 08 Nov 2006 16:58:08 +0100
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] LATENCIES > 100 us or CRASH WITH X (with joints
	pieces)
References: <4551F2E5.5050200@domain.hid> <4551F62A.9030607@domain.hid>
	<4551FC33.4080208@domain.hid> <4551FDF9.1070401@domain.hid>
In-Reply-To: <4551FDF9.1070401@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

Jan Kiszka a =E9crit :
> Jean-Luc Pamart wrote:
>  =20
>> Jan Kiszka a =E9crit :
>>    =20
>>> Jean-Luc Pamart wrote:
>>> =20
>>>      =20
>>>> Hello
>>>>
>>>> I am a newbie with Xeno. My goal for the beginning of 2007 is to launch
>>>> a project for 4 french studiants : a box with Linux embedded and a usb
>>>> camera. The embedded application will analyse the movies in Real time
>>>> and lead a mobile machine with CAN-BUS.
>>>> Now i play with Xeno for my knowledge (without specific hardware) :  a
>>>> little linux installed in a usb key with a little embedded distrib
>>>>
>>>> - vanilla kernel 2.6.16 with patch for usb [.config is joint]
>>>> - Xenomai 2.1.2
>>>> - essentially BusyBox
>>>> - for xenomai : only "latency" directory and libs in usr/libs
>>>> I have checked "SMI woraround" for the kernel.
>>>> In BIOS I have UNchecked  "legacy usb".
>>>>
>>>>
>>>> my Desktop PC (a AMD ATHLON) can boot with this little vanilla kernel
>>>> and
>>>> 1/ a little embedded distrib of my own
>>>>
>>>> OR
>>>>
>>>> 2/ a complete mandrake 9.1 on a partition of a classic hard disk
>>>>
>>>> I have 2 differents problems when I lauch this :
>>>>
>>>> 1/ with the linux embedded directories on the usb key
>>>> high latency > 100 us are ok ? perhaps usb work is not compatible
>>>> with RT ?
>>>>    =20
>>>>        =20
>>> Try loading the standard USB drivers (at least uhci_hcd) if they aren't
>>> yet. Actually, I've seen boxes (granted, they were far older) where I
>>> had to switch legacy USB *on* to avoid disturbances. In any case, check
>>> carefully if you followed all tips in TROUBLESHOOTING regarding latency
>>> issues (APM, ACPI, etc.).
>>>
>>> =20
>>>      =20
>>>> 2/ with the complete mandrake 9.1 :
>>>> it crashes X after 1 or few minutes.
>>>> What is the relation between X and Xenomai ?
>>>> Is Xenomai compatible with X ?
>>>>    =20
>>>>        =20
>>> Yes, as long as X is not playing against us, e.g. by hard-disabling
>>> interrupts or doing (too) evil things on the buses. Any non-GPL driver
>>> in this game here (NVidia&Co)? Better avoid this. Also try to disable
>>> accelerated mode in your X setup to see if things improve.
>>>
>>> Jan
>>>
>>>  =20
>>>      =20
>> Ok , for the box with a vanilla kernel I will try the differents
>> possibilities. Actually i disable
>> a max of things ...
>>
>> For the box with X : the big surprise was : very goods latencies
>> (comparativeley with no X !!)
>> Why ????
>> (Before crashing)
>>    =20
>
> If it turns out to be an ACPI/APM issue, X may keep your box busier than
> plain text mode, thus avoid those latency peaks by keeping it out of
> certain sleep modes - well, an attempt to explain something I can't with
> the currently available information...
>
>  =20
>> for crashing
>> I 'll verify theses 2 points :
>> nvidia driver
>> accelerated mode  : Is it a x server setup ?
>>
>>    =20
>
> See Gilles' reply =3D> XF86Config.
>
> Jan
>
>
> PS: Don't forget to reply-to-all.
>
>  =20
OK !

=09

=09
	=09
___________________________________________________________________________=
=20
Yahoo! Mail r=E9invente le mail ! D=E9couvrez le nouveau Yahoo! Mail et son=
 interface r=E9volutionnaire.
http://fr.mail.yahoo.com


