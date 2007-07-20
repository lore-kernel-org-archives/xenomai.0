Message-ID: <46A06886.5000703@domain.hid>
Date: Fri, 20 Jul 2007 09:47:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>	<1184746976.6562.62.camel@domain.hid>	<760425846A1BC44B8BD24361EF2E3451010D9A3F@square.bfh.ch>	<1184755654.13258.17.camel@domain.hid>
	<469FD346.4060402@domain.hid>
In-Reply-To: <469FD346.4060402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DF10DB05373E83D933E29D4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Writing from user space direct to
 IO	Ports	without mode switches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DF10DB05373E83D933E29D4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Vincent Levesque wrote:
> Hi Philippe,
>> Excepts from your code:
>>   while(!end){
>>     //switch to primary mode
>>     ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
>>
>> Damnit. I knew this particular interface was going to be misused most =
of
>> the time. In short: do ____NOT_____ switch modes manually, this is
>> useless because Xenomai syscalls do it for you, and even sub-optimal
>> because the kernel knows better when it needs it and saves you a sysca=
ll
>> when required. The T_PRIMARY bit has been solely provided for internal=

>> Xenomai purposes (some Xenomai libs have very special requirements in
>> very rare cases). rt_task_wait_period() will switch to primary mode if=

>> needed, and always leave you in primary upon return.
>>  =20
> Indeed, I was also doing the same thing. From my understanding of the=20
> docs, I assumed that manually setting a task to secondary mode was=20
> allowed and could improve performance. Take for instance a task that=20

Yes, it is allowed, but no, it doesn't improve performance.

> logs data coming from a RT_QUEUE to a file. Is there anything special=20
> that should be done to minimize the impact of the frequent mode switche=
s=20
> in such a case?

As I once requested that mode switching feature, let my clarify its only
intended use case: RTDM devices may provide different support for
certain services (open/close/ioctl etc.) depending on the caller's
context. In order to let the caller control his context cleanly (ie.
without trickery to trigger automatic switches) in case there is support
for both modes for some device service, we introduced the explicit
switch interface. Really, this is the only scenario where switching
manually makes sense with Xenomai, and it is a corner case even under RTD=
M.

In all other cases, as Philippe explained, the Xenomai core will switch
for you transparently and efficiently. That even includes RTDM devices
which only support some service in one mode. E.g., rt_dev_read will
switch the caller to primary mode if the involved driver only provides a
read_rt handler and the caller was in secondary mode.

If you want to make your mode switches efficient, design your
applications in a way that you don't interleave Linux services with
blocking Xenomai services needlessly. Means, design the loop of your
borderline thread such that it only switches once to secondary mode and
back per cycle. But it sounds like your application (minus manual mode
switches) is already designed that way.

Hope that helped to clarify the situation. Now please let us know which
sentence(s) from the doc may have misled your understanding of the mode
switching feature. Maybe we have to rephrase them.

Jan


--------------enig2DF10DB05373E83D933E29D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGoGiGniDOoMHTA+kRAsgwAJ9T+DgXz/RY8UaVgZaIYezOYRgJSACeIMJW
ScWbICheXwEdnS+5r7kuu4I=
=luCP
-----END PGP SIGNATURE-----

--------------enig2DF10DB05373E83D933E29D4--

