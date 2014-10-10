Date: Fri, 10 Oct 2014 15:25:52 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20141010132552.GA13501@localhost.localdomain>
References: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
 <542D65B0.3080002@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <542D65B0.3080002@xenomai.org>
Subject: Re: [Xenomai] Xenomai on Cortex R (or Rreal Time) family
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 02, 2014 at 04:48:16PM +0200, Gilles Chanteperdrix wrote:
> On 10/02/2014 04:28 PM, mobin Motallebizadeh wrote:
> >  Hi
> > can I build xenomai for armv7-r architecture?=20
> > I can't see this mentioned anywhere (surprisingly!)
> > Is it same as other MMU-less archs(nios II ,e.g.)?
>=20
> The first question to ask is: do you have a Linux kernel for this
> processor? because Xenomai needs Linux to run.

There is some main line support for Cortex-M3, for the Energy Micro
development kit. See Uwe Kleine-K=F6nig's tree at

   http://git.pengutronix.de/?p=3Dukl/linux.git

I have never heard of Linux running on a Cortex-R at all.

HTH,
Richard

