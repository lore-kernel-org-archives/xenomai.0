MIME-Version: 1.0
In-Reply-To: <4D948F87.9010109@domain.hid>
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>
	<1301412534.2109.24.camel@domain.hid> <4D922EF5.8020808@domain.hid>
	<1301426227.2109.35.camel@domain.hid> <4D9230C5.7050007@domain.hid>
	<1301426830.2109.41.camel@domain.hid> <4D923306.60409@domain.hid>
	<1301461081.2092.14.camel@domain.hid>
	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>
	<1301472945.2092.21.camel@domain.hid>
	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>
	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>
	<4D948F87.9010109@domain.hid>
Date: Thu, 31 Mar 2011 16:44:42 +0200
Message-ID: <AANLkTi=j3OPT0jrRS1_faEA_sQcN8iZ+nATwiCLW22VS@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Mar 31, 2011 at 4:28 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Did some more tracing to see why the lower priority thread is
>> scheduled before the higher prio thread is ended.
>>
>> The highest priority task makes a system call and gets relaxed by
>> xnshadow_relax. The rpi is pushed here and a Linux call with
>> LO_WAKEUP_REQ is scheduled. Then I see the scheduler scheduling to the
>> ROOT task. So far so good!
>>
>> In the Linux domain, we run into the lostage_handler, where the
>> scheduled LO_WAKEUP_REQ is executed. Here there is a call to
>> xnpod_schedule() which actually causes a switch back to the primary
>> domain and the lower priority Xenomai task to be scheduled in, even
>> before the wanted process is woken up.
>>
>> Now, I am unsure what is faulty here and maybe Philippe or someone can
>> answer that. Personally I would have expected the xnpod_schedule (or
>> xnsched_pick_next) to know about the rpi list and not schedule a lower
>> priority task than of any on that list. I was unable to find such
>> code.
>>
>
> Unless I am wrong, what happens is whait is intended, at least if we
> read the comment:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case LO_WAKEUP_REQ:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We need to downgrade th=
e root thread
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * priority whenever the A=
PC runs over a
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * non-shadow, so that the=
 temporary boost we
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * applied in xnshadow_rel=
ax() is not
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * spuriously inherited by=
 the latter until
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the relaxed shadow actu=
ally resumes in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * secondary mode.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rpi_clear_local(xnshadow_t=
hread(current));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xnpod_schedule();
>
> Which means that we do not want other Linux kernel code than the
> real-time thread itself to inherit from this thread priority. Except
> that all the code from the switch to root thread to the lostage_handler
> (which means any Linux currently preempted critical section) already
> inherited the priority.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

Yes, I think too that what is coded here might be what is intended.
Except the behavior that exactly at this xnpod_schedule() call the
lower priority threads from the primary domain are scheduled in, while
Priority Coupling promises to not schedule any of those before the
higher priority relaxed thread. That is why I'm wondering where that
specific code is, which I would expect somewhere down the line of
xnpod_schedule() which would peek the rpi list or so. Or is it my
misunderstanding to expect such code?

Thanks,
Henri

