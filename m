Date: Tue, 13 Feb 2018 17:51:42 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180213175142.78d73407@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <20180212165734.0eb98638@mmd1pvb1c.ad001.siemens.net>
References: <20180209161313.32524-1-henning.schild@siemens.com>
 <8eaf133f-a235-b0c3-0260-c527800d715a@siemens.com>
 <20180209182347.7bb4a455@mmd1pvb1c.ad001.siemens.net>
 <20180209185839.6f537a43@mmd1pvb1c.ad001.siemens.net>
 <5c68e748-f8e3-fcb2-e3f8-1b586b87a757@xenomai.org>
 <20180212165734.0eb98638@mmd1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] boilerplate: introduce big lock to serialze
 dso init calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

I am now working on a fix for that issue. That will probably come with
a testcase for dlopen, seems that whole code-path is not covered by any
testcases.

Henning

Am Mon, 12 Feb 2018 16:57:34 +0100
schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:

> Am Sat, 10 Feb 2018 11:33:00 +0100
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
> > On 02/09/2018 06:58 PM, Henning Schild wrote:  
> > > Am Fri, 9 Feb 2018 18:23:47 +0100
> > > schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:
> > >     
> > >> Am Fri, 9 Feb 2018 17:48:22 +0100
> > >> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> > >>    
> > >>> On 2018-02-09 17:13, Henning Schild wrote:      
> > >>>> When using dlopen() to include xenomai libraries into an
> > >>>> application, __xenomai_init could be running in multiple
> > >>>> threads at a time. That happens if the application dlopens
> > >>>> multiple libs in multiple threads.        
> > >>>
> > >>> So, dlopen itself is thread-safe, but it does not guarantee
> > >>> atomicity for the init functions it executes? Or would we run
> > >>> xenomai_init_dso manually in that case?      
> > >>
> > >> According to its man-page dlopen is MT-Safe, but i do not think
> > >> that necessarily means it will serialize the init functions for
> > >> us. I think i will have to read the code to answer this one.    
> > > 
> > > I just had a look at glibc, and it looks like dlopen contains a
> > > big dlopen-lock as well.
> > > 
> > > https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/dl-open.c;h=0e37dd74b603ba07f677f2b4cf21661de5379529;hb=23158b08a0908f381459f273a984c6fd328363cb#l541
> > > 
> > > dl_open_worker will be called only under that lock and that is
> > > where a function named _dl_init gets called. uclibc also uses a
> > > big lock around all dlopen activity.
> > > 
> > > It all looks like my patch is not required.
> > >    
> > 
> > The MT-safety issue may be with the setup calls, which run on behalf
> > of library constructors. Multiple threads calling
> > __register_setup_call() concurrently may be a problem, which may
> > happen when multiple DSOs are loaded concurrently (assuming their is
> > nothing serializing the dl work).
> > 
> > #define core_setup_call(__name)		__setup_call(__name,
> > 0) #define boilerplate_setup_call(__name)
> > __setup_call(__name, 1) #define
> > copperplate_setup_call(__name)	__setup_call(__name, 2)
> > #define interface_setup_call(__name)	__setup_call(__name, 3)
> > #define post_setup_call(__name)		__setup_call(__name,
> > 4) #define user_setup_call(__name)
> > __setup_call(__name, 5)  
> 
> Found the problem, the setup_list was inconsistent because the
> application did a dlclose() on one of the xenomai-libs. And there are
> no destructors and no unregister_setup_call ...
> 
> Now i am wondering whether the setup_call list would be the only thing
> to consider when adding dtors. Or whether we could just have a dtor
> that returns -EBUSY to prevent dlclose().
> 
> Henning
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


