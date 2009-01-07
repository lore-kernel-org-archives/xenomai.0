Message-ID: <4964BB85.80806@domain.hid>
Date: Wed, 07 Jan 2009 15:26:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1231163752.49621168d278c@domain.hid>
	<49621EF0.9050604@domain.hid> <4963C4BA.1080706@domain.hid>
In-Reply-To: <4963C4BA.1080706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_printf and file writing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Antoine Nourry wrote:
> Gilles Chanteperdrix a =E9crit :
>> This is what rt_printf does. So, maybe you do not see anything because=

>> your real-time task is running all the time and does not let linux run=
?
>>
>>  =20
> Yes, i did not try but this is the case (concerning my RT task) and may=
=20
> be the answer, thanks again.
>=20

Well, don't do that, you have to let linux run from time to time,
otherwise you risk crashes or other problems.

P.S: do not forget to CC the mailing list when answering.

--=20
					    Gilles.


