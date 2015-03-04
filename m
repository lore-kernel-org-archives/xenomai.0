References: <CA+C+_XTfx6fAC3UvATJULBqogpvAOozwNkop=6Vj+jPYondj9Q@mail.gmail.com>
 <20150304174252.GF30672@hermes.click-hack.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20150304174252.GF30672@hermes.click-hack.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <666349AB-944C-4C85-83DE-C37BB9231AB1@gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Date: Wed, 4 Mar 2015 15:45:09 -0600
Subject: Re: [Xenomai] Debugger and secondary mode question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'll test it again shortly. =20

What happens when a thread depletes a semaphore or takes a mutex, then trans=
itions to secondary mode?  Does the semaphore or mutex automatically get giv=
en back or does the thread keep it for when it transitions back to primary m=
ode?

Sent from my iPhone

> On Mar 4, 2015, at 11:42 AM, Gilles Chanteperdrix <gilles.chanteperdrix@xe=
nomai.org> wrote:
>=20
>> On Wed, Mar 04, 2015 at 11:33:46AM -0600, Mathew Benson wrote:
>> I fixed all my toolchain problems and am finally back to debugging my
>> code.  Thanks for the help earlier.
>>=20
>> It looks like gdbserver causes suspended threads to drop back down to
>> secondary mode,
>=20
> Yes, that is expected/
>=20
>> causing my rt_... calls to return ENOSYS.
>=20
> What rt_ calls ? If you are talking about rtdm calls, returning
> ENOSYS should cause xenomai to switch again to primary mode, so is
> not an issue. Are you sure you do not mean EINTR ? Because yes, some
> calls can return EINTR when interrupted by a signal (which is what
> happens when running gdb), and if this is not handled by the call
> itself (for instance pthread_mutex_lock does not expose EINTR, it is
> handled in the user-space function itself), then your application
> should handle it.
>=20
>> Is there
>> anything I can do to prevent this?  I expect its unavoidable.
>=20
> There is no way to run gdb without signals.
>=20
>>=20
>> If I can't stop it, does anybody have any recommendations of how to make
>> code resilient to this?
>=20
> Test EINTR,and try again when it happens.
>=20
>> I'm mostly just using mutexes and semaphores in my
>> main loop.  Can I mix real time and non-realtime functions with the same
>> handle?  In other words, what happens to a rt semaphore when the thread
>> transitions back to secondary mode?  Does the handle refer to a non rt
>> version now, or is it just inaccessible?
>=20
> Xenomai will switch back to primary mode as soon as needed. An rt
> semaphore or mutex is rt-only, it has no secondary mode counterpart.
>=20
> --=20
>                        Gilles.

