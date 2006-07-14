Message-ID: <44B7BF28.6000500@domain.hid>
Date: Fri, 14 Jul 2006 17:58:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] handling threads within a pod
References: <44B51D2C.10508@domain.hid> <44B52214.7050009@domain.hid>	
	<44B60737.6050705@domain.hid> <1152891036.5075.35.camel@domain.hid>
In-Reply-To: <1152891036.5075.35.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0757CE261AB81E18D801FD90"
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
Cc: xenomai@xenomai.org, Khalil GHORBAL <kg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0757CE261AB81E18D801FD90
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-07-13 at 10:41 +0200, Khalil GHORBAL wrote:
>=20
>> I'll give an example to explain the issue:
>> Assuming having multiple threads in our active pod, these threads can =
be=20
>> in different states.
>> The running thread have to get the *extinfo* field of thread named=20
>> "COM_THREAD" (for example) if exists.
>>
>> All services of the nucleus need a *xnthread_t* structure to identify =

>> the thread to treat, we can't have a list or something similar to swee=
p=20
>> existing threads. All I've found is the global queue, doubly-linked an=
d=20
>> circular, which link all threads.
>> So all informations I have is the number of threads and a way to go fr=
om=20
>> one holder to another
>> without really be able to identify the thread and read the other field=
s.
>>
>=20
> Forget about extinfo; you don't need this, and it's old cruft we are
> going to kill in later versions anyway. What you need to handle
> arinc653-like temporal partitioning is something along these lines:
>=20
> struct ima380_process {
> 	xnthread_t threadbase;	/* process control block */
> 	xnholder_t ptlink;	/* link to next partition */
> 	/* ... */
> };
>=20
> struct ima380_partition {
> 	xnqueue_t procq;	/* chains ima380 processes */
> 	/* ... */
> };
>=20
> Don't refer to Xenomai's global thread queue, just manage your own
> process queues populating a partition object abstraction.
>=20
> Then use the XNHELD bit which has been specifically added as a
> suspensive condition to handle temporal partitioning. This way, XNSUSP
> remains available for suspending processes forcibly within a partition
> (suspension bits are conjunctive). IOW, only the processes pertaining t=
o
> the running partition will have the XNHELD bit cleared, others will hav=
e
> this bit set, and as such, suspended by the nucleus, which is what you
> want.
>=20
> void deactivate_partition (struct ima380_partition *pt)
> {
> 	foreach(thread in pt->procq) {
> 		xnpod_suspend_thread(thread,XNHELD,XN_INFINITE,NULL);
> 	}
> }
>=20
> void activate_partition (struct ima380_partition *pt)
> {
> 	foreach(thread in pt->procq) {
> 		xnpod_resume_thread(thread,XNHELD);
> 	}
> }
>=20
> The partition slicer can be implemented as a simple periodic timer,
> whose handler activates existing partitions in a round-robin fashion.
>=20
> FWIW, mimicking arinc653 over the nucleus is a no-brainer, so there's
> good hope for IMA380.
>=20

The way described above is certainly the preferred one for a first
approach. But I wonder if switching full schedules isn't more efficient,
scalable, and simply more "partitioned" than this O(n) method. I haven't
looked at details yet, but is there anything that may prevent such
"hard" switch ATM?

Another topic that my addiction to perfectionism brought to my mind are
partitioned timers. Anyway, once we switch whole schedules, shouldn't
those timers be switched automatically as well? Considering that a
partition switch would be triggered by a timer, one would only have to
restart the timer IRQ over the new sched to continue. In theory...

Jan


--------------enig0757CE261AB81E18D801FD90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEt78oniDOoMHTA+kRAumXAJ46mPZeiLDQLMhXxLcFTk/cnBAlQQCeMcYT
g3S2gUstGdlfUY0sU4zigwA=
=c1Hj
-----END PGP SIGNATURE-----

--------------enig0757CE261AB81E18D801FD90--

