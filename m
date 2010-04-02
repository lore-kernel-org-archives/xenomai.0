Message-ID: <4BB5348B.2070805@domain.hid>
Date: Fri, 02 Apr 2010 02:04:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9AD0DE.4020103@domain.hid>	
	<1268472523.27899.135.camel@domain.hid>	
	<4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>	
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>	
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>
	<1270159246.2418.432.camel@domain.hid>
	<4BB51931.3080307@domain.hid> <4BB523E8.705@domain.hid>
	<4BB5250F.1040409@domain.hid> <4BB52769.4080702@domain.hid>
In-Reply-To: <4BB52769.4080702@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6FEB47A9928DBAAE9189BFC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6FEB47A9928DBAAE9189BFC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Thu, 2010-04-01 at 23:54 +0200, Jan Kiszka wrote:
>>>>>> Philippe Gerum wrote:
>>>>>>> The bottom line for me, is that T_PRIMARY, as a user-space visibl=
e
>>>>>>> "feature" should be dropped at some point, and never ever conside=
red as
>>>>>>> a way to fix the RTDM syscall issue anymore. I don't mind saving =
an
>>>>>>> extra-context switch even in what I think should be _rare_ cases,=
 but
>>>>>>> this has to be done in a way that does not introduce the same kin=
d of
>>>>>>> misunderstanding the eager mode switching allowed by rt_task_set_=
mode()
>>>>>>> did in the past.
>>>>>>>
>>>>>>> Really, I'm convinced that an awful lot of people are currently r=
unning
>>>>>>> under-performing at best, or even broken applications today, beca=
use of
>>>>>>> that, thing.
>>>>>> We are not discussing T_PRIMARY here. We are discussing something =
like
>>>>>> an "rtdm_is_rt_capable()" addition for those _few_ RTDM drivers th=
at
>>>>>> actually want to provide Ianus-like services.
>>>>>>
>>>>> Yes, we do discuss of T_PRIMARY in between the lines.
>>>>>
>>>> You can take it away, and the rtdm_is_rt_capable-approach would stil=
l
>>>> work, but that without affecting existing designs.
>>> Ok. I almost regret I launched this troll. We have discussed some tim=
e
>>> with Philippe, and I agree with him that drivers which this change
>>> really broke were already broken. The only side-effect is the double
>>> switch issue, which, per-se is not that much a trouble in real-world
>>> applications. So what I propose is a special RTDM driver flag that wo=
uld
>>> somehow fix the issue for the switchtest driver, and would only be us=
ed
>>> by that driver and not exported in the rtdm headers, and of course no=
t
>>> documented.
>>>
>> No, I'm queuing rtdm_rt_capable() + a revert of the __xn_exec_conformi=
ng
>> commit now. That's way less surprising for existing drivers and still
>> does not require user land to fiddle with the mode. All can be handled=

>> at driver level (ie. in Analogy, obviously the only driver that needs =
it
>> so far).
>=20
> Because of __xn_exec_current, people have broken drivers, and user-spac=
e
> applications using T_PRIMARY as a broken way to workaround these broken=

> drivers, and by maintaining compatibility, we let them keep their broke=
n
> drivers and applications, by changing to the more natural
> __xn_exec_conforming and removing T_PRIMARY, we ask them to fix their
> drivers and applications.

Right goal, wrong approach for the reason I pointed out to Philippe:

We cannot map all kinds of driver requirements on a single
__xn_exec_current in the RTDM middle layer. RTDM has insufficient
knowledge about what the drivers will, how many RT and how may non-RT
calls they will provide and what load pattern user space will apply on
this. RTDM can only mediate based on the available information.

The T_PRIMARY issue has to be solved be removing that feature, not by
changing RTDM.

>=20
> What we are left to fix is the corner case of switchtest.
>=20

=2E..and the performance degeneration of Analogy when used with a plain
Linux tasks - part of the scenario that started this whole discussion.

Jan


--------------enigD6FEB47A9928DBAAE9189BFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1NI8ACgkQitSsb3rl5xQtawCgt3VdgljZOxcCcJcVllxdQizL
AC0An0Y/ZfVd64Qhr2k74KI+m21YnD+I
=aU8C
-----END PGP SIGNATURE-----

--------------enigD6FEB47A9928DBAAE9189BFC--

