Message-ID: <4634D43D.3070800@domain.hid>
Date: Sun, 29 Apr 2007 19:22:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f10l2a$rdk$1@domain.hid> <463457A0.7030008@domain.hid>
	<4634B1DA.4040705@domain.hid>
In-Reply-To: <4634B1DA.4040705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5E71FFCBC90A65550516C7F2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] very simple example for rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E71FFCBC90A65550516C7F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Jan Kiszka wrote:
>> trem wrote:
>>  =20
>>> Hi
>>>
>>> I've written a very simple example for rtdm. And I would be pleased t=
o
>>> get a feedback about it. You can found it here :
>>>
>>> http://zarb.org/users/svn/trem/trem/kernel/xenomai/rtdm/
>>>
>>>    =20
>>
>> Looks good and (almost) clean. A few remarks and some suggestion:
>>
>>  o Use kernel coding style for the driver (linux/scripts/Lindent +
>>    manual tweaking)
>>
>>  =20
> I don't know this kernel coding style for driver. I only know kernel co=
ding
> (Documentation/CodingStyle). But I'll apply this coding style as soon a=
s
> I found them.

That script should actually implement the documented style.

>>  o Put your driver under RTDM_CLASS_EXPERIMENTAL, TESTING is for
>>    benchmarks and regression test drivers. And you don't need
>>    rttesting.h.
>>
>>  =20
> yes, done.
>>  o As RTDM is mainly about "RT", why not switching to .read_rt and
>>    .write_rt? That means of course creating a shadow thread in
>>    read_simple_rtdm.
>>
>>  =20
> I supose that it needs to add a rt task in read_simple_rtdm,
> and all read/write will be done in this task. My goal was to
> do a as simple as possible example, but this idea add some
> code. Is this added code really usefull for a simple example ?

Well, the complication consists of a rt_task_shadow() in
read_simple_rtdm's main. But as I said later, you may also come to this
topic incrementally.

>=20
>>  o Once you are real-time with read/write, you could demonstrate
>>    synchronisation. One FAQ is "How do I wait with my application on
>>    something inside a driver?" You could do rtdm_sem_up on write and
>>    rtdm_sem_[timed]down on read.
>>
>>  =20
> Same answer that former. I prefer to keep a really simple example.
>> Alternatively:
>>
>>  o What about creating a small series of RTDM examples, consisting of
>>    two demos so far: the first one a reduced version of you current
>>    code, just showing device registration and handler invocation, the
>>    second one about read/write and synchronisation. And if you feel li=
ke
>>    doing more, one could certainly continue this series with further
>>    aspects...
>>
>>  =20
> Could you stop to read my mind ? ;)

Oops, sorry, couldn't resist.

> I like this idea, and I'm ready to work on a series of example.
>=20
> I propose to write an example per concept (synchronisation, task, clock=
, ....).
> Of course, each example should have a lot of comment that explain every=
thing.
> With the idea, that the series could be used as a tutorial.

Perfect! That's what I had in mind as well.

>=20
>> Are you interested that we merge your example(s) into the Xenomai repo=
s
>> (examples/rtdm/driver-api)? I would welcome this and support your effo=
rt!
>>
>>  =20
> I think it's the logical behaviour of the previous question (and answer=
).
> So if you think that this example is good enough, I'll be pleased to se=
e
> it added in the repository.

Then please post your demo in form of a patch against Xenomai trunk. You
could pick a regular naming scheme for driver and userspace sources
(e.g. "tut01-sceleton-drv.c" and "tut01-sceleton-app.c"), put them into
the driver-api folder, and extend the Makefile. See the wiki on how to
generate patches [1].

TiA for your effort!
Jan

[1] http://www.xenomai.org/index.php/Xenomai:Contributing_Patches


--------------enig5E71FFCBC90A65550516C7F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGNNQ9niDOoMHTA+kRAjtGAJ9qr/MEr5pXLwTehc9y5JDoIXrwPwCaAt4G
jobrFDi0n3LVdBqrsMkM2pk=
=R0rb
-----END PGP SIGNATURE-----

--------------enig5E71FFCBC90A65550516C7F2--

