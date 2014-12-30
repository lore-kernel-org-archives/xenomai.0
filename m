Date: Tue, 30 Dec 2014 14:08:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141230130832.GC1966@daedalus>
References: <C162583A9AFD46C5BE6BF944025F777B@itd206>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C162583A9AFD46C5BE6BF944025F777B@itd206>
Subject: Re: [Xenomai] Reg:Linux-3.10.32-xen-2.6.3 kernel panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>
Cc: Srikanth <srikanth.ramarao@datapatterns.co.in>, xenomai@xenomai.org

On Tue, Dec 30, 2014 at 04:34:59PM +0530, Sureshvs wrote:
> Hi
> 
>         Arch: powerpc 32bit
>         Target Processor : 8641D
>         Linux kernel:     3.10.32 with SMP
>         Xenomai : 2.6.3
>        Boot parameter    root=/dev/nfs rw nfsroot=10.5.2.26:/opt/fc17fs_sband ip=10.5.2.20:10.5.2.26:10.5.18.4:255.255.255.0:VPX1234:eth0:off console=ttyS0,115200
>     
>         
>       While testing 1553B Linux driver with SMP kernel option enabled we are getting oops message mentioned below.\
> We are not getting any problem in non-smp mode.
> 
>         We are using spin_lock_irqsave  for updating the global status between ISR and task.
>     While debugging we found that  spin_lock_irqsave is giving problem.so kindly help us to solve the problem as  soon as possible.

Your driver should probably be using the RTDM API and the spinlock
it provides:
https://xenomai.org/documentation/xenomai-2.6/html/api/group__rtdmsync.html#ga985473873f9e32af688fe8a23634693d

If you insist on using spin_lock_irqsave, you should note that
Linux spinlocks are obviously not safe to be called from real-time
domain, so, you should define the spinlock as ipipe_spinlock_t.

Also note that calling your kernel -xen- may be confusing, as xen is
something which exists, very distinct from xenomai.

-- 
					    Gilles.

