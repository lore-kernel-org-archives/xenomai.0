MIME-Version: 1.0
In-Reply-To: <4E63E503.8090206@domain.hid>
References: <4E63E503.8090206@domain.hid>
Date: Mon, 5 Sep 2011 19:14:09 +0200
Message-ID: <CANKLDmvQ-q6nBXSRWs_R4RC_c7kmzM0tMmFbCBw59cbyPdSyzA@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai 2.6.0-rc1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

Hi Gilles,

Unfortunately I didn't find the time to test this release yet. I'm
just wondering if there is a fix for this problem in the 2.6.0
release: https://mail.gna.org/public/xenomai-core/2011-05/msg00028.html

We are using the auto-relax patches on top of 2.5.6 for a long time
now. We found issues with it regarding auto-relax tasks that were not
being auto-relaxed anymore. Philippe made patches for that, see
https://mail.gna.org/public/xenomai-help/2011-03/msg00161.html.
However, locally I reverted those two patches because these introduced
a memory leak in xnheap; I could only do rt_task_create()
rt_task_delete() for 1024 times ;-). I thought that was the discussion
of
https://mail.gna.org/public/xenomai-core/2011-05/msg00028.html at that
time and I don't recall a proper fix for it was provided. But I might
have missed it...

Thanks,
Henri

On Sun, Sep 4, 2011 at 10:52 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Hi,
>
> The first release candidate for the 2.6.0 version may be downloaded here:
>
> http://download.gna.org/xenomai/testing/xenomai-2.6.0-rc1.tar.bz2
>
> This version fixes a few issues in the 2.5.x branch which required
> breaking the ABI:
> - user-space heap mapping;
> - user-space access to thread mode;
> - get threads running with SCHED_OTHER scheduling policy to
> automatically return to secondary mode after each primary mode only
> system call (except when holding a mutex);
> - fix both native and posix condition variables signal handling.
>
> contains a few improvements as well:
> - add support for CLOCK_HOST_REALTIME, a real-time clock synchronized
> with Linux clock;
> - factor proc filesystem handling;
> - the "xeno-test" scripts has been simplified and rebased on
> "xeno-test-run", which will allow writing custom test scripts;
> - add support for sh4 architecture;
> - simplify arm user-space configure script;
> - move rtdk to libxenomai library, printf is now rt-safe when using the
> posix skin;
> - add support for pkg-config, the xenomai skin libraries are available
> each as a "libxenomai_skin" pkg-config package.
>
> Regards.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

