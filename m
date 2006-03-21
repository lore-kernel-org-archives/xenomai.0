Message-ID: <44203051.4080400@domain.hid>
Date: Tue, 21 Mar 2006 17:56:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up - SOLVED
References: 00603201434.15258@domain.hid>
	<200603201434.15258@domain.hid>	<441ED657.1080405@domain.hid>
	<200603201901.3123@domain.hid>	<441F3476.1080003@domain.hid>
	<200603211503.22918@domain.hid> <442018FE.3020906@domain.hid>
	<442029CF.8030709@domain.hid>
In-Reply-To: <442029CF.8030709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2FA4B5B08628BD2932529ED7"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FA4B5B08628BD2932529ED7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Petr Cervenka wrote:
>>
>>> The problem was in my calling "RT" task. I forgot to switch the new
>>> created task to PRIMARY MODE, because I didn't know it's neccessary.
>>
>>
>> As Philippe said, it isn't usually required - with exceptions. Let me
>> first sketch the standard situation: You registered a read_rt handler
>> with your device, but no read_nrt. If your application now calls
>> rt_dev_read (or just read() for the POSIX skin) from the "wrong"
>> context, RTDM will detect the missing _nrt handler and trigger an
>> automatic switch to primary mode (and vice versa). So, no need for
>> manual switching in the standard case.
>>
>> But if you had registered handlers for both contexts, RTDM will always=

>> invoke the one for your current mode.
>=20
> I wonder if marking the call as "conforming" instead of leaving it to
> the current domain would make such handling more intuitive? RT threads
> would automatically switch to primary before always going to the _rt
> routine, while plain Linux tasks would just go to the _nrt one. Am I
> off-base wrt RTDM's logic here?

Its the difference between a RT thread issuing some service request
during its init phase (where it may not need hard guarantees, rather
wants to save short RT resources) and from inside its critical loop
(where no mode switch is desired). The second case would be ok with
"default-to-RT", but the first one would require to move the job into a
plain linux thread in order to address the _nrt variant of the invoked
service.

A concrete example: RTnet can create sockets with strict RT guarantees.
In case the socket creation is invoked from primary mode, the required
buffers for the socket are taken from a limited, user-tuned global pool.
But the standard, far more convenient case is that socket creation does
not have to happen in RT. In this case we can allocate the buffers from
Linux. This may lead to swapping or may even fail if the system is
generally low on memory. But that's non-RT. An RT task can now select
the allocation strategy by setting its execution mode either to primary
or secondary.

Selecting the strategy via function arguments may appear as a better
way, but this cannot easily be done where conformance to existing APIs
(like POSIX) is desired.

Jan


--------------enig2FA4B5B08628BD2932529ED7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIDBRniDOoMHTA+kRAsw6AJ9R5F/YxVF0uQRMewqBmqYJmEt5tACcDqOB
DbtTxFEb97O1uijQyyh/Foo=
=8441
-----END PGP SIGNATURE-----

--------------enig2FA4B5B08628BD2932529ED7--

