Message-ID: <4821A23A.9070508@domain.hid>
Date: Wed, 07 May 2008 14:36:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <482060A7.70809@domain.hid>	<2ff1a98a0805060650he46466u88dc82fc1567173c@domain.hid>	<482170A6.60806@domain.hid>
	<2ff1a98a0805070208yc2a5836o288e0fa65100586@domain.hid>
In-Reply-To: <2ff1a98a0805070208yc2a5836o288e0fa65100586@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_pipe_delete buggy
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Wed, May 7, 2008 at 11:04 AM, St=E9phane ANCELOT <sancelot@domain.hid>=
 wrote:
>>
>>
>>  Gilles Chanteperdrix a =E9crit :
>>
>>  On Tue, May 6, 2008 at 3:44 PM, St=E9phane ANCELOT <sancelot@domain.hid=
> wrote:
>>
>>
>>  Hi,
>>  rt_pipe_delete in user space context was working fine in my app in xeno
>>  2.1.2 using the same call in xeno 2.4.2 crashes the application.
>>  Any idea ?
>>
>>  Please only report a bug if it happens with the latest stable release.
>>
>>
>>  I was a little bit succinct about problem description, here is a comple=
te
>> description regarding v2.4.2 :
>=20
> Please test your code with v2.4.3.
>=20

Yes, you want to do that. This bug has been fixed in 2.4.3.

--=20
Philippe.

