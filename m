Message-ID: <46E4E604.70607@domain.hid>
Date: Mon, 10 Sep 2007 08:36:52 +0200
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <46DE59D6.1040107@domain.hid> <1188983761.28092.278.camel@domain.hid>
In-Reply-To: <1188983761.28092.278.camel@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] pb sharing xeno heap data with std kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum a =E9crit :
> On Wed, 2007-09-05 at 09:25 +0200, St=E9phane ANCELOT wrote:
>> Hi,
>>
>> I have setted up a shared heap between a kernel module and an user space
>> app.
>>
>> However another "std" kernel model would need a ptr to some data in it .
>>
>> rt_heap are virtual adresses I suppose.
>>
>> Is there a way to give a phys pointer to the other kernel module  ?
>>
>=20
> You should rather store offsets to data from the heap start address
> instead of pointers, and compose pointers using the (base, offset) pair
> when dereferencing data within this space.

Yes, I agree, I have already done this between the  userspace and the
first kernel module. However I have no easy possibility to break the
second kernel module functions for compatibilitry reasons.




>> Best Regards
>> Steph
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help


