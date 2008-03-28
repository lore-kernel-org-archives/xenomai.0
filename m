Message-ID: <d6c8ef150803280842p34d7d4r9e3c11c15afc7c31@domain.hid>
Date: Fri, 28 Mar 2008 16:42:30 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <d6c8ef150803280842p2b86e144xf03e372bb92dcad4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
	<2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
	<d6c8ef150803280646y4fd12734v862b4f399727a5b5@domain.hid>
	<2ff1a98a0803280654u35f2da13t16a145ac22c1714f@domain.hid>
	<2ff1a98a0803280655r665412f5qfa8ada46f630536a@domain.hid>
	<d6c8ef150803280828v59f764en6bbb543fd6b7b8f7@domain.hid>
	<2ff1a98a0803280834t38a195eey3fce0bb0c5ef9831@domain.hid>
	<d6c8ef150803280842p2b86e144xf03e372bb92dcad4@domain.hid>
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

On 3/28/08, Bosko Radivojevic <bosko.radivojevic@domain.hid> wrote:
> Ok, but Im using native (xeno) skin, both in kernel thread and in user
> space app. O_CREAT is flag for shm_open & other posix functions,
> right? And, yes, send me your patch please.
>
> On 3/28/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > On Fri, Mar 28, 2008 at 4:28 PM, Bosko Radivojevic
> > <bosko.radivojevic@domain.hid> wrote:
> > > Ok, I'll try that. But, is there something wrong with my code/approach
> > >  or is it some kind of arm-specific bug?
> >
> > Yes, as I said in my first answer, you are missing the O_CREAT flag in
> > the call to shm_open.
> >
> > The arm-specific bug will happen later (once the shared memory is
> > mapped). Because the kernel-space and user-space will get different
> > caches for the same memory area. The solution to this issue is to map
> > the heap without cache, but to get this, you need modifications of
> > Xenomai that only exist on my computer for now. So, if you are
> > interested, I will send a patch.
> >
> > --
> >  Gilles
> >
>
> --
> Sent from Gmail for mobile | mobile.google.com
>

-- 
Sent from Gmail for mobile | mobile.google.com

