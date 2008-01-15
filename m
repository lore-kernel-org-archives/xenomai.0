Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2008 09:41:10 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D37657B@slcmail.slc.mew.int>
In-Reply-To: <2ff1a98a0801150827ka2070dfxd937209e57271b3f@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376570@domain.hid>
	<2ff1a98a0801150827ka2070dfxd937209e57271b3f@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] rms scheduling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Then I will have to go back and re-write my code to use jiffies instead
of nanoseconds, right? Is there a macro that will return the proper
value for future use?

Also, it seems like this rt_timer_set_mode() will make this the timebase
for all things using the native skin. However, what if another app
wanted a different timebase? This isn't possible, is it?

Thanks,
Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, January 15, 2008 9:27 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rms scheduling
>=20
> On Jan 15, 2008 5:10 PM, Steven Seeger
> <sseeger@domain.hid> wrote:
> >
> >
> >
> >
> > How do you implement RMS scheduling in a userspace app? I didn't set
the
> > aperiodic timing mode in the kernel config because it said that it
> wasn't a
> > good idea. I realize that I'm using one-shot, but I'm porting over
> software
> > from an older RTAI project that used a periodic timebase of 125us.
Since
> I'm
> > currently configured to use one-shot, I think this may cause
problems.
> >
> >
> >
> > What I want is for all tasks to have their timings be a multiple of
some
> > value, and then have all thread timing based around increments of
that.
> So,
> > if I set a task periodic, I want it to start in sync with the other
> threads.
> > Perhaps the only way to do this is to have threads sync to a
conditional
> > variable when they start?
>=20
> No, setting the system timer to periodic mode will get things to work
> the way you want.
>=20
> >
> >
> >
> > I saw I can use rt_set_timer_mode() to set the timebase for a skin.
> Would
> > this give me the desired effect?
>=20
> Yes.
>=20
> --
>                                                Gilles Chanteperdrix

