From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <BANLkTikvUkLKJ0fybCjxXBP82GkiNPdAWw@domain.hid>
References: <mailman.6356.1286778008.12503.xenomai@xenomai.org>
	<7504E039-6366-480F-ACA3-018E520122E6@domain.hid>
	<AANLkTin__DMjjDxFzBCOiA1Z+ODq01KA6FSWSzEwET3y@domain.hid>
	<AANLkTik=JkttWXUj5Zm04cpQTokGh3y272PzwUkdmS2N@mail.gmail.com>
	<AANLkTin8hwsKv1oZf1Tv_F97hZEVy=T=KzMcPSsn-O8r@domain.hid>
	<1304262109.2063.4.camel@domain.hid>
	<BANLkTikvUkLKJ0fybCjxXBP82GkiNPdAWw@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 May 2011 15:55:39 +0200
Message-ID: <1304603739.2188.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: Andreas Glatz <andi.glatz@domain.hid>, xenomai@xenomai.org

On Mon, 2011-05-02 at 10:58 +0200, Henri Roosen wrote:
> Hi Philippe,
> 
> Thanks for the patch! Unfortunately this does not resolve the 'stuck
> in primary of prio 0 after rt_task_send'.
> 
> I'll attach the basic test application that reproduces it. All prints
> should contain secondary mode because all tasks are prio 0 and the
> auto-relax patches are compiled in.
> 
> The producer which does the rt_task_send() call does not auto-relax to
> secondary mode.

Your example code works with this added patch on top of both 2.5.x and
-head:
http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=82200f0b66908a5366a72355b3b70472031d68fb

> 
> Thanks,
> Henri.
> 
> On Sun, May 1, 2011 at 5:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Mon, 2011-03-28 at 12:56 +0200, Henri Roosen wrote:
> >> Hi,
> >>
> >> We are using the back-ported auto-relax patches of Xenomai-head on the
> >> 2.5.6 release on Linux 2.6.32.15.
> >>
> >> We noticed that our prio-0 shadowed task is not always auto-relaxed
> >> and traced it back to a problem with rt_task_send/receive/reply. The
> >> rt_task_send/receive/reply mechanism uses the xnsynch primitive to
> >> implement its PIP. However, this mechanism only acquires the xysynch
> >> primitive without releasing it. This results in the resource counter
> >> never be 0 anymore and thus breaking the auto-relaxed which is based
> >> on this resource counter.
> >>
> >> I guess releasing the xnsynch resets the owner, which is not wanted either..
> >> Any idea for a fix?
> >
> > Could you give a try at this one? TIA,
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=becb13774ab687d016857f6a972f4124fbd10c44
> >
> >>
> >> Thanks,
> >> Henri.
> >>
> >>
> >> On Tue, Oct 12, 2010 at 9:16 AM, Henri Roosen <henriroosen@domain.hid> wrote:
> >> > That was a problem with our build environment.
> >> >
> >> > Patches work and the base-prio 0 task nicely switches to the Linux
> >> > domain and competes with the Linux threads for the processor. Now we
> >> > don't loose TCP connection to our target anymore.
> >> >
> >> > Thanks!
> >> >
> >> > Henri
> >> >
> >> > On Mon, Oct 11, 2010 at 5:35 PM, Henri Roosen <henriroosen@domain.hid> wrote:
> >> >> Thanks for the patches Philippe. I applied them to xenomai 2.5.5.
> >> >> Tests with a basic application look good, however our bigger project
> >> >> doesn't. I checked already if we release all mutexes; the base prio 0
> >> >> thread thread released all of them but stays in primary domain after a
> >> >> xenomai call.
> >> >>
> >> >> I'll setup a clean environment, just to be sure, and will investigate
> >> >> further tomorrow.
> >> >>
> >> >> On Mon, Oct 11, 2010 at 11:31 AM, Andreas Glatz <andi.glatz@domain.hid> wrote:
> >> >>>
> >> >>>>
> >> >>>> The auto-relax feature is now available from -head (upcoming
> >> >>>> 2.6.x). You
> >> >>>> will need all commits from
> >> >>>> http://git.xenomai.org/?p=xenomai-
> >> >>>> head.git;a=commit;h=b75cec19387e561f82ac55595db8c993b049f071
> >> >>>> to
> >> >>>> http://git.xenomai.org/?p=xenomai-
> >> >>>> head.git;a=commit;h=6653a9e8eb7339b749989bd74adc3ac3bd29e4da
> >> >>>>
> >> >>>> --
> >> >>>> Philippe.
> >> >>>>
> >> >>>>
> >> >>>
> >> >>> Very nice. Will try it out soon on my G4 PB Aluminium.
> >> >>>
> >> >>> Andreas
> >> >>>
> >> >>>
> >> >>> _______________________________________________
> >> >>> Xenomai-help mailing list
> >> >>> Xenomai-help@domain.hid
> >> >>> https://mail.gna.org/listinfo/xenomai-help
> >> >>>
> >> >>
> >> >
> >
> > --
> > Philippe.
> >
> >
> >

-- 
Philippe.



