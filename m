Message-ID: <48F7B5F8.7020105@domain.hid>
Date: Thu, 16 Oct 2008 23:45:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid> <48F6492C.4090500@domain.hid>
	<48F660E7.8090906@domain.hid> <48F79AF9.6030303@domain.hid>
In-Reply-To: <48F79AF9.6030303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6852208989C77E73FD10F077"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rt_task_info.status encoding
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6852208989C77E73FD10F077
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> the documentation refers to the Native Task Status (T_*) when it com=
es
>>>> to documenting rt_task_info.status. That is not correct. That field
>>>> contains far more flags than T_* is describing and, even worse, come=
s
>>>> with two collisions: T_PRIMARY and T_JOINABLE are not reported by
>>>> rt_task_inquire, rather T_RELAX (!T_PRIMARY, arrrg...) and T_HELD.
>>>>
>>> T_PRIMARY is NOT meant to be reported by rt_task_inquire(), and actua=
lly, its
>>> value was picked to collide, to reflect the fact that it was a one-wa=
y
>> So you preferred to break rt_task_inquire instead of letting it return=
 a
>> consistent value? Not really?
>=20
> As explained earlier, the thing you have to understand is that rt_task_=
inquire()
> is not broken, it just does not work your way, which is a different iss=
ue.

At the bare minimum, its documentation is broken. It points to state
values which rt_task_inquire does not return.

>=20
>>> specifier. You can't use T_RELAX because what is needed is a bit to f=
orce a
>>> transition to primary mode using rt_task_set_mode(), which is the act=
ual source
>>> of all uglinesses. Aside of this, the nucleus naturally wants a "rela=
xed state"
>>> bit, and would not get any help from a "primary mode" bit for threads=
=2E
>> I'm not arguing for removing T_PRIMARY, I was just struggling with the=

>> confusing values rt_task_inquire reported to me.
>>
>=20
> This is because you want T_PRIMARY to be part of the rt_task_inquire() =
return
> values. It must not, really. When apps start playing with the current m=
ode,
> things start falling apart. I don't want to make T_PRIMARY a first-clas=
s citizen
> of the interface; considering it as a legitimate value of an inquiry se=
rvice
> would do that. So that is a NAK.

I start to believe we are arguing with different (miss-)use case in
mind. Mine is definitely not about "helping" the user to switch the
thread mode even more actively. It is about validating application
states, it is about thread state reflection without any other actions
than reporting errors. T_PRIMARY is part of the picture for the dual
kernel Xenomai version, and it will remain such as long as there are two
kernels. Even better, it is a very helpful application debugging tool
when it comes to runtime validation of their real-time behavior. Again,
it is NOT about promoting more use of rt_task_set_mode!

>=20
>>> We could have used a T_RELAX bit to clear in rt_task_set_mode() inste=
ad of
>>> T_PRIMARY to set, but unfortunately, such a negative logic would have=
 been
>>> somewhat confusing to users, since what is provided is the secondary =
-> primary
>>> mode switch.
>>>
>>> Sending back the current mode in rt_task_inquire() would lead to two =
additional
>>> issues:
>>> 1) if for some reason, we would like to switch the caller to secondar=
y mode at
>>> some point to be able to provide a more complete status, the primary/=
secondary
>>> status returned would make no sense at all. The fact that we don't do=
 it now
>>> does not preclude the need to do it in future releases.
>> Sorry, but this is very far fetched.
>>
>=20
> Sorry, you are wrong. rt_task_inquire() is currently marked as __xn_exe=
c_any,
> which means that it is processed in the current thread mode, but always=
 from the
