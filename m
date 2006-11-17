From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
Date: Fri, 17 Nov 2006 13:38:11 +0100
References: <200611151121.51836.s.zimmermann@domain.hid>
	<200611161635.38075.s.zimmermann@domain.hid>
	<455C874E.5050901@domain.hid>
In-Reply-To: <455C874E.5050901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171338.11924.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Donnerstag, 16. November 2006 16:44 schrieb Jan Kiszka:
> Stephan Zimmermann wrote:
> > Am Donnerstag, 16. November 2006 12:57 schrieb Philippe Gerum:
> >> On Wed, 2006-11-15 at 15:44 +0100, Stephan Zimmermann wrote:
> >>> Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
> >>>> Hello,
> >>>>
> >>>> I got some trouble with the native skin and queues, when creating /
> >>>> deleting
> >>>>
> >>>>> queues, my Kernel sometimes (actually very often...) crashes, leading
> >>>>> to a frozen system, with my Xenomai program continuing until it
> >>>>> returns. I tried
> >>>>> to isolate / reproduce the problem, which lead me to the following
> >>>>> demo-code.
> >>
> >> [...]
> >>
> >> Cannot test it yet, but could you try out this patch? TIA,
> >
> > So, finally I managed to apply your patch, thanks for the hint :). After
> > recompiling everything it seems to work an the first view. But I guess
> > your patch is not the final solution (or we discover another problem
> > here...). When I run the testprogram, everything looks fine, until I
> > start to work with the X-Server. Starting X, logging into KDE or shutting
> > down X sometimes leads to a syslog full of 'bad page' messages, as seen
> > below. The system keeps responding to commands, I can exit my testprogram
> > by pressing CTRL-C, X works as usual (just using it for typing this
> > mail...).
>
> See last night's thread: this issue was due to my patch fixing too much
> of an regression in SVN trunk. You should upgrade to head (#1842 by now)
> and try again. "svn up" should work fine for this, merging all changes
> together.

You're right, upgraded to head and recompiled it. Seems to work now. Many 
thanks for the fast response on this list.

Stephan

