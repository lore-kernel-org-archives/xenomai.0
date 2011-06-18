From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DFCABDA.6000702@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
	<1308387052.2122.14.camel@domain.hid>  <4DFCABDA.6000702@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 18 Jun 2011 16:35:23 +0200
Message-ID: <1308407723.2122.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, 2011-06-18 at 15:44 +0200, Gilles Chanteperdrix wrote:
> On 06/18/2011 10:50 AM, Philippe Gerum wrote:
> > On Tue, 2011-06-14 at 14:47 +0200, roderik.wildenburg@domain.hid
> > wrote:
> >> Perhaps this may help:
> >> I instrumented src/common/sem_heap.c   and ksrc/nucleus/heap.c with printf and printk (see appended files) and this is the output:
> >>
> >> 1:mrconfig:~ # latency
> >> 2:xeno_init_private_heap
> >> 3:map_sem_heap syscall 0
> >> 4:xeno_map_heap open 3
> >> 5:xnheap_ioctl private data: 00000000
> >> 6:xeno_map_heap ioctl 0 handle 0xc7dd9210
> >> 7:xnheap_mmap 00000000 00000000
> >> 8:xeno_map_heap 0xffffffff
> >> 9:Xenomai: mmap local sem heap: No such device or address
> >> 10:mrconfig:~ #
> >>
> >>
> >> It looks like (if I figured it out correctly) as if in function sem_heap.c->xeno_map_heap()  (which is called from xeno_init_privat_heap() via function map_sem_heap())  the ioctl-Call fails. 
> >> xeno_map_heap() passes correctly an argument unequal NULL as third parameter to ioctl() (line6), but in kernel space function xnheap_ioctl() the 3. parameter arrives as NULL(line 5). This sets file->private_data to NULL which in turn lets xnheap_mmap() fail, as this function expects file->private_data != NULL (line7).
> >> Therefore xnheap_mmap() returns -ENIXIO to xeno_map_heap() which outputs the error message " Xenomai: mmap local sem heap: No such device or address".
> >> The one million dollar question is, why the 3. parameter of ioctl() mutates to NULL. Any idea?
> >>
> >> If I can do anything else, let me know.
> >>
> > 
> > You will need these patches to run linux 2.4.25 over 2.5.6. The first
> > one fixes the ioctl() issue.
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=c2a24b90667e12d0614e5d8442dba74f137f9d4d
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=bebc2a8e6b430c99041800330dc6061665371d90
> > 
> > Note: the switch test does not seem to be running correctly on my
> > icecube (albeit the latency one does), somehow linux reschedule events
> > get lost. For this reason, I would not consider the current state as
> > being production-grade.
> 
> How do you see that reschedule events are lost? Does this happen also on
> other systems?
> 

nios2, x86_32, blackfin, arm11/mpcore, 85xx are all running the switch
test fine over 2.5.x + 2.6 kernels. This tends to point the finger at an
issue between the pipeline for 2.4/ppc and the real-time core.

-- 
Philippe.



