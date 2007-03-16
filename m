Date: Fri, 16 Mar 2007 07:52:56 +0000 (GMT)
From: somshekar kadam <som_kadam@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on MIPS intial boot
In-Reply-To: <1173956689.8193.14.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <851018.97559.qm@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Philipe, 

    Yes definately , we will talk and need your
guidance to make it perfect, right now looking into
syscall and xnarch_init_thread, once minimal is
working , I will get back to you. 
we are seeing now its able to go in syscall and
failing to create task , this is the last hurdle,
which we need to cross. now I am able to install
libraries for xenomai, one thing I dont understand is
its not able to create shared lib, for time being made
it static and debuging. any pointers on this will be
useful. 

Thanks And Regards
Neelu




--- Philippe Gerum <rpm@xenomai.org> wrote:

> On Thu, 2007-03-15 at 10:45 +0000, somshekar kadam
> wrote:
> > Hi Gilles, 
> > 
> >   Right now I cant submit it, may be in the first
> week
> > of APRIL I will submit it. After my client accepts
> the
> > port and we shall submit it to open source.
> 
> Great, so I suggest that we talk about the following
> issues
> maybe, say, by the first week of April.
> 
> >  Right now
> > compiled lib for xenomai, when i say make install
> got
> > some recursive error, and all lib are created as
> > libnative.a , I dont understand why shared libs
> are
> > not created in the configure command for xenomai I
> > give 
> > ./configure --host=mips --prefix=/opt/neelu/xen
> > --enable-shared=libnative CC=mips_fp_be-gcc. 
> > 
> > next command make 
> > nex command make install 
> > gives error, what I see is asm-mips soft link is
> > broken, i created it manually still not working
> any
> > pointers on this. 
> > 
> > Thanks And Regards
> > Neelu
> > 
> > 
> > 
> > 
> > --- Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> > 
> > > somshekar kadam wrote:
> > >  > 
> > >  > Hi All, 
> > >  > 
> > >  >    I have implelented Xenomai for MIPS , as
> due
> > > to
> > >  > some legal issues with project completion, I
> can
> > >  > submit for Open source. I hope this is
> > > understood. 
> > > 
> > > Actually, it is not understood. What do you
> mean,
> > > you can or can not
> > > submit your work to open-source ?
> > > 
> > > -- 
> > > 
> > > 
> > > 					    Gilles Chanteperdrix.
> > > 
> > 
> > 
> > 
> > 		
> >
>
__________________________________________________________
> > Yahoo! India Answers: Share what you know. Learn
> something new
> > http://in.answers.yahoo.com/
> > 
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> -- 
> Philippe.
> 
> 
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/

