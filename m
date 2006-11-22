Message-ID: <45644D39.10007@domain.hid>
Date: Wed, 22 Nov 2006 14:14:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] What returns rt_task_self in
	relation	to	rt_task_create
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>	
	<45643CC4.1000201@domain.hid> <1164199940.5006.270.camel@domain.hid>
In-Reply-To: <1164199940.5006.270.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA92176F00373968798E3F790"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA92176F00373968798E3F790
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-11-22 at 13:04 +0100, Jan Kiszka wrote:
>> M. Koehrer wrote:
>>> Hi all,
>>>
>>> I have a simple question concerning the Xenomai native API:
>>> According to the API documentation, rt_task_self returns the=20
>>> address of the caller's task descriptor.
>>> I have now written the following (simple application):
>>> ---------- START ----------
>>> #include <stdio.h>
>>> #include <sys/mman.h>
>>> #include <native/task.h>
>>>
>>> RT_TASK task_desc;
>>>
>>> void mytask(void *cookie)
>>> {
>>>     RT_TASK *tsk =3D rt_task_self();
>>>     printf("rt_task_self  %p\n"
>>>            "task_desc     %p\n", tsk, &task_desc);
>>> }
>>>
>>> int main(void)
>>> {
>>>     mlockall(MCL_CURRENT|MCL_FUTURE);
>>>
>>>     rt_task_create(&task_desc, "mytaskname", 0, 80, T_JOINABLE);
>>>     rt_task_start(&task_desc, &mytask, NULL);
>>>
>>>     rt_task_join(&task_desc);
>>>
>>>     return 0;
>>> }
>>> ------------ END -----------
>>>
>>> I expect now that rt_task_self() returns exactly the address of the t=
ask_desc.
>>> However, a different address is returned.=20
>>> The output of the application from above is:
>>> rt_task_self  0x804a050
>>> task_desc     0x8049878
>>>
>>> How are those addresses related - how can I find out the descriptor a=
ddress=20
>>> used for rt_task_create() at runtime?
>> The documentation is not precise enough here: what you obtain from
>> rt_task_self is /some/ task descriptor for the currently running task,=

>> it is not a reference to the same piece of memory containing the task
>> descriptor. Check the library implementation for further insights.
>>
>=20
> A descriptor should always be seen as a reference to an object, not as
> the object itself. Said differently, there is no such thing as a
> main/unique/specific descriptor for any given object. The doc says
> exactly that: you get a valid descriptor to the task by calling
> rt_task_self(), but nothing says that this ought to be the unique way o=
f
> referencing it.=20

The doc talks quite a lot about "_the_ task descriptor address" which
/may/ suggest to the reader that there is only one address. That this
cannot be the case becomes obvious when considering user/kernel or
cross-process usage. Still, clarification at some point can help to
avoid any future misinterpretation.

Suggestion (rt_task_self):

"Return the address of a descriptor for the current task.

Note: The returned descriptor address does not relate to the descriptor
address passed to rt_task_create or similar services."

Jan


PS: Who's supposed to free the descriptor allocated by rt_task_self?
Would some check for pthread_getspecific(__native_tskey) + free() on
task self-destruction make sense? Will not catch all cases, I know.


--------------enigA92176F00373968798E3F790
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZE05niDOoMHTA+kRAlLIAJwN+cCenEE3u5iPUMgQ1wANsMY4eACggz9p
Z+DsTn4aI/Pni3KK6SNiq5M=
=8YFI
-----END PGP SIGNATURE-----

--------------enigA92176F00373968798E3F790--

