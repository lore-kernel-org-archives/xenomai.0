Message-ID: <46697391.4080006@domain.hid>
Date: Fri, 08 Jun 2007 17:19:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<1753.194.254.210.7.1181246882.squirrel@domain.hid>
In-Reply-To: <1753.194.254.210.7.1181246882.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4950FA6BBC0DBC78D73133AC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] real time task disapears... memory problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: desvages@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4950FA6BBC0DBC78D73133AC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

desvages@domain.hid wrote:
>> desvages@domain.hid wrote:
>>>> What kind of statistics would you precisely need? And where would yo=
u
>>>> need it, means where is your scheduler located, what API does it use=
?
>>> I need execution time (and not response time). A patch for this has b=
een
>>> create by a former student (now Doctor David Robert) working before m=
e.
>> Hmm, the patch looks like it consequently reimplements existing runtim=
e
>> statistics instead of reusing them as a foundation...
>>
>> Anyway, I think we could discuss some API extension of Xenomai (for
>> native, probably via rt_task_inquire). Likely we would keep this repor=
t
>> optional, ie. make it return -1 or so if CONFIG_XENO_OPT_STATS is off.=

>> Tracking stats is not as costly as other instrumentations, but it's al=
so
>> not free. If you are interested, let us know. It won't be a one-liner,=

>> but it doesn't look like it has to be as invasive as your approach.
>=20
> It can be interesting to have something like that. My tutor will probab=
ly
> explain better than me what could be the best. I let him open a new top=
ic
> on this patch.
>=20
>>> You can find it enclosed with this mail. Anyway the problem doesn't c=
ome
>>> from this patch, it appears also with vanilla xenomai.
>> OK.
>>
>>>> Primarily code. We need your code that demonstrates the weird
>>>> behaviour.
>>>> If you patched Xenomai in any way, that patch would be required as w=
ell
>>>> of course.
>>> I have reduced the size of the code to the thing that is not working.=

>>> You
>>> can find it enclosed.
>>> The main program creates a task that calls the gsl_qp function (a
>>> quadratic solver).
>>> The problem appends during the call of ql0001_. If I remove this call=
,
>>> it
>>> works. I if keep it, the task disapears without any error (I only see=

>>> that
>>> in /proc/xenomai/stat ).
>> This sounds like some fault is triggered and your program simply
>> terminates on report of the same ("Hey, if I add that printf, my progr=
am
>> stops. What's wrong with printf?" -- You can't imagine how often I
>> already heard this. ;) ).
>>
>>>> BTW, did you already try to attach gdb to your disappearing process?=

>>>> Maybe it can catch what makes it terminate.
>>> I have tried without success, but I don really know how to use it in
>>> that
>>> way...
>> You should compile it with "-g", start it with "gdb <your program>" (o=
r
>> the graphical front-end "ddd"), simply let it "run" and wait what gdb
>> reports. It should really say /something/.
>=20
> Yes I only know how to use ddd in fact, and the -g flag is used at comp=
ile
> time. And with ddd, no bug is found... I don't catch anything. The prob=
lem
> only appears when I launch the program  in console mode.
> The thing I didn't really know how to use id the attach command of gdb,=

> that I have read on the web it can catch errors on program launched fro=
m
> outside gdb. Am I wrong ?
>=20
>> I can't help anyway, some files are missing, at least gsl/gsl_matrix.h=
=2E
>> If I shall have a look, I really need a smaller test-case, only
>> including Xenomai interaction.
>>
>=20
> It's a mistake, I forgot to remove this unuseful include line. I have
> tried to reduce the program at the minimum (some heap data allocation w=
ith
> random values, and a call to the optimizer function that cause the
> termination of the task). Normally you can remove this include, and the=
re
> will only stay xenomai calls...
>=20
>>> My config: (I have install the last availlable xenomai since last mai=
l)
>>> - Linux kernel : 2.6.20.3
>>> - xenomai : 2.3.1
>>> - Adeos : 1.7-03
>>> - Laptop compact Evo N600c Pentium 3M 1.2Ghz
>>>
>>>> .config, Xenomai version, and I-pipe version can be helpful too.
>>> .config is enclosed (DentiX231)
>>>
>>>
>>>> Jan
>>> Thanks for your help
>>>
>>> Arnaud DESVAGES
>>>
>> Jan
>=20
> Hope these new information will help to solve it.
>=20

=46rom my kernel console after running your program for a few seconds:

Xenomai: watchdog triggered -- killing runaway thread 'MyAlarmServer'

Previously, "rt_alarm_wait" was printed on the console, thus gsl_qp()
likely entered some infinite loop. You have the watchdog enabled as
well, so you should see the same effect, right?

Jan


--------------enig4950FA6BBC0DBC78D73133AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaXORniDOoMHTA+kRAvIbAJwOdtbU1M+VDybxIL8AZW12zv9kJACfaLtg
nkF9tqK+xuYzHlfcuWpT848=
=lzxS
-----END PGP SIGNATURE-----

--------------enig4950FA6BBC0DBC78D73133AC--

