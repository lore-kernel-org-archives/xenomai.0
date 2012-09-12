Message-ID: <5050F04C.6030707@xenomai.org>
Date: Wed, 12 Sep 2012 22:27:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5050E1F2.8090702@free.fr>
In-Reply-To: <5050E1F2.8090702@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] posix skin pthread_create issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre Quelin <pierre.quelin@free.fr>
Cc: pierre.quelin@solystic.com, xenomai@xenomai.org

On 09/12/2012 09:26 PM, Pierre Quelin wrote:

> Thank you for quick answer.
>=20
> my context
>=20
> xenomai : 2.6.0 adeos : 2.11-02 kernel : 2.6.38.8 arch : pentium pro=20
> gcc : 4.6.3 distro : Ubuntu 12.04


If you use this version, add "-fno-omit-frame-pointer" to the CFLAGS
passed to the configure script.

>=20
> I already read the TROUBLESHOOTING guide but I don't understand all
> the informations contained in //proc/<pid>/maps/. I already try
> "ulimit -s 81920" without success.


You usually want to decrease ulimit -s, not increase it.

>=20
> After your answer, I try xenomai 2.6.1 and I increase the size of the
>  private stack pool from 128 to 2048 with the same result.
>=20
> Is there any limits for the number of threads in Xenomai ?


Not that I know of. There are only a few dynamic allocations in the
various pools you already mentioned. The corresponding options are:
XENO_OPT_REGISTRY_NRSLOTS (maximum number of objects in the registry,
each thread is registered in the registry)
XENO_OPT_SYS_HEAPSZ (system heap, used for various calls to xnmalloc)
XENO_OPT_SEM_HEAPSZ (semaphore heap, use for allocating 4 bytes per
thread + 4 bytes per mutex)

But anyway, debugging the issue you have should be relatively easy by
adding printfs/printks, starting from src/skins/posix/thread.c (function
__wrap_pthread_create), continuing in ksrc/skins/posix/syscall.c,
function __pthread_create, etc...

>=20
>=20
> I don't know if there is the link with my problem but I have some=20
> strange things.
>=20
> With Xenomai 2.6.1, when I launch the latency/switch test I obtain
> some negative values like -1.03=C2=B5s.


That is a known issue. See for instance:
http://www.blaess.fr/christophe/2012/07/23/les-latences-de-xenomai/


 After mlockall() in
> //proc/xenomai/faults/ I obtain 2 or more Page fault without visible
> software effects. I can't locate it. If you could help me.


>=20
> Our application is writting in C++. At the begining it initialise a
> lot of static objects as mutex and do a lot of allocation/syscall. So
> it do a lot of switch in secondary mode. To solve this, at first, I
> just catch the SIGXCPU in a static class..


Well, you should be able to catch the page faults with SIGXCPU, but you
have to ensure that pthread_set_mode and the signal handler installation
are done before the static objects constructors. And of course, you have
to ensure that Xenomai libpthread_rt library constructor gets run before
your static initializers. That is a problem with C++. Also note that
PTHREAD_MUTEX_INITIALIZER and PTHREAD_COND_INITIALIZER do not work with
Xenomai posix skin.

>=20
>=20
> Sorry for messages at the end of the mail but I can't remove it
> (!?.=C2=A7=C2=A7!! Lotus N..es and security policy) Could you please se=
nd me a
> copy of your answer to pierre.quelin@solystic.com


The free.fr address is fine.


--=20
                                                                Gilles.


