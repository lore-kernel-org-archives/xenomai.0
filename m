Subject: Re: [Xenomai-core] Xenomai on MIPS intial boot
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <297289.1445.qm@domain.hid>
References: <297289.1445.qm@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 12:04:49 +0100
Message-Id: <1173956689.8193.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-03-15 at 10:45 +0000, somshekar kadam wrote:
> Hi Gilles, 
> 
>   Right now I cant submit it, may be in the first week
> of APRIL I will submit it. After my client accepts the
> port and we shall submit it to open source.

Great, so I suggest that we talk about the following issues
maybe, say, by the first week of April.

>  Right now
> compiled lib for xenomai, when i say make install got
> some recursive error, and all lib are created as
> libnative.a , I dont understand why shared libs are
> not created in the configure command for xenomai I
> give 
> ./configure --host=mips --prefix=/opt/neelu/xen
> --enable-shared=libnative CC=mips_fp_be-gcc. 
> 
> next command make 
> nex command make install 
> gives error, what I see is asm-mips soft link is
> broken, i created it manually still not working any
> pointers on this. 
> 
> Thanks And Regards
> Neelu
> 
> 
> 
> 
> --- Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
> > somshekar kadam wrote:
> >  > 
> >  > Hi All, 
> >  > 
> >  >    I have implelented Xenomai for MIPS , as due
> > to
> >  > some legal issues with project completion, I can
> >  > submit for Open source. I hope this is
> > understood. 
> > 
> > Actually, it is not understood. What do you mean,
> > you can or can not
> > submit your work to open-source ?
> > 
> > -- 
> > 
> > 
> > 					    Gilles Chanteperdrix.
> > 
> 
> 
> 
> 		
> __________________________________________________________
> Yahoo! India Answers: Share what you know. Learn something new
> http://in.answers.yahoo.com/
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



