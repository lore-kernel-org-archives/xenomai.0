Message-ID: <49FF34DF.1080802@domain.hid>
Date: Mon, 04 May 2009 20:33:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
	<49FDFCC7.6000009@domain.hid>
	<20090504072304.A7E2483420E8@domain.hid>
	<49FF08C4.40908@domain.hid>
	<20090504180134.D9D5283420E8@domain.hid>
In-Reply-To: <20090504180134.D9D5283420E8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Denk wrote:
> Dear Thomas,
>=20
> In message <49FF08C4.40908@domain.hid> you wrote:
>>>>> 1.) If I don=B4t page align the size of shared memory (multiple of
>>>>> 4096)...
>>>  The restrictions for page allignments affect the addr and offset
>>>  paraemters only. To me it seems clear that mmap() in plain Linux and=

>>>  Xenomai behave differently.
>> Sorry for not having the start of the thread. I'm not sure if it is=20
>> helpful to note that when I implemented memory mapped "device drivers"=
=20
>> for our system I had to align the address and offset to the page size =

>> before the call to mmap would succeed. That was with plain Linux and t=
he=20
>> driver also works with Xenomai.
>=20
> This is correct, and documented behaviour. And if one thinks about
> possible implementations, it just makes sense.
>=20
> But the problem that the origonal poster reported was  a  restriction
> of  the "length" parameter - his test seems to demonstrate that under
> Xenomai the legth must be a multiple of the page sise, while in plain
> Linux no such restriction exists (I can provide test  code  for  that
> case, if wanted).

All I want to hear is "yes, we ran the shm test without Xenomai, on
exactly the same kernel, on the same platform, and the shm test worked".
Because Xenomai runs plain Linux mmap under the hood and do no
particular check on the mmap length. So, the problem is either that
Linux mmap on that particular machine with that particular kernel does a
check on length, or that there is a subtle bug somewhere that I do not
want to investigate until I am usre that it is real.

--=20
					    Gilles.


