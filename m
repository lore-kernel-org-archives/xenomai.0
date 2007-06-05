From: NZG <ngustavson@domain.hid>
Date: Tue, 5 Jun 2007 10:34:33 -0500
References: <200706041432.05779.ngustavson@domain.hid>
	<m28xay4qho.fsf@domain.hid>
In-Reply-To: <m28xay4qho.fsf@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706051034.33646.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] ep93xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Detlev Zundel <dzu@domain.hid>

Thank you,
Looks like a good starting point.

NZG

On Tuesday 05 June 2007 5:58 am, Detlev Zundel wrote:
> Hi,
>
> > Does anyone have a Xenomai patch for the cirrus ep93xx processors?
> > I understand it has an RTAI port,
> > but I'd prefer to stay on the Xenomai side if possible.
>
> I have an implementation against a 2.6.15 kernel that I never posted
> because it is still "rough around the edges".  But as time passed too
> quickly it is very likely the best to post it and at least give you a
> base to work against.
>
> Unfortunately I have only the whole patch including i-pipe support
> based on what was in svn xenomai revision r2056 (i.e. 5th January this
> year) together with the ep93xx parts in one large patch.  But the
> ep93xx parts should be easy to extract.
>
> One thing that I did not finish was a correct demuxing of the
> interrupts that got introduced somewhat around that timeframe in the
> other ARM ports.  The code was compile-clean but not finished in this
> area.
>
> I hope this helps
>   Detlev

