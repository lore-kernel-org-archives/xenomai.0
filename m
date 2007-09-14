Message-ID: <46EA3253.3010901@domain.hid>
Date: Fri, 14 Sep 2007 09:03:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>
	<cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>
In-Reply-To: <cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7B8B82161F25669A45DFEC2A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] too fast write to serialport?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B8B82161F25669A45DFEC2A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Eric Noulard wrote:
> 2007/9/13, Bachman Kharazmi <bahkha@domain.hid>:
>> Hi!
>> I try to print to serialport using rtdm according to: http://pastebin.=
ca/695418
>>
>> But if I don't have sleep(1) only "hello   " or similar is written to
>> the serialport.
>> But if I've sleep(1) "helloworld" is written every second as expected.=

>=20
> I'm no xenomai expert but I think
> you shouldn't write to serial device in such a tight loop:
>=20
> while(counter <100){
>         rt_dev_write(fd, myString, strlen(myString));
>        printf("%d\n",counter);
>       // sleep(1);  WITHOUT THIS SLEEP helloworld is sent on serial onc=
e.
>      counter++;
> }

The _will_ work, but the problem is that pending bytes are dropped on
rt_dev_close + the shortcoming that there is no way to synchronise on
the buffer being flushed reliably. That's a shortcoming of the current
driver (+ the serial profile spec) I trapped in myself - as the
developer of this code. :(

>=20
> because you will certainly fills the send buffer without giving a chanc=
e
> to the drive to send more data than the one that fits in the buffer
> (this heavily depends wether if the device is opened in blocking
>  or non-blocking mode)

Nope, the problem here has nothing to do with the timeout or the
blocking mode. That write will block (given a timeout > 0 or infinite)
when the software buffer (4k) is full. That's not specific in the serial
profile, and that's bad.

>=20
> FIRST of ALL you should check the return value of your function call
>=20
> rt_dev_write should return either the number of written bytes
> http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__us=
erapi.html#ge966625748b547779bb8c5385e7fb2aa
>=20
> or a negative error code:
> http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__rt=
serial.html
>=20
>=20
>> Is this some kind of limit how quickly I can write stuff on the rtser0=
?
>=20
> Yes there must be.
> Serial device are not as fast as any recent CPU.
> Beginning with the fact that you did configure the serial link at 11520=
0 bauds
> it would'nt wise to try to feed at an "average" speed that exceed this =
number.
>=20
>=20
>> How do I handle this?
>=20
> Check the return value of your rt_dev_write calls :)
>=20

Won't help here as I explained above. Still, my beer-ware was lacking
return code checks, and that is never recommendable for real code.

Jan


--------------enig7B8B82161F25669A45DFEC2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG6jJTniDOoMHTA+kRAnaGAJwKbvOu1wt0H7mGnIq31h2K2nV+ngCfaLhj
PbvW/61Hb/gPkdz3nrmWt2w=
=fZcD
-----END PGP SIGNATURE-----

--------------enig7B8B82161F25669A45DFEC2A--

