Message-ID: <4603921A.5010901@domain.hid>
Date: Fri, 23 Mar 2007 09:38:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
References: <20070322215707.232970@domain.hid>
In-Reply-To: <20070322215707.232970@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig18EC988E699124B6C92877B5"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Viktor Stark <abraar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18EC988E699124B6C92877B5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Viktor Stark wrote:
> Hello,
>=20
> I'm having a little issue with RT pipes and I was wondering if anyone c=
ould give me some pointers.
>=20
> I wrote a RT kernel module for a DAQ card. The DAQ card gets interrupts=
 every 200 us (5 kHz) and I've got a RT interrupt handler which wakes up =
a RT function (by sending an event to it). Inside that function I use rt_=
pripe_write to send some data (about 300 bytes) down to user space.
>=20
> On the user space side, I've got a real small executable which basicall=
y opens the pipe via the Xenomai registry and then reads data from it in =
a tight loop. Inside that loop I read the TSC after each write and I comp=
ute a minimum / maximum for a 10 seconds cycle. The problem is that I get=
 a maximum of about 395 us (which is 2 times 200 us approximately). On th=
e kernel side I also do timings and I am 100% sure that my function using=
 rt_pipe_write() is woken up every 200 us (+- 10 us jitter), that is no i=
nterrupts are missed.
>=20
> After further reasearch I realised that I get a maximum value every 100=
00 cycles, that is every two seconds. I don't have anything in my system =
(to my knowledge) that has such a period so I'm really confused about wha=
t could be causing this.
>=20
> I tried to have a look at pipe.c in src/nucleus and saw that the user s=
pace side is supposed to get woken up on each xnpipe_send() but I admit t=
hat I didn't quite catch all the details.
>=20
> So basically, my question is:
> If I have rt_pipe_write() writing to a pipe from a kernel module with a=
 200 us period and I have a read() in a tight loop reading from that same=
 pipe is user space, what could be the origin of the fact that sometimes =
my read() doesn't get woken up?
>=20
> It's worth to mention too, that I'm not losing any data. That is, after=
 the read which eats up 2 cycles, the next read finishes nearly instantan=
eously (within 5 us) as if only the second rt_pipe_write() woke up the us=
er space read().
> Timing illustration (time between read()'s in us): 195 | 200 | 205 | 39=
5 | 5 | 195 | 200 | 200
>=20
> My setup:
> Xenomai 2.2-rc3
> Kernel 2.6.17 (with Xenomai compiled in - ie. not compiled as modules)
> P4 3GHz - 1Gb RAM
> No APM/ACPI/CpuFreq - SMI workaround enabled.
> Tried with 2.6.19 / Xenomai 2.3 - same results.
>=20
> Thanks in advance for any pointers.

Have a look at the ipipe tracer:

http://www.xenomai.org/index.php/I-pipe:Tracer

Put a xntrace_user_freeze at the spot in your application where you
detect the misbehaviour and check the back-trace of the last few hundred
microseconds. If you don't understand what you see (the tracer's
information can be overwhelming...), feel free to post the trace.

>=20
> Keep up the good work! Xenomai just *rocks*.

Nice to hear about yet another happy user. :)

Jan


--------------enig18EC988E699124B6C92877B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA5IaniDOoMHTA+kRAmBPAJ4qnC2DSCnIqsaHbmqad4zDj/feZgCff1wr
CPoTykgKdD5xxpyv5NElP9E=
=4Gp8
-----END PGP SIGNATURE-----

--------------enig18EC988E699124B6C92877B5--

