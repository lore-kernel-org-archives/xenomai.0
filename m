Message-ID: <2ff1a98a0712270743h545e7de4ta5707d6caecc9743@domain.hid>
Date: Thu, 27 Dec 2007 16:43:20 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB2FB@rennsmail04.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB2FB@rennsmail04.eu.thmulti.com>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 27, 2007 4:39 PM, Fillod Stephane <stephane.fillod@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> >Fillod Stephane wrote:
> > > Perrine Martignoni wrote:
> > > >Currently, I write an RTDM module and I would like to do DMA and
> mmap
> > > to perform transfers who have hard constraints.
> > > >I would like to know if there is an example in a driver who would
> help
> > > me to do this.
> > >
> > > I'm looking for the same need, except I'm not using RTDM, and
> everything
> > > is in userland. Using the attached patch against Xenomai 2.4.0, I
> hope
> > > to make it to work with something like this:
> >
> >I propose the attached modifications. Is it Ok for you ?
>
> Yes, your patch is much cleaner, esp. wrt KMALLOC_MAX_SIZE which I was
> not aware of.
>
> The documentation needs an update, and a link to RT_HEAP_INFO.
> Does any Doxygen guru knows how to make rt_heap_inquire a hyperlink
> in the above chunk?

I seem to remember that you have to write ::rt_heap_inquire or rt_heap_inquire()

-- 
                                               Gilles Chanteperdrix

