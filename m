Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jun 2010 16:47:14 -0400
Message-ID: <6FCCA913376DD7488F4139A4D11B8F4801384586@domain.hid>
In-Reply-To: <4C193692.2080309@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F4801384570@domain.hid>
	<4C193692.2080309@domain.hid>
From: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Subject: Re: [Xenomai-help] Shared memory and fstat()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles,

>-----Original Message-----
>From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
>Sent: Wednesday, June 16, 2010 4:40 PM
>To: Herrera-Bendezu, Luis
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai-help] Shared memory and fstat()
>
>
>Herrera-Bendezu, Luis wrote:
>> Hello,
>>=20
>> Can a file descriptor returned from Xenomai POSIX skin
>> shm_open()/ftruncate() used in fstat()?
>
>No.
>
>>=20
>> Value returned for st_size in the stat structure is
>> always 0 despite change of size using ftruncate().
>>=20
>> Noticed that shared memory object does not have an entry
>> on /dev/shm as regular POSIX objects. Where is it located?
>> If entry exists, can it be used to query its size?
>
>No, xenomai posix skin shared memory do not exist as=20
>filesystem objects,
>they will only be listed in /proc/xenomai/heap.
>
>Note, however, that they are only useful for sharing memory between
>kernel-space posix applications and user-space posix=20
>applications, which
>should have become rare these days. If what you are looking for is
>simply a way for sharing memory between to user-space real-time
>applications, they you can use linux regular shared memories, for which
>fstat works.
>
That is precisely what I am looking for.

Thanks,
Luis
>>=20
>> Thanks,
>> Luis
>>=20
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>=20
>
>
>--=20
>					    Gilles.
>

