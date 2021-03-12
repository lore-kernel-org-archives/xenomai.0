Date: Fri, 12 Mar 2021 20:53:45 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [Dovetail] x86 test version available (kernel v5.10)
Message-ID: <20210312205345.56040b2d@md1za8fc.ad001.siemens.net>
In-Reply-To: <20210312204630.0578766f@md1za8fc.ad001.siemens.net>
References: <874kixxf9e.fsf@xenomai.org>
 <20210222163530.443822b3@md1za8fc.ad001.siemens.net>
 <20210311173541.5e1b13b3@md1za8fc.ad001.siemens.net>
 <204ed847-12bf-4b8e-56a3-2e741dc9edf3@siemens.com>
 <4ff6d9aa-ea26-2195-a279-368a1eb7d099@siemens.com>
 <20210312191814.329ae63e@md1za8fc.ad001.siemens.net>
 <20210312204630.0578766f@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild via Xenomai <xenomai@xenomai.org>

Am Fri, 12 Mar 2021 20:46:30 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Fri, 12 Mar 2021 19:18:14 +0100
> schrieb Henning Schild via Xenomai <xenomai@xenomai.org>:
> 
> > Am Fri, 12 Mar 2021 12:32:54 +0100
> > schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >   
> > > On 12.03.21 08:22, Jan Kiszka wrote:    
> > > > On 11.03.21 17:35, Henning Schild wrote:      
> > > >> Am Mon, 22 Feb 2021 16:35:30 +0100
> > > >> schrieb Henning Schild via Xenomai <xenomai@xenomai.org>:
> > > >>      
> > > >>> Am Sun, 31 Jan 2021 17:06:21 +0100
> > > >>> schrieb Philippe Gerum via Xenomai <xenomai@xenomai.org>:
> > > >>>      
> > > >>>> The initial port of the Cobalt core to Dovetail/x86 is
> > > >>>> available from [1]. Ports to Dovetail/ARM and Dovetail/arm64
> > > >>>> should follow within a couple of weeks.
> > > >>>>
> > > >>>> So far, latency and switchtest run flawlessly. Most of the
> > > >>>> smokey test suite passes successfully, except the GDB test at
> > > >>>> the moment.
> > > >>>>
> > > >>>> How to test this:
> > > >>>>
> > > >>>> - clone Xenomai from [1], switch to branch
> > > >>>> for-upstream/dovetail
> > > >>>> - clone the Dovetail tree (v5.10) from [2], switch to branch
> > > >>>> dovetail/master
> > > >>>> - run scripts/prepare-kernel.sh available from [1] into [2]
> > > >>>> (usual procedure) for x86, that would be:
> > > >>>> .../scripts/prepare-kernel.sh --arch=x86
> > > >>>> - build your kernel using the sources from [2]        
> > > >>>
> > > >>> I followed this and got
> > > >>>
> > > >>> 0625b829450dab22b2eea860eef4fb94f64af4fd
> > > >>> 61769e49d82a6775f6eb259bdc16c2f84df79505
> > > >>>
> > > >>>      
> > > >>>> There is no user-visible Kconfig change compared to an I-pipe
> > > >>>> based version.        
> > > >>>
> > > >>> took a 4.19 x86_64 savedefconfig in via olddefconfig
> > > >>>      
> > > >>>> Alternatively, the Xenomai code base in [1] can also run on
> > > >>>> top of the I-pipe. prepare-kernel.sh detects which pipeline
> > > >>>> flavour is there, and prepares the source tree accordingly.
> > > >>>>
> > > >>>> This code is being gradually merged into Xenomai's -next
> > > >>>> branch, and will be at the core of Xenomai 3.2. Testing and
> > > >>>> feedback appreciated.        
> > > >>>
> > > >>> Now i get a BUG pretty early on during boot. Since my config
> > > >>> still seems off i could not yet enter my rootfs, probably some
> > > >>> drivers/filesystems/raid switches got lost ...
> > > >>>
> > > >>> Its a null pointer deref in kmem_cache_alloc, coming somewhere
> > > >>> from mempool_init_node
> > > >>>
> > > >>> First guess was that "numa=off" would hide the problem, seems
> > > >>> it does. So my next guess is that even a qemu with numa could
> > > >>> reproduce this ... probably almost on a random config ... as
> > > >>> long as it has smp+numa      
> > > >>
> > > >> It is not about numa, now also see that on qemu. Jan looks into
> > > >> it at the moment.
> > > >>      
> > > > 
> > > > I'm suspecting an upstream issue. The bug is some freelist
> > > > corruption, possibly only surfaced by dovetail. After digging
> > > > longer, I enabled CONFIG_SLAB_FREELIST_HARDENED, and that gave
> > > > 
> > > > [    0.159611] ACPI Error: Could not remove SCI handler
> > > > (20210105/evmisc-251)
> > > > [    0.160188] ------------[ cut here ]------------
> > > > [    0.160566] cache_from_obj: Wrong slab cache.
> > > > ftrace_event_field but object is from kmalloc-64
> > > > 
> > > > and more. However: You get those bugs also from running latest
> > > > 5.10.23 and even Linus' master. Will debug that further and then
> > > > possibly report upstream.      
> > > 
> > > This is a corner case of upstream (but still a bug there):
> > > 
> > > Your config lost CONFIG_PCI, likely because it is no longer
> > > default y. That not only generates and unbootable systems, it
> > > also sends the ACPI subsystem into an error path. There it seems
> > > to release objects to the wrong caches, leading to corruptions
> > > later on. Enabling PCI resolves all this.
> > > 
> > > I'll dump the config to upstream ACPI folks, should be their
> > > business.    
> > 
> > Thanks Jan!
> >   
> > > Jan
> > > 
> > > PS: Your config has more issues as it does not even boot in QEMU,
> > > even with PCI enabled. You should (re-)derive from
> > > x86_64-defconfig.    
> > 
> > Yes that was CI progressing with "olddefconfig" from a 4.19
> > "savedefconfig". No human took a closer look at the result, before
> > you. But hey that might fix an upstream bug so it was a good
> > exercise anyhow.  
> 
> Looking much better with a changed config. AFAIK the gdb test from
> smokey is known to fail at the moment. Should that be marked as "skip"
> mainline to reduce downstream skipping fixups?

Related to that ...

smokey --run --keep-going

does not keep-going on gdb, one needs

smokey --run --exclude gdb --keep-going

Henning

> Henning
> 
> > Henning 
> > 
> >   
> 


