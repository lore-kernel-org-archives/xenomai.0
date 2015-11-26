MIME-Version: 1.0
Message-ID: <trinity-ce80def3-8e79-4167-a62c-ec7fb0007f3f-1448530746213@3capp-webde-bs12>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2015 10:39:06 +0100
In-Reply-To: <20151126091052.GC19641@hermes.click-hack.org>
References: <trinity-1b427f3b-dabe-48c1-a434-82562a3226e1-1448528416329@3capp-webde-bs12>,
 <20151126091052.GC19641@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm driver open_rt/nrt handler question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> On Thu, Nov 26, 2015 at 10:00:16AM +0100, JK=2EBehnke@web=2Ede wrote:
> > Xenomai 2=2E6=2E3 documentation states, that the usage of open_rt hand=
lers
> > is deprecated
> > as this feature will be removed in the future=2E
>
> Xenomai 2=2E6=2E3 is very old now=2E It is not even the latest release i=
n
> the 2=2E6 branch=2E open_rt has been removed from Xenomai 3=2E
>
> > As a consequence one cannot use rtdm_mutex_lock inside an nrt_open
> > handler
> > to synchronize multiple callers, as this will result in a
> > (!xnpod_unblockable_p()) assertion=2E
> > So using a spinlock would be the only solution in that situation=2E
> > Is that true?
>
> No, the caller is a Linux task, or a Xenomai task running in
> secondary mode=2E As such, any Linux service can be used, such as
> mutex or semaphores (the Linux ones)=2E
Yes, I agree=2E
Using a xenomai spinlock would of course also result in a
xenomai assertion, hence I'm left with the linux synchronization
services=2E
Same goes for init_module/cleanup_module handlers, as these can
only be called by Linux tasks=2E

>
> >
> > By the way, if an rtdm driver only supports RTDM_EXCLUSIVE mode, is
> > there
> > a need to synchronize concurrent calls to rt_dev_open on this device a=
t
> > all?
> > I guess not, because the second caller will be refused=2E
> > Is that also true?
>
> Yes=2E
OK=2E

Gilles, thanks again for responding that fast=2E
I really appreciate it=2E
Regards
Jochen

=C2=A0

