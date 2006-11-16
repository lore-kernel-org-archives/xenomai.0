From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
Date: Thu, 16 Nov 2006 16:35:37 +0100
References: <200611151121.51836.s.zimmermann@domain.hid>
	<200611151544.00429.s.zimmermann@domain.hid>
	<1163678246.4962.53.camel@domain.hid>
In-Reply-To: <1163678246.4962.53.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161635.38075.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Donnerstag, 16. November 2006 12:57 schrieb Philippe Gerum:
> On Wed, 2006-11-15 at 15:44 +0100, Stephan Zimmermann wrote:
> > Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
> > > Hello,
> > >
> > > I got some trouble with the native skin and queues, when creating /
> > > deleting
> > >
> > > > queues, my Kernel sometimes (actually very often...) crashes, leading
> > > > to a frozen system, with my Xenomai program continuing until it
> > > > returns. I tried
> > > > to isolate / reproduce the problem, which lead me to the following
> > > > demo-code.
>
> [...]
>
> Cannot test it yet, but could you try out this patch? TIA,

So, finally I managed to apply your patch, thanks for the hint :). After 
recompiling everything it seems to work an the first view. But I guess your 
patch is not the final solution (or we discover another problem here...).  
When I run the testprogram, everything looks fine, until I start to work with 
the X-Server. Starting X, logging into KDE or shutting down X sometimes leads 
to a syslog full of 'bad page' messages, as seen below. The system keeps 
responding to commands, I can exit my testprogram by pressing CTRL-C, X works 
as usual (just using it for typing this mail...).

<syslog>
Bad page state in process 'maintask'
Nov 16 16:24:49 localhost kernel: page:c16d8b40 flags:0x80000400 
mapping:00000000 mapcount:0 count:0
Nov 16 16:24:49 localhost kernel: Trying to fix it up, but a reboot is needed
Nov 16 16:24:49 localhost kernel: Backtrace:
Nov 16 16:24:49 localhost kernel:  <c01572e3> bad_page+0x43/0x6c  <c0157b32> 
free_hot_cold_page+0x60/0x14d
Nov 16 16:24:49 localhost kernel:  <c0165de5> __vunmap+0x91/0xc2  <c0165e33> 
vfree+0x1d/0x20
Nov 16 16:24:49 localhost kernel:  <c0136ba5> 
xnheap_destroy_mapped+0x200/0x23b  <c01513ab> rt_queue_delete+0xc2/0xe9
Nov 16 16:24:49 localhost kernel:  <c014ddb4> __rt_queue_delete+0x50/0x77  
<c0143fee> losyscall_event+0xa4/0x146
Nov 16 16:24:49 localhost kernel:  <c0143f4a> losyscall_event+0x0/0x146  
<c0134612> __ipipe_dispatch_event+0xa6/0x162
Nov 16 16:24:49 localhost kernel:  <c010e91e> __ipipe_syscall_root+0x6d/0xdb  
<c0102e36> sysenter_past_esp+0x3b/0x67
Nov 16 16:24:49 localhost kernel: Bad page state in process 'maintask'
Nov 16 16:24:49 localhost kernel: page:c16dd6c0 flags:0x80000400 
mapping:00000000 mapcount:0 count:0
Nov 16 16:24:49 localhost kernel: Trying to fix it up, but a reboot is needed
Nov 16 16:24:49 localhost kernel: Backtrace:
Nov 16 16:24:49 localhost kernel:  <c01572e3> bad_page+0x43/0x6c  <c0157b32> 
free_hot_cold_page+0x60/0x14d
Nov 16 16:24:49 localhost kernel:  <c0165de5> __vunmap+0x91/0xc2  <c0165e33> 
vfree+0x1d/0x20
Nov 16 16:24:49 localhost kernel:  <c0136ba5> 
xnheap_destroy_mapped+0x200/0x23b  <c01513ab> rt_queue_delete+0xc2/0xe9
Nov 16 16:24:49 localhost kernel:  <c014ddb4> __rt_queue_delete+0x50/0x77  
<c0143fee> losyscall_event+0xa4/0x146
Nov 16 16:24:49 localhost kernel:  <c0143f4a> losyscall_event+0x0/0x146  
<c0134612> __ipipe_dispatch_event+0xa6/0x162
Nov 16 16:24:49 localhost kernel:  <c010e91e> __ipipe_syscall_root+0x6d/0xdb  
<c0102e36> sysenter_past_esp+0x3b/0x67
Nov 16 16:24:49 localhost kernel: Bad page state in process 'maintask'
Nov 16 16:24:49 localhost kernel: page:c16dd740 flags:0x80000400 
mapping:00000000 mapcount:0 count:0
Nov 16 16:24:49 localhost kernel: Trying to fix it up, but a reboot is needed
Nov 16 16:24:49 localhost kernel: Backtrace:
Nov 16 16:24:49 localhost kernel:  <c01572e3> bad_page+0x43/0x6c  <c0157b32> 
free_hot_cold_page+0x60/0x14d
Nov 16 16:24:49 localhost kernel:  <c0165de5> __vunmap+0x91/0xc2  <c0165e33> 
vfree+0x1d/0x20
Nov 16 16:24:49 localhost kernel:  <c0136ba5> 
xnheap_destroy_mapped+0x200/0x23b  <c01513ab> rt_queue_delete+0xc2/0xe9
Nov 16 16:24:49 localhost kernel:  <c014ddb4> __rt_queue_delete+0x50/0x77  
<c0143fee> losyscall_event+0xa4/0x146
Nov 16 16:24:49 localhost kernel:  <c0143f4a> losyscall_event+0x0/0x146  
<c0134612> __ipipe_dispatch_event+0xa6/0x162
Nov 16 16:24:49 localhost kernel:  <c010e91e> __ipipe_syscall_root+0x6d/0xdb  
<c0102e36> sysenter_past_esp+0x3b/0x67
Nov 16 16:24:49 localhost kernel: Bad page state in process 'maintask'
Nov 16 16:24:49 localhost kernel: page:c16dd760 flags:0x80000400 
mapping:00000000 mapcount:0 count:0
Nov 16 16:24:49 localhost kernel: Trying to fix it up, but a reboot is needed
Nov 16 16:24:49 localhost kernel: Backtrace:
Nov 16 16:24:49 localhost kernel:  <c01572e3> bad_page+0x43/0x6c  <c0157b32> 
free_hot_cold_page+0x60/0x14d
Nov 16 16:24:49 localhost kernel:  <c0165de5> __vunmap+0x91/0xc2  <c0165e33> 
vfree+0x1d/0x20
Nov 16 16:24:49 localhost kernel:  <c0136ba5> 
xnheap_destroy_mapped+0x200/0x23b  <c01513ab> rt_queue_delete+0xc2/0xe9
Nov 16 16:24:49 localhost kernel:  <c014ddb4> __rt_queue_delete+0x50/0x77  
<c0143fee> losyscall_event+0xa4/0x146
Nov 16 16:24:49 localhost kernel:  <c0143f4a> losyscall_event+0x0/0x146  
<c0134612> __ipipe_dispatch_event+0xa6/0x162
Nov 16 16:24:49 localhost kernel:  <c010e91e> __ipipe_syscall_root+0x6d/0xdb  
<c0102e36> sysenter_past_esp+0x3b/0x67
... many more here...
</syslog>

