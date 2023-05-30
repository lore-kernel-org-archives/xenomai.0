Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8F46B2
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 09:13:09 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230530090253e73e1db3dfd1b5600c
        for <xenomai@lists.linux.dev>;
        Tue, 30 May 2023 11:02:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YBjCXdW5olaZsUGIsGorfA8F+SV5ADhrifDVuTC10Yw=;
 b=XLo2NFLKBpzJEr+0CVH8i3FtSV+ZjqClCuWb/g0QrSAbJL9ytnBdNGuuUTFOJTqtbOqVI1
 +tfL4VqINXQl//v0lLJetNo66sYJuqJJpYSULDHJYlr8DCI9GVoCukzKio2x9hvQnpiloh6L
 E6TZjk3ya8sw5ztT7+Y9+/LJ7m60o=;
Message-ID: <ad816e89d45d61c2a93135a1457894573e16fcb6.camel@siemens.com>
Subject: Re: [PATCH v2 4/4] cobalt/posix/select: Fix timeout update in case
 of -EINTR
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 30 May 2023 11:02:52 +0200
In-Reply-To: <b14d0870-d9a5-e53b-cd68-5b86c325edad@siemens.com>
References: 
	<20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
	 <20230516-florian-y2038-part-three-v2-4-3fc689b21a32@siemens.com>
	 <b14d0870-d9a5-e53b-cd68-5b86c325edad@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2023-05-29 at 13:19 +0200, Jan Kiszka wrote:
