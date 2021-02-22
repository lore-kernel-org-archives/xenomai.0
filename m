Date: Mon, 22 Feb 2021 18:59:02 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [Dovetail] x86 test version available (kernel v5.10)
Message-ID: <20210222185902.6fdc97e3@md1za8fc.ad001.siemens.net>
In-Reply-To: <20210222163530.443822b3@md1za8fc.ad001.siemens.net>
References: <874kixxf9e.fsf@xenomai.org>
 <20210222163530.443822b3@md1za8fc.ad001.siemens.net>
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

Am Mon, 22 Feb 2021 16:35:30 +0100
schrieb Henning Schild via Xenomai <xenomai@xenomai.org>:

> Am Sun, 31 Jan 2021 17:06:21 +0100
> schrieb Philippe Gerum via Xenomai <xenomai@xenomai.org>:
> 
> > The initial port of the Cobalt core to Dovetail/x86 is available
> > from [1]. Ports to Dovetail/ARM and Dovetail/arm64 should follow
> > within a couple of weeks.
> > 
> > So far, latency and switchtest run flawlessly. Most of the smokey
> > test suite passes successfully, except the GDB test at the moment.
> > 
> > How to test this:
> > 
> > - clone Xenomai from [1], switch to branch for-upstream/dovetail
> > - clone the Dovetail tree (v5.10) from [2], switch to branch
> > dovetail/master
> > - run scripts/prepare-kernel.sh available from [1] into [2] (usual
> > procedure) for x86, that would be: .../scripts/prepare-kernel.sh
> > --arch=x86
> > - build your kernel using the sources from [2]  
> 
> I followed this and got
> 
> 0625b829450dab22b2eea860eef4fb94f64af4fd
> 61769e49d82a6775f6eb259bdc16c2f84df79505
> 
> 
> > There is no user-visible Kconfig change compared to an I-pipe based
> > version.  
> 
> took a 4.19 x86_64 savedefconfig in via olddefconfig
> 
> > Alternatively, the Xenomai code base in [1] can also run on top of
> > the I-pipe. prepare-kernel.sh detects which pipeline flavour is
> > there, and prepares the source tree accordingly.
> > 
> > This code is being gradually merged into Xenomai's -next branch, and
> > will be at the core of Xenomai 3.2. Testing and feedback
> > appreciated.  
> 
> Now i get a BUG pretty early on during boot. Since my config still
> seems off i could not yet enter my rootfs, probably some
> drivers/filesystems/raid switches got lost ...
> 
> Its a null pointer deref in kmem_cache_alloc, coming somewhere from
> mempool_init_node
> 
> First guess was that "numa=off" would hide the problem, seems it does.
> So my next guess is that even a qemu with numa could reproduce this
> ... probably almost on a random config ... as long as it has smp+numa

Tried that again, it is not 100% reproducible ... "numa=off" does not
solve the issue.

I did try the dovetail bits of xenomai-images 5.10 together with a
numa-qemu ... that works.

qemu-system-x86_64 -drive
file=./build/tmp/deploy/images/qemu-amd64/demo-image-xenomai-demo-qemu-amd64.ext4.img,discard=unmap,if=none,id=disk,format=raw
-serial mon:stdio -netdev user,id=net -kernel
./build/tmp/deploy/images/qemu-amd64/demo-image-xenomai-demo-qemu-amd64-vmlinuz
-append ' root=/dev/sda vga=0x305' -initrd
./build/tmp/deploy/images/qemu-amd64/demo-image-xenomai-demo-qemu-amd64-initrd.img
-cpu host -smp 4 -enable-kvm -machine q35 -device ide-hd,drive=disk
-device virtio-net-pci,netdev=net -object
memory-backend-ram,id=mem0,size=1G -object
memory-backend-ram,id=mem1,size=1G -numa
node,cpus=0-1,nodeid=0,memdev=mem0 -numa
node,cpus=2-3,nodeid=1,memdev=mem1 -m 2G

> I do not have more at the moment, but there seem to be issues around
> NUMA.

So maybe it is not NUMA, will keep digging.

Henning

> regards,
> Henning
> 
> > Thanks,
> > 
> > [1] https://lab.xenomai.org/xenomai-rpm.git, "for-upstream/dovetail"
> > branch [2] https://git.evlproject.org/linux-evl.git,
> > "dovetail/master" branch
> >   
> 
> 


