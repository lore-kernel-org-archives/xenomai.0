Message-ID: <443CB0F7.9060503@domain.hid>
Date: Wed, 12 Apr 2006 09:49:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
References: <1143612388.32703.257789950@domain.hid>	<442A7D19.2000009@domain.hid>	<1143694058.30209.257882137@domain.hid>	<442C46EC.6000605@domain.hid>	<1143790982.14016.257982746@domain.hid>	<442CFCA3.4070704@domain.hid>	<17453.19513.723459.198259@domain.hid>	<1144724767.27088.258799393@domain.hid>	<17467.39989.698322.9385@domain.hid>
	<1144803396.21432.258890893@domain.hid>
In-Reply-To: <1144803396.21432.258890893@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0011FD8CDA30DE71D1921FBC"
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
To: Saul <xeno@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0011FD8CDA30DE71D1921FBC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Saul wrote:
> Gilles Chanteperdrix wrote:
>>  > >  > > I thought SMI was supposed to increase latencies, but I only=

>>  > >  > > see latencies < 60us at any load, unless I start video
>>  > >  > > capture. Does the latency test absolutely rule out SMI as
>>  > >  > > the cause?
>>  > >  >
>>  > >  > Not really, e.g. if the video capture device is USB-attached,
>>  > >  > then SMI could possibly remain in the picture.
>>  > >
>>  > > I have used the bttv driver with xawtv or mythtv and nvidia
>>  > > proprietary drivers on a dual pIII machine running latency and
>>  > > the maximum latency was far less than 100 us. What produces large=

>>  > > spots, however, is switching virtual terminals or changing
>>  > > resolution. Doesn't xawtv change resolution for full screen mode
>>  > > ? Did not you use the 768x576 modeline hack ?
>>  >
>>  >
>>  > The video capture is not USB, it's a PCI card. Since I don't see
>>  > poor latencies I'm guessing my problem is *not* SMI related.
>>
>> The latencies above 100us that you observe when starting video capture=

>> are abnormal. I was suggesting that these latencies are not due to
>> video capture but to the fact that xawtv change resolution. Big
>> latencies when switching virtual terminal are a well-known issue, not
>> related to SMI. So my question was: is xawtv configured on your
>> machine to change resolution when starting capture ?
>=20
> Oh, well xawtv starts up in a window and does not change the screen
> resolution. The large latencies occur during program startup. I
> have seen no other program produce poor latencies in the latency
> test program.
>=20

There is a way to narrow down your issue: apply the ipipe latency tracer
patch on top of your current Xenomai kernel, switch tracing on in the
config (ipipe feature), and recompile the kernel. Then you should run
the latency test with the -f parameter.

After hitting a high latency, grab the content of
/proc/ipipe/trace/frozen. This back-trace is taken always for the
highest latency the test tool measured.

You may want to play with /proc/ipipe/trace/back_trace_points (even
belatedly), or .../verbose to see more details. Look for high delays
before or after the timer interrupt - or post a (packed) version of the
trace to the list.

Jan


--------------enig0011FD8CDA30DE71D1921FBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPLD3niDOoMHTA+kRAqL8AJ0QaCDHaUy3ledZEL9ze0jDfbpqggCdF+pG
mQNlZEUoJaPWinzoqKi496o=
=t8nH
-----END PGP SIGNATURE-----

--------------enig0011FD8CDA30DE71D1921FBC--

