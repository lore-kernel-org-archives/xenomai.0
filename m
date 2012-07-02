From: "George Pontis" <GPontis@z9.com>
References: <009c01cd539e$e9f81420$bde83c60$@com>
	<4FF057F2.7040109@xenomai.org>
In-Reply-To: <4FF057F2.7040109@xenomai.org>
Date: Sun, 1 Jul 2012 21:27:21 -0700
Message-ID: <03de01cd580a$f9016d70$eb044850$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> ....
>=20
> Ok. I was able to reproduce the same message with the following test
> application:
>=20
> #include <sys/mman.h>
>=20
> #include <native/task.h>
> #include <native/mutex.h>
>=20
> RT_MUTEX mx;
>=20
> int main(void)
> {
> 	RT_TASK t;
>=20
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
>=20
> 	rt_task_shadow(&t, "test_fault", 1, 0);
>=20
> 	rt_mutex_acquire(&mx, TM_INFINITE);
> }
>=20
> Namely: trying to acquire a mutex which is not initialized. The =
address
> 0xffff0fbc is off-by 4, the real fault address is 0xffff0fc0, the
> kernel
> helper used by the mutex implementation for the
> atomic-compare-and-exchange operation.
>=20
> --
>                                                                 =
Gilles.

Gilles, that is very helpful. I looked at the code from the app guys and =
was not able to decipher the fairly complicated C++ task logic, but =
passed this info to them. I will keep track of their efforts and make =
sure that we close on it. As far as trying the other examples, I need to =
do some catch-up. The embedded target does not have gdb running on it as =
they haltingly make do with gdbsever and gdb/Eclipse on the host. And I =
_still_ have not been able to coax any detailed output from the kernel =
with CONFIG_DEBUG_USER and user_debug=3D29. I know that this is declared =
because an added printk shows that it is executing the function =
user_debug_setup in arch/arm/kernel/traps.c which is dependent on =
CONFIG_DEBUG_USER. But no additional info shows after the fault, =
including the fault from your test application.

George



