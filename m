Message-ID: <46EAC591.4050602@domain.hid>
Date: Fri, 14 Sep 2007 19:32:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709130245m6c73abd3tc8023237e03f70f2@domain.hid>	
	<cbe23c50709130434x127c8e86nfb061ac71555cd68@domain.hid>	
	<46EA3253.3010901@domain.hid>
	<cbe23c50709140112q160c809alc398ed1b9a502c40@domain.hid>
In-Reply-To: <cbe23c50709140112q160c809alc398ed1b9a502c40@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig52505349988AC9BB0535308C"
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
--------------enig52505349988AC9BB0535308C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Eric Noulard wrote:
> 2007/9/14, Jan Kiszka <jan.kiszka@domain.hid>:
>> Eric Noulard wrote:
>>> 2007/9/13, Bachman Kharazmi <bahkha@domain.hid>:
>>>> Hi!
>>>> I try to print to serialport using rtdm according to: http://pastebi=
n.ca/695418
>>>>
>>>> But if I don't have sleep(1) only "hello   " or similar is written t=
o
>>>> the serialport.
>>>> But if I've sleep(1) "helloworld" is written every second as expecte=
d.
>>> I'm no xenomai expert but I think
>>> you shouldn't write to serial device in such a tight loop:
>>>
>>> while(counter <100){
>>>         rt_dev_write(fd, myString, strlen(myString));
>>>        printf("%d\n",counter);
>>>       // sleep(1);  WITHOUT THIS SLEEP helloworld is sent on serial o=
nce.
>>>      counter++;
>>> }
>> The _will_ work, but the problem is that pending bytes are dropped on
>> rt_dev_close + the shortcoming that there is no way to synchronise on
>> the buffer being flushed reliably.
>=20
> I am not sure to fully understand that.
> Do you mean that the serial driver (you wrote) has currently no
> way to know if written bytes have been sent on the wire by the UART ?

That is true. The asynchronous transmitting of data was intentionally
installed, but I didn't consider to establish some interface to request
and/or synchronise on the output completion. Will think about this when
time permits.

>=20
>> That's a shortcoming of the current
>> driver (+ the serial profile spec) I trapped in myself - as the
>> developer of this code. :(
>=20
> Meaning it _could_ be done but it is not in current implementation?

Yeah, likely. One option I currently have in mind is to establish
something like RTSER_EVENT_TXDONE that is raised when he TX interrupt
fired and the software buffer is empty.

>=20
>>> because you will certainly fills the send buffer without giving a cha=
nce
>>> to the drive to send more data than the one that fits in the buffer
>>> (this heavily depends wether if the device is opened in blocking
>>>  or non-blocking mode)
>> Nope, the problem here has nothing to do with the timeout or the
>> blocking mode. That write will block (given a timeout > 0 or infinite)=

>> when the software buffer (4k) is full. That's not specific in the seri=
al
>> profile, and that's bad.
>=20
> Ok I see blocking / timeout feature is a "software" feature of the driv=
er.
>=20
> For some kind of "realtime" serial communication ones
> may need something like "synchronous" write, meaning
> driver write call should block or timeout if underlying HW is not
> able to send the provided data.

Yes, I agree, I just don't want to change the semantic of rtserial's
write service. Besides likely breaking existing apps, I don't see the
need for the change in the _common_ case. Most scenarios I saw so far
either used the real-time UART port just for reading (+ some
initialisation maybe) or they synchronised on the transmission by
waiting on a reply from the devices. The case that you just write was
yet not required, but it is a valid one. For that case, a patter of
"write to port" + "wait on TXDONE event" would be appropriate IMO.

>=20
> I hope you'll excuse me to give such approximate  [wrong] answers.
> I was trying to help, may be I should check the source code
> before trying to answer.
>=20
> Sorry about that.
>=20

No need to excuse. This misunderstanding is surely not your fault, and
this whole thread nicely uncovered some weaknesses that need to be fixed.=


Jan


--------------enig52505349988AC9BB0535308C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG6sWSniDOoMHTA+kRAhrpAJ9V0wS78f5mqYctbabuKVzMgPJA5ACePfBI
PxTo3ipp2iI4nCJe/Gv9+YY=
=I/k/
-----END PGP SIGNATURE-----

--------------enig52505349988AC9BB0535308C--

