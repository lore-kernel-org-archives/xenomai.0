Message-ID: <46697496.9040307@domain.hid>
Date: Fri, 08 Jun 2007 17:24:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>
	<20070608150953.3095d7bd@domain.hid>
In-Reply-To: <20070608150953.3095d7bd@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2588EDC12F55054098A1C64A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2588EDC12F55054098A1C64A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Fri, 08 Jun 2007 13:20:11 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>> Daniel Simon wrote:
>>> On Thu, 07 Jun 2007 19:44:47 +0200
>>> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>
>>> Hello, opening a new thead forking from the one opened yesterday by A=
rnaud
>>> Desvages
>> I moved the thread to xenomai-core, hope you don't mind.
>=20
> OK,  I guess it is the right place
> [...]
>>> Our goal is computing the accumulated cost of some selected real-time=
 tasks
>>> to get an image of the  cpu load.
>>>
>>> What we need is a record of  the accumulated execution time of the
>>> rt_tasks (not the response time, hence the instants when the task is
>>> preempted or suspended must not be counted).
>>> This record must be accessible at any time, either from the calling
>>> task or by another one. =20
>>>
>>> Our current patch only does that for tasks running in primary mode (a=
nd
>>> moreover the measure seems not correctly updated for the calling
>>> task record). =20
>>>
>>> Thus we would be very happy to get an improved instrumentation api.
>>> I understand that  xnstat_runtime_update() handles the measure we nee=
d?=20
>> It was designed to collect precise runtime statistics to be displayed =
in
>> /proc/xenomai/stat. We would just have to keep a total counter for eac=
h
>> task as dumping /proc resets the statistics ATM.
>>
>>> Making it available, e.g.  via a rt_task_inquire call, would be great=
!=20
>> Well, the best (=3D=3Dmost comfortable :o) ) way from my POV would be =
if you
>> could try rebasing your work on your own first. Questions, even on min=
or
>> details, are always welcome, review on patches will be provided. Shoul=
d
>> be no problem to get this into Xenomai 2.4.
>>
>> The rough to-do list would be:
>>
>>  o add some persistent runtimer counter to xnthread::stat and maintain=

>>    it
>>  o introduce an xnpod service (inline function) to obtain it (let that=

>>    thing return [0..LONGLONG_MAX] when stats are available, -1
>>    otherwise)
>>  o export the runtime via struct rt_task_info, maybe also the task sta=
rt
>>    time
>>
>> Jan
>>
> I am afraid that it is far beyond my own programming capabilities, and =
I have no
> longer skilled enough students at hand...
> Anyway there are some highly skilled (and overloaded) engineers around,=
 i'll try
> to hire one of them!

Any support is welcome, offers still stand!

Damn, meanwhile I started thinking about this more than I wanted. So,
whoever will implement it, a few more remarks/suggestions:

- Considering the existing xnthread:stime and its usage (I didn't found
  a place), I would say just add another xnstat_runtime_t to
  xnthread::stat for life-time statistics and delete stime.

- Note that migrating life-time stats between CPUs requires rebasing the
  thread start time properly.

- And then I think we could also dump the life-time CPU usage based on
  that new data in /proc/xenomai/stat. Would be a nice test besides the
  native API extension... :->

Jan


--------------enig2588EDC12F55054098A1C64A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaXSWniDOoMHTA+kRAs+nAJ9s7OXtuqP/e9iPuFiEUeblTSox/ACfX6pZ
IoIynXVYCInFsdm7NTy4s4Q=
=RYXh
-----END PGP SIGNATURE-----

--------------enig2588EDC12F55054098A1C64A--

