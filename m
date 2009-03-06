Message-ID: <49B1200D.7000204@domain.hid>
Date: Fri, 06 Mar 2009 14:07:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <76902d360903060146t677ab7a1y38a11273957b8c45@domain.hid>	
	<49B0F2DD.5080507@domain.hid>
	<76902d360903060341y20a45b61y1a6e484767baca80@domain.hid>
In-Reply-To: <76902d360903060341y20a45b61y1a6e484767baca80@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and reading of linux files?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Cc: xenomai@xenomai.org

Jens K=F6hler wrote:
> 2009/3/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>=20
>>  Jens K=F6hler wrote:
>>> Hello,
>>>
>>> I like to port a rtai application  to xenomai. The rtai application h=
as a
>>> user space part and a kernel module. Both communication together by r=
tai
>>> queues and a shared memory.
>>> Do I need for xenomai still queues? Or is it f.i. possible to read or=

>> write
>>> linux files from xenomai application without problems?
>> reading and writing will work, but will cause the thread which does it=

>> to switch to secondary mode (if it is a real-time thread), so it may n=
ot
>> be what you want.
>>
>> --
>>                                                 Gilles.
>=20
>=20
> Hi Gilles,
>=20
> thank you for your fast answer. I need in periodic real time task data =
from
> user space. Then I have to use a msg_queue!?

Xenomai allows real-time in user-space (as RTAI does, by the way), so
the problem is not user-space versus kernel-space, the problem is
primary mode versus secondary mode.

> How can I check if my real time task/ thread runs accidentally in secon=
dary
> mode?

See:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__task=
=2Ehtml#g915e7edfb0aaddb643794d7abc7093bf

And for an introduction on xenomai native api, see:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-=
rev-C.pdf

--=20
                                                 Gilles.


