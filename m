Date: Wed, 23 Sep 2015 20:25:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150923182507.GB1332@hermes.click-hack.org>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
 <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
 <20150923053843.GD13976@hermes.click-hack.org>
 <CAFkYNwYq2EnufFGzpXz5Pszzb_F284eP34PbJMcZV74S51_OAw@mail.gmail.com>
 <20150923065514.GG13976@hermes.click-hack.org>
 <CAFkYNwbO9zMrRx_Dr8_NOC6yAv_ku8ocK37PuNu74-28XLULfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwbO9zMrRx_Dr8_NOC6yAv_ku8ocK37PuNu74-28XLULfg@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Sep 24, 2015 at 12:52:14AM +1200, vibnwis wrote:
> On 23 September 2015 at 18:55, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
> > On Wed, Sep 23, 2015 at 06:29:25PM +1200, vibnwis wrote:
> > > On 23 September 2015 at 17:38, Gilles Chanteperdrix <
> > > gilles.chanteperdrix@xenomai.org> wrote:
> > >
> > > > On Wed, Sep 23, 2015 at 12:41:38PM +1200, vibnwis wrote:
> > > > > On 23 September 2015 at 05:44, Gilles Chanteperdrix <
> > > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > > >
> > > > > > On Wed, Sep 23, 2015 at 12:32:11AM +1200, vibnwis wrote:
> > > > > > > By regenerating ./configure using autoreconf -fi, I managed to
> > > > compile
> > > > > > > xenomai-3-3.0-rc7 natively on PandaBoard. All things are put in
> > > > their own
> > > > > > > place by make install. However, when running latency, it produces
> > > > > > >
> > > > > > > > latency
> > > > > > > 0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate
> > memory
> > > > > >
> > > > > > You should either run the latency test as root, or have a look at
> > > > > > this page:
> > > > > >
> > > >
> > http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/
> > > > > >
> > > > > > By root I get this.
> > > > > root@arm:/usr/xenomai# latency
> > > > >    0"000.000| BUG in low_init(): [main] binding failed: Function not
> > > > > implemented
> > > > >
> > > > > However, the PATH has set the Lib
> > > >
> > > > Running as root was necessary to avoid the mlockall issue. The issue
> > > > you have now is different: the logs you sent show that the last
> > > > kernel you booted is not patched with Xenomai. The kernel is patched
> > > > with the I-pipe patch, but this is not sufficient, it is not
> > > > prepared with prepare-kernel.sh
> > > >
> > >
> > > I had thought of that too. However, the patch namely
> > > ipipe-core-3.18.20-arm-5.patch I used is meant for kernel 3.18.20. And
> > > there is no such patch available in the latest xenomai-3-3.0-rc7. ie
> > under
> > > the kernel/Cobalt/arch/arm/patches/, there is such patch available for
> > > 3.18.20. With the observation, I concluded that
> > > ipipe-core-3.18.20-arm-5.patch would patch all is needed for xenomai to
> > > work. In addition, I checked in its make menuconfig, I did not see Cobalt
> > > feature, but I did see ipipe was integrated. Obviously now I know it was
> > > wrong. However, I still yet found a xenomai which has patches for 3.18.20
> > > kernel. Any comments?
> >
> > You can use Xenomai 3.0-rc7 with the I-pipe patch for 3.18.20.
> > Simply pass the path to the patch to the prepare-kernel.sh --adeos
> > option.
> >
> If I am not wrong, prepare-kernel.sh is for preparing kernel by patching
> the patch files under the ..arm/patches/ipipe-core...3.18.12.patch, and in
> my case I patch kernel 3.18.12 with ipipe-core-3.18.12.patch which I did
> not use --adeos but --ipipe.
> 
> The other issue I pointed out above, Xenomai-3.0.rc7 does not have 3.18.20
> patch. Hope this clarifies things. I am happy to use kernel 3.18.12 anyway.

Ok, answering you is beyond my competences. I have been unable to
give you answers you understand. Therefore, I will stop answering
your questions, and hope someone else on the list will.

-- 
					    Gilles.
https://click-hack.org