> On 26.05.23 07:36, Florian Bezdeka wrote:
> > When the select() syscall was interrupted (e.g. for handling a Linux
> > signal) the supplied timeout has not been updated. __cobalt_select()
> > bailed out too early.
> >=20
> > The testsuite has been improved to cover this case as well.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  kernel/cobalt/posix/io.c               | 18 +++----
> >  testsuite/smokey/y2038/syscall-tests.c | 94 ++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 102 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> > index 42a9b6208..beaa8fe63 100644
> > --- a/kernel/cobalt/posix/io.c
> > +++ b/kernel/cobalt/posix/io.c
> > @@ -319,6 +319,15 @@ int __cobalt_select(int nfds, void __user *u_rfds,=
 void __user *u_wfds,
> >  		}
> >  	} while (err =3D=3D -ECHRNG);
> > =20
> > +out:
> > +	if (to && (err > 0 || err =3D=3D -EINTR)) {
> > +		xnsticks_t diff =3D timeout - clock_get_ticks(CLOCK_MONOTONIC);
> > +		if (diff > 0)
> > +			ticks2ts64(to, diff);
> > +		else
> > +			to->tv_sec =3D to->tv_nsec =3D 0;
> > +	}
> > +
> >  	if (err =3D=3D -EINTR && signal_pending(current)) {
> >  		xnthread_set_localinfo(curr, XNSYSRST);
> > =20
> > @@ -329,15 +338,6 @@ int __cobalt_select(int nfds, void __user *u_rfds,=
 void __user *u_wfds,
> >  		return -ERESTARTSYS;
> >  	}
> > =20
> > -out:
> > -	if (to && (err > 0 || err =3D=3D -EINTR)) {
> > -		xnsticks_t diff =3D timeout - clock_get_ticks(CLOCK_MONOTONIC);
> > -		if (diff > 0)
> > -			ticks2ts64(to, diff);
> > -		else
> > -			to->tv_sec =3D to->tv_nsec =3D 0;
> > -	}
> > -
> >  	if (err >=3D 0)
> >  		for (i =3D 0; i < XNSELECT_MAX_TYPES; i++) {
> >  			if (!ufd_sets[i])
> > diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/=
y2038/syscall-tests.c
> > index d1e1f46bf..af27f2bce 100644
> > --- a/testsuite/smokey/y2038/syscall-tests.c
> > +++ b/testsuite/smokey/y2038/syscall-tests.c
> > @@ -123,6 +123,7 @@ static inline bool ts_less(const struct xn_timespec=
64 *a,
> >   */
> >  struct thread_context {
> >  	int sc_nr;
> > +	int sock;
> >  	pthread_mutex_t *mutex;
> >  	struct xn_timespec64 *ts;
> >  	bool timedwait_timecheck;
> > @@ -1443,6 +1444,94 @@ out:
> >  	return ret;
> >  }
> > =20
> > +static void pselect64_sig_handler(int sig)
> > +{
> > +	smokey_trace("pselect64: signal received");
> > +}
> > +
> > +static void *pselect64_waiting_thread(void *arg)
> > +{
> > +	struct thread_context *ctx =3D (struct thread_context *)arg;
> > +	struct xn_timespec64 ts;
> > +	int sock =3D ctx->sock;
> > +	struct sigaction sa;
> > +	fd_set rfds;
> > +	int ret;
> > +
> > +	FD_ZERO(&rfds);
> > +	FD_SET(ctx->sock, &rfds);
> > +
> > +	sigemptyset(&sa.sa_mask);
> > +	sa.sa_flags =3D SA_SIGINFO;
> > +	sa.sa_handler =3D pselect64_sig_handler;
> > +
> > +	ret =3D smokey_check_errno(sigaction(SIGUSR1, &sa, NULL));
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* Waiting for 1sec should be enough to get a signal */
> > +	ts.tv_sec =3D 1;
> > +	ts.tv_nsec =3D 0;
> > +	ret =3D XENOMAI_SYSCALL5(ctx->sc_nr, sock + 1, &rfds, NULL, NULL, &ts=
);
> > +	if (!smokey_assert(ret =3D=3D -EINTR)) {
> > +		ret =3D ret ?: -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* The remaining timeout has to be less than 1 sec */
> > +	if (!smokey_assert(ts.tv_sec =3D=3D 0 && ts.tv_nsec > 0)) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	return (void *)(long)ret;
> > +}
> > +
> > +static int test_pselect64_interruption(void)
> > +{
> > +	struct timespec ts =3D { .tv_sec =3D 0, .tv_nsec =3D 100000 };
> > +	struct thread_context ctx =3D { 0 };
> > +	void *w_ret =3D NULL;
> > +	pthread_t w;
> > +	int sock;
> > +	int ret;
> > +
> > +	sock =3D smokey_check_errno(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDD=
P));
> > +	if (sock =3D=3D -EAFNOSUPPORT) {
> > +		smokey_note("pselect64: skipped timeout write back test");
> > +		return 0;
> > +	}
> > +	if (sock < 0)
> > +		return sock;
> > +
> > +	ctx.sock =3D sock;
> > +	ctx.sc_nr =3D sc_cobalt_pselect64;
> > +
> > +	ret =3D smokey_check_status(
> > +		pthread_create(&w, NULL, pselect64_waiting_thread, &ctx));
> > +	if (ret)
> > +		goto out_sock;
> > +
> > +	/* Allow the waiting thread to enter the pselect64() syscall */
> > +	nanosleep(&ts, NULL);
> > +
> > +	/* Send a signal to interrupt the syscall and trigger -EINTR */
> > +	__STD(pthread_kill(w, SIGUSR1));
> > +
> > +	ret =3D smokey_check_status(pthread_join(w, &w_ret));
> > +	if (ret)
> > +		goto out_sock;
> > +
> > +	ret =3D smokey_assert((long)w_ret =3D=3D -EINTR);
> > +	if (ret)
> > +		w_ret =3D NULL;
> > +
> > +out_sock:
> > +	close(sock);
> > +	return (int)(long)w_ret;
> > +}
> > +
> >  static int test_sc_cobalt_pselect64(void)
> >  {
> >  	long sc_nr =3D sc_cobalt_pselect64;
> > @@ -1506,7 +1595,10 @@ static int test_sc_cobalt_pselect64(void)
> >  			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
> > =20
> >  out:
> > -	return ret;
> > +	if (ret)
> > +		return ret;
> > +
> > +	return test_pselect64_interruption();
> >  }
> > =20
> >  static int check_kernel_version(void)
> >=20
>=20
> We can do this, though the manpage states:
>=20
> "On  Linux,  select()  modifies timeout to reflect the amount of time
> not slept; most other implementations do not do this.  (POSIX.1 permits
> either behavior.)  This causes problems both when Linux code which reads
> timeout is ported to other operating systems, and when code is ported to
> Linux that reuses a struct timeval for multiple select()s in a loop
> without reinitializing it.  Consider timeout to be undefined after
> select() returns."
>=20
> So, this is not a critical change, just one that aligns us with Linux.

Exactly. I can try to express this better in v3 by updating the commit
message.

>=20
> Jan
>=20

