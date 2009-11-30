MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <4AF22E85.50400@domain.hid>
References: <634c78ce0910010730t29137af8w95b63ae21183b52b@domain.hid> 
	<4AF22E85.50400@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Mon, 30 Nov 2009 15:20:16 +0100
Message-ID: <634c78ce0911300620h54d4332cje66f05dce4b6171f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] select: native tasks with posix skin mqueues
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Thu, Nov 5, 2009 at 02:46, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Peter Soetens wrote:
> > Hi,
> >
> > I'm creating my RT threads using the native API and I'm creating
> > mqueues, wrapped to the pthread_rt library.
> > I can read and write the mqueue (and it goes through Xenomai), but
> > when I select() on a receiving mqd_t, the select() calls returns that
> > there is data available on the mq (it fills in the FD_SET), but keeps
> > doing so even when it's empty (the select() is in a loop). Also, it's
> > modeswitching like nuts.
> >
> > I found out that the __wrap_select is correctly called, but returns
> > -EPERM. Kernel sources indicate that this is caused by
> > pse51_current_thread() alias thread2pthread() returning null. Since
> > EPERM is returned to userspace, the __real_select is called from user
> > space, causing the mode switches and bad behaviour. This is almost
> > certainly the thing that native + RTDM + select() is seeing too.
> >
> > My mqueues-only work probably because mq.c only uses
> > pse51_current_thread() in the mq_notify function. I'm guessing that
> > mq_notify would also not work in combination with native skin.
> >
> > I had two options in fixing this: add a xnselector to the native task
> > struct or to the nucleus xnthread_t. I choose the latter, such that
> > every skin kan use select() + RTDM and migrate gradualy to the RTDM
> > and/or Posix skin.
> > I needed to free the xnselector structure in xnpod_delete_thread() , I
> > chose a spot, but it causes a segfault in my native thread (which did
> > the select) during program cleanup. Any advice ? Also, maybe we should
> > separate select() from the posix skin and put it in a separate place
> > (in RTDM as rtdm_select() ?), such that we can start building around
> > it (posix just forwards to rtdm_select() then).
> >
> > A second patch was necessary to return the timeout case properly to
> > userspace (independent of first patch).
> >
> > Tested with native + posix loaded and mq. If you never quit your
> > application, this works :-)
>
> Hi,
>
> I have included a lightly modified version of this patch on head, I do
> not see any crash. =A0However, I have some doubts about the current
> implementation: calling xnselector_destroy() opens opportunities for a
> rescheduling, which I am not sure is really what we want in the middle
> of xnpod_delete_thread(). Philippe, what do you think?

I'll test this patch this week too. It seems you forgot to apply the
second patch, which can go straight into the 2.4 head, since it fixes
a bug in the select() wrapping code when timeouts are used. See
parent's 0002-posix-Fix-__wrap_select-when-timeout-happens.patch

Peter

