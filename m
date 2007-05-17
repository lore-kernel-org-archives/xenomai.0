Message-ID: <464C1A30.6060306@domain.hid>
Date: Thu, 17 May 2007 11:02:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e2ceda030705160953h27bc4033q4c2ccdba6b65bc7@domain.hid>	
	<464B3BC6.1030807@domain.hid>
	<e2ceda030705161103xf625855w3ff98016770ec37@domain.hid>
In-Reply-To: <e2ceda030705161103xf625855w3ff98016770ec37@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA6633C3AB2FBA97DE99752A2"
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
--------------enigA6633C3AB2FBA97DE99752A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Maciek Godek wrote:
> 2007/5/16, Jan Kiszka <jan.kiszka@domain.hid>:
>> Maciek Godek wrote:
>> > Hi,
>> > is it obligatory to use the rt_mutex_inquire in order to get the mut=
ex
>> > state, or could I possibly use the field lockcnt from struct RT_MUTE=
X
>> > directly? (the test should be, as I believe, atomic - so should I
>> > worry?)
>>
>> UAAAH!!! Don't do this, never!
>=20
> Oh, calm down, I was just joking :D

You wouldn't bet how much code if this kind is out there - in "real" use.=
=2E.

>=20
>> Locking a mutex means more, e.g. assigning a _schedulable_ Xenomai
>> thread as owner so that one can raise its priority if a higher thread
>> contents for the same lock. It also means blocking if the mutex is
>> currently locked, also requiring Xenomai thread context.
>=20
> OK. But! here I think the situation is straightforward - there is only
> one xenomai thread and one non-rt thread. There is only one claimant
> to the mutex and I can tell for sure that there won't be any more.

"Nothing can happen, I'm running this on UP, there will _never_ be any
second CPU." Kind of famous last words. It's simply weak design, and you
can count on someone not reading the instruction manual that defines
this restricted environment.

>=20
>> > The thing is that I'm using mutices for IPC between an rt-task and a=

>> > regular linux process. The rt code is critical, but in the
>> > non-realtime code I can pay the cost of low latency polling to find
>> > out if the realtime code has finished. (Perhaps there is a better wa=
y
>> > to do it? The code now looks like this:
>> >
>> > RT_MUTEX busy;
>> > RT_COND data_ready;
>> > // both are initialized (elsewhere)
>> >
>> > void realtime_thread(void *) {
>> >   rt_mutex_acquire(&busy, 0);
>> >   for(;;) {
>> >     rt_cond_wait(&data_ready, &busy, TM_INFINITE);
>> >     // here it does something critical - it actually communicates
>> >     // with an external device over serial port using the famous rtd=
m
>> >     // serial driver developed and maintained by Jan Kiszka.
>> >   }
>> > }
>> >  ...
>> > // there is only one thread that communicates with the realtime
>> > // thread above - and this code is invoked within it.
>> > rt_cond_signal(&data_ready);
>> > // now the rt-thread does something. I can estimate the upper time
>> limit
>> > // of the one iteration of that task.
>> > usleep(predicted_time);
>> > if(busy.lockcnt) {
>> >   // timeout - this is possible as it depends on the external
>> devices. Of course
>> >   // sooner or later the mutex will be released by the rt thread.
>> > }
>> >
>> > is there any wiser way to communicate these threads?)
>>
>> Kernel or user space?
>=20
> User space (I wouldn't dare to call usleep from kernel)
> (the solution for the kernel space would also be quite interresting,
> though)

In user space, you can simply map the non-rt mutex locker on a Xenomai
thread of priority 0. That means it will be scheduled with SCHED_OTHER
in Linux mode and at lowest RT prio when holding the mutex (unless it
undergoes prio inheritance). Kernel space would have been tricky as
there are no shadow threads to move between both worlds.

Jan


PS: Reply-to-all...


--------------enigA6633C3AB2FBA97DE99752A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGTBowniDOoMHTA+kRAlg8AJoD9/kZAqeOIC8psAck4RnOxxS8UwCfWRCz
xQbDARHXQOEnnNNG6tJeX9E=
=eKpo
-----END PGP SIGNATURE-----

--------------enigA6633C3AB2FBA97DE99752A2--

