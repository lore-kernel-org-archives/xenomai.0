Date: Thu, 16 Apr 2015 18:16:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150416161629.GF1589@hermes.click-hack.org>
References: <1429171505-5598-1-git-send-email-kinsamanka@gmail.com>
 <20150416131956.GC1589@hermes.click-hack.org>
 <CACreCVJd-1c8iYGuEJE4W_6Q4dpo4sPOtJvDLbQaTUN2m8Bwpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVJd-1c8iYGuEJE4W_6Q4dpo4sPOtJvDLbQaTUN2m8Bwpw@mail.gmail.com>
Subject: Re: [Xenomai] [PATCH] Add support for SUNXI boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 17, 2015 at 12:04:22AM +0800, GP Orcullo wrote:
> On Thu, Apr 16, 2015 at 9:19 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Thu, Apr 16, 2015 at 04:05:05PM +0800, GP Orcullo wrote:
> >> Tested on a Cubieboard2 with v3.16.7-ckt9 kernel.
> >
> > Does not sunxi have GPIO ?
> >
> > --
> >                                             Gilles.
> 
> There's no GPIO driver in the mainline kernel. The original sunxi
> kernel has incomplete support for GPIOs.

Ok, what about timer and tsc? Basically, you should run through the
ARM porting guide and check every modification to be made. And if
you have done so, the commit message should mention it.

-- 
					    Gilles.

