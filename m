Message-ID: <4651CF99.9030405@domain.hid>
Date: Mon, 21 May 2007 18:58:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e2ceda030705160953h27bc4033q4c2ccdba6b65bc7@domain.hid>	
	<464B3BC6.1030807@domain.hid>	
	<e2ceda030705161103xf625855w3ff98016770ec37@domain.hid>	
	<464C1A30.6060306@domain.hid>
	<e2ceda030705210738o566a3011l22d6145e022bc0e2@domain.hid>
In-Reply-To: <e2ceda030705210738o566a3011l22d6145e022bc0e2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53AD79F97DD554B4AC6E587D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Getting mutex state/rt <-> non-rt communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maciek Godek <pstrychuj@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53AD79F97DD554B4AC6E587D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Maciek Godek wrote:
>> >> Locking a mutex means more, e.g. assigning a _schedulable_ Xenomai
>> >> thread as owner so that one can raise its priority if a higher thre=
ad
>> >> contents for the same lock. It also means blocking if the mutex is
>> >> currently locked, also requiring Xenomai thread context.
>> >
>> > OK. But! here I think the situation is straightforward - there is on=
ly
>> > one xenomai thread and one non-rt thread. There is only one claimant=

>> > to the mutex and I can tell for sure that there won't be any more.
>>
>> "Nothing can happen, I'm running this on UP, there will _never_ be any=

>> second CPU." Kind of famous last words. It's simply weak design, and y=
ou
>> can count on someone not reading the instruction manual that defines
>> this restricted environment.
>=20
> Yeah, I bet you're right. It requires lots of knowledge to do it well,
> though.
> BTW do you know any good books on that topic? (design of real-time
> multi-task systems)

/me could only provide academic references (thick books, you know...).

>=20
>> >> > The thing is that I'm using mutices for IPC between an rt-task an=
d a
>> >> > regular linux process. The rt code is critical, but in the
>> >> > non-realtime code I can pay the cost of low latency polling to fi=
nd
>> >> > out if the realtime code has finished. (Perhaps there is a better=

>> way
>> >> > to do it? The code now looks like this:
>> >> >
>> >> > RT_MUTEX busy;
>> >> > RT_COND data_ready;
>> >> > // both are initialized (elsewhere)
>> >> >
>> >> > void realtime_thread(void *) {
>> >> >   rt_mutex_acquire(&busy, 0);
>> >> >   for(;;) {
>> >> >     rt_cond_wait(&data_ready, &busy, TM_INFINITE);
>> >> >     // here it does something critical - it actually communicates=

>> >> >     // with an external device over serial port using the famous
>> rtdm
>> >> >     // serial driver developed and maintained by Jan Kiszka.
>> >> >   }
>> >> > }
>> >> >  ...
>> >> > // there is only one thread that communicates with the realtime
>> >> > // thread above - and this code is invoked within it.
>> >> > rt_cond_signal(&data_ready);
>> >> > // now the rt-thread does something. I can estimate the upper tim=
e
>> >> limit
>> >> > // of the one iteration of that task.
>> >> > usleep(predicted_time);
>> >> > if(busy.lockcnt) {
>> >> >   // timeout - this is possible as it depends on the external
>> >> devices. Of course
>> >> >   // sooner or later the mutex will be released by the rt thread.=

>> >> > }
>> >> >
>> >> > is there any wiser way to communicate these threads?)
>> >>
>> >> Kernel or user space?
>> >
>> > User space (I wouldn't dare to call usleep from kernel)
>> > (the solution for the kernel space would also be quite interresting,=

>> > though)
>>
>> In user space, you can simply map the non-rt mutex locker on a Xenomai=

>> thread of priority 0. That means it will be scheduled with SCHED_OTHER=

>> in Linux mode and at lowest RT prio when holding the mutex (unless it
>> undergoes prio inheritance). Kernel space would have been tricky as
>> there are no shadow threads to move between both worlds.
>=20
> I read these words, but I don't get their meanings. How should this be
> done?

rt_task_shadow(&task, name, priority, flags);
(with priority =3D=3D 0)

=46rom that point on, you can safely use rt_mutex_lock and your task
quickly goes non-rt again when releasing the lock (or doing something
dumb inside the lock...).

>=20
>>
>> PS: Reply-to-all...
>=20
> OK, sorry - I've accustomed to the sort of mailing lists where there
> everything is posted to one address only. My fault.
>=20
> Maciek

Jan


--------------enig53AD79F97DD554B4AC6E587D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUc+ZniDOoMHTA+kRAmc8AJ4lwsoL2Oaaqgt/pvbyeYs9XTtlFgCfWzjb
kM5hyhDF9Dy0yEk+m+btT8g=
=vhD5
-----END PGP SIGNATURE-----

--------------enig53AD79F97DD554B4AC6E587D--

