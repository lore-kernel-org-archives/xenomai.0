From: "Sebastien DI MERCURIO" <sebastien.di-mercurio@domain.hid>
References: <3FA3B82E3C8A4CAABABE6EBABF2FA4B5@domain.hid>
	<498C4DB1.3010206@domain.hid> <498C50CC.6060307@domain.hid>
Date: Fri, 6 Feb 2009 16:59:30 +0100
Message-ID: <7DACB4C0013C47B4B99BA43FC7FA6832@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <498C50CC.6060307@domain.hid>
Subject: Re: [Xenomai-help] How to check task activation ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Jan Kiszka' <jan.kiszka@domain.hid>, rpm@xenomai.org
Cc: xenomai@xenomai.org

I have took a look at LTTV and the tool may fulfill my needs.

Thank you for the information.

-----Message d'origine-----
De : Jan Kiszka [mailto:jan.kiszka@domain.hid
Envoy=E9 : vendredi 6 f=E9vrier 2009 16:02
=C0 : rpm@xenomai.org
Cc : Sebastien DI MERCURIO; xenomai@xenomai.org
Objet : Re: How to check task activation ?

Philippe Gerum wrote:
> Sebastien DI MERCURIO wrote:
>> Hello,
>> =20
>> Is there a way to get task scheduling log in xenomai ? Something like =

>> a log in /proc/xenomai, telling which task was activated at which=20
>> time, and then which other task was activated .... would be fine?
>>
>=20
> No. You can do it yourself using the task callouts in kernel space=20
> (namely TSWITCH). If you are running on top of the VxWorks skin, then=20
> the taskHookLib is available from kernel space. If you are running on=20
> top of the native API,
> rt_task_add_hook() is an equivalent. The idea would be to create a=20
> small module using the native API in kernel space as well, that=20
> registers a TSWITCH scheduler hook. The hook routine would emit a=20
> record via a message pipe (RT_PIPE) for each event, which a plain=20
> Linux process would collect by reading on the user-space end of the =
pipe.
>=20
> Note: this will obviously cause overhead.
>=20
> The other option is to either use LTTng or the I-pipe tracer, but you=20
> would collect a lot of data, aside of the TSWITCH events. YMMV.
>=20
>> Other point: is there some kind of monitoring tool (a bit like=20
>> windriver
>> Windview) working on xenomai ?
>=20
> No.

LTTV from the LTTng project can serve as such, though the Xenomai events =
are
not graphically visualized. It's unclear if we will ever see this for =
LTTV
as there is now activity towards an Eclipse plugin for LTTng which will
probably be the better place for extensions.

Jan

--
Siemens AG, Corporate Technology, CT SE 2 Corporate Competence Center
Embedded Linux


