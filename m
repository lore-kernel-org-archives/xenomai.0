Date: Tue, 15 May 2007 12:42:58 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
In-Reply-To: <527512.75196.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <221268.98062.qm@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on MIPS MALTA
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

Hi , 
soory it should have been "without your contribution
it wouldnt have been successful "


regards
Neelu


--- somshekar kadam <som_kadam@domain.hid> wrote:

> Hi All, 
> 
> 
> Good News , now we are able to run User Space
> Applications as well as Kernel Module, Implemented
> the
> the thread related part xnarch_thread_init,
> basically
> intialize the stack frame for thread to do context
> switch, now able to go to rthal_thread_trampoline
> and
> next to xnarch_thread_trampoline and able to switch
> to
> new thread and able to execute, once the xenomai we
> check for proper stability and performance for
> client
> , we will release ADEOS and XENOMAI for MIPS core
> for
> OPEN SOURCE. We thank Open community for all the
> help
> especially Philip, Jan ,Dimitry and Gallies, once
> again thanks a lot for all the help without your
> contirbiution it would be successful. 
> 
> may be next we have discussion with client and once
> client accepts it we release the code. 
> 
> Thanks And Regards
> Neelu
> 
> 
> 
> 
> --- Jan Kiszka <jan.kiszka@domain.hid> wrote:
> 
> > somshekar kadam wrote:
> > > Hi Phillep,
> > > 
> > >  good news xenomai porting for mips is done,
> user
> > > space application are working fine. once the
> > formality
> > > with our client gets over we will submit the
> code
> > to
> > > open source. People contirbuted for this project
> > are
> > > Subramani,Manoj,Sanjeev,Nishit,Poornima and
> Neelu.
> > 
> > > 
> > > Right now debugging an issue for kernel space
> > module
> > > where rt task start goes for toss, will be fixed
> > next
> > > week probably, subramni will be working on it. 
> > > 
> > > we hope to deliver it for MIPS MALTA BOARD, as
> we
> > need
> > > to get it working for Malta borad, after we
> > release to
> > > our customer. 
> > > we will need help in fixing performance issues
> > from
> > > open source community. 
> > 
> > The sooner you are able to release, the sooner the
> > community can help...
> > 
> > Jan
> > 
> > 
> 
> 
> 
>       Office firewalls, cyber cafes, college labs,
> don't allow you to download CHAT? Click here:
> http://in.messenger.yahoo.com/webmessengerpromo.php
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 



      Office firewalls, cyber cafes, college labs, don't allow you to download CHAT? Click here: http://in.messenger.yahoo.com/webmessengerpromo.php