> Xenomai stage in the pipeline. If at some point, we extend rt_task_inqu=
ire() to
> return information from the Linux realm (e.g. protected by a RCU constr=
uct), we
> would have to move that call to __xn_exec_lostage. Conversely, if at so=
me point
> the rt_task_inquire() service is changed so that getting information fr=
om the
> nucleus involves blocking, then we would have to make that call __xn_ex=
ec_primary.
>=20
> Far fetched, even impossible that we would need that? Not that much act=
ually. A
> number of people have native Xenomai kernel modules interacting with na=
tive
> Xenomai apps in userland; those modules maintain a significant portion =
of the
> application logic, and some did reimplement some kind of rt_task_inquir=
e() for
> debugging and logging purposes. Instead of that, we could allow the in-=
kernel
> part to be asked for additional information via a callback from the
> rt_task_inquire() implementation, using the RT_TASK_INFO struct as a co=
mmon
> return header, that could be completed with more data.
> In that case, rt_task_inquire() would have to be flexible when it comes=
 to the
> thread mode, currently it is not, because you may only fetch informatio=
n that is
> immediately available from the Xenomai stage, without blocking.
>=20
> Therefore, in both cases, T_PRIMARY would become meaningless as a retur=
n value.

We will nevertheless be able to take a snapshot (for debugging
purposes!) of the thread state before any potential mode switch, see my
patch for mirroring the mode into user space for fast xnsynch services.

Moreover, making a formerly primary-safe service secondary (just like we
discussed for rt_task_set_priority) is NEVER a good idea. It will easily
break existing apps. If you start extending rt_task_inquire like that, I
would quickly jump in and request to extend it in a way that existing
users would NOT trigger such mode switches, or provide a separate
interface. You would also not expect from rt_task_inquire that is
suddenly changes the priority of the caller, would you?

>=20
>>> 2) rt_task_set_mode(..., T_PRIMARY) is already vastly misused in a nu=
mber of
>>> applications, sometimes uselessly, most of the time in a way that eve=
nt kills
>>> performances. Giving an interface to get back the current mode would =
close the
>>> loop, triggering a whole set of new terminally silly usage of that ha=
ck.
>>> Applications should NEVER use that feature, it was initially designed=
 for
>>> internal code (i.e. RTDM if my memory serves me well). Actually, the =
more I
>>> think of it, the more I convinced that I'm going to slaughter this cr=
ap in 2.5,
>>> providing an internal syscall from the XENOMAI_SYS class instead for =
use only in
>>> proper contexts.
>> This is a different issue.
>>
>> See, I needed rt_task_inquire for precisely the purpose it is (mostly)=

>> designed for: tracing / debugging. And for that purpose, a valid
>> T_PRIMARY bit is of very high importance. I even implemented the same
>> inquire service for POSIX in the meantime so that I was able to
>> implement all functional tests I needed for the fast mutexes.
>>
>=20
> See, the point is that T_PRIMARY is often misused because it belongs to=
 the
> mainline interface whilst it should only be used in very limited situat=
ions. I
> did acknowledge a long time ago that skin developers may need it badly =
though,
> this is why I provided this service to you in the first place. The poin=
t is: the
> interface to that service should make perfectly clear that it is intern=
al stuff
> that should not be part of the toolbox for writing applications.
> I.e. direct XENOMAI_SYS() call.
>=20
>> If you really argue for removing a T_PRIMARY-equivalent from
>> RT_TASK_INFO, you may also argue for removing the SIGXCPU helper - the=

>> user should better not know in which context some of his threads
>> currently runs.
>>
>=20
> You are missing the point: SIGXCPU is about helping users to find a bug=
 when
> they messed up mode management involuntarily. Moving T_PRIMARY out of t=
he
> mainline interface is about preventing users to mess up mode management=
 voluntarily.

Nope, it is just as well about helping to find involuntary mode switches
at application module boundaries. Granted, reflection on the current
thread mode /can/ be misused, just like many tools can be used to do
weird things, but then let us rather discuss about how to overcome
rt_task_set_mode(T_PRIMARY) and not how to make developers' life harder
while they try to find inconsistent application states (there are cases
where SIGXCPU cannot be used).

Jan


--------------enig6852208989C77E73FD10F077
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3tfgACgkQniDOoMHTA+mhQACcD9gbER2vJMtlzlEvsLj7A53l
vSMAn3uBgRIb4gzkfy8hwqA3dA3no7gC
=NMkg
-----END PGP SIGNATURE-----

--------------enig6852208989C77E73FD10F077--

