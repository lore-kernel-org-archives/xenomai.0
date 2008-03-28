Message-ID: <d6c8ef150803280828v59f764en6bbb543fd6b7b8f7@domain.hid>
Date: Fri, 28 Mar 2008 16:28:44 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0803280655r665412f5qfa8ada46f630536a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
	<2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
	<d6c8ef150803280646y4fd12734v862b4f399727a5b5@domain.hid>
	<2ff1a98a0803280654u35f2da13t16a145ac22c1714f@domain.hid>
	<2ff1a98a0803280655r665412f5qfa8ada46f630536a@domain.hid>
Subject: Re: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-help <xenomai@xenomai.org>

Ok, I'll try that. But, is there something wrong with my code/approach
or is it some kind of arm-specific bug?

On 3/28/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On Fri, Mar 28, 2008 at 2:54 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Fri, Mar 28, 2008 at 2:46 PM, Bosko Radivojevic
> >
> > <bosko.radivojevic@domain.hid> wrote:
> >
> > > Ok. But, actually I dont need native-to-posix mode.
> >
> >  Good, because it is impossible.
> >
> >
> >  I just need to
> >  >  share memory betweend kernel thread and user space application.
> >
> >  See the posix stach example.
>
> satch, not statch. It is in examples/posix/satch.c.
>
> --
>  Gilles
>

-- 
Sent from Gmail for mobile | mobile.google.com

