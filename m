Date: Fri, 3 Oct 2014 09:24:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141003072419.GB2450@sisyphus.hd.free.fr>
References: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
 <542D65B0.3080002@xenomai.org>
 <DUB121-W1275BB81DE6E0C94AEE64981A60@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DUB121-W1275BB81DE6E0C94AEE64981A60@phx.gbl>
Subject: Re: [Xenomai] Xenomai on Cortex R (or Rreal Time) family
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin Motallebizadeh <mobin.seven@live.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Oct 03, 2014 at 03:50:10AM +0000, mobin Motallebizadeh wrote:
>
>
>
>
> > On 10/02/2014 04:28 PM, mobin Motallebizadeh wrote:
> > >  Hi
> > > can I build xenomai for armv7-r architecture?
> > > I can't see this mentioned anywhere (surprisingly!)
> > > Is it same as other MMU-less archs(nios II ,e.g.)?
> >
> > The first question to ask is: do you have a Linux kernel for this
> > processor? because Xenomai needs Linux to run.
> >
> >
>
> there's uClinux which can support xenomai (as u mentioned in docs) and cortex-r family is limited to.

If it is not the mainline Linux, and it does not share code with the
ARM Linux port, then as Philippe indicated a new port of the I-pipe
patch is needed, but that is doable.

--
					    Gilles.

