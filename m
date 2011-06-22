Message-ID: <4E01CA9A.2040709@domain.hid>
Date: Wed, 22 Jun 2011 12:57:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>
In-Reply-To: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic on boot with 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/22/2011 12:44 PM, VEYSSIERE Nicolas wrote:
> Hello,
> 
> I succesfully build a 2.6.38.8 kernel with the latest adeos patch and Xenomai 2.5.6, but it kernel panic :
> 
> [    1.195878] Pid: 1, comm: swapper Tainted: G         D W     2.6.38-xenomai-r6 #1
> [    1.196878] Call Trace:
> [    1.196878]  [<c14ae979>] ? panic+0x50/0x145
> [    1.197878]  [<c1031250>] ? do_exit+0x5c/0x6be
> [    1.198877]  [<c14b071c>] ? _raw_spin_unlock_irqrestore+0xe/0x10
> [    1.199877]  [<c102e487>] ? kmsg_dump+0x35/0xb5
> [    1.200877]  [<c14b1b32>] ? oops_end+0xa0/0xa8
> [    1.201877]  [<c101b448>] ? no_context+0x110/0x11a
> [    1.201877]  [<c101b570>] ? __bad_area_nosemaphore+0x11e/0x126
> [    1.202877]  [<c101b585>] ? bad_area_nosemaphore+0xd/0x10
> [    1.203877]  [<c14b32c1>] ? do_page_fault+0x1c0/0x36b
> [    1.203877]  [<c10144da>] ? __ipipe_handle_exception+0x24f/0x288
> [    1.203877]  [<c14b11af>] ? error_code+0x5f/0x70
> [    1.204876]  [<c10736fe>] ? __xirq_end+0x12/0x2e
> [    1.205876]  [<c107472a>] ? ipipe_register_domain+0x1d8/0x1e4
> [    1.205876]  [<c108e46e>] ? rthal_init+0x17d/0x20c
> [    1.206876]  [<c139e098>] ? rthal_domain_entry+0x0/0x39
> [    1.207876]  [<c1706c3d>] ? __xeno_sys_init+0x41/0x261
> [    1.208876]  [<c108a4a2>] ? pmu_dev_alloc+0x64/0x7d
> [    1.208876]  [<c1001076>] ? do_one_initcall+0x71/0x133
> [    1.209876]  [<c1706bfc>] ? __xeno_sys_init+0x0/0x261
> [    1.210876]  [<c16f4382>] ? kernel_init+0x128/0x1a4
> [    1.211875]  [<c16f425a>] ? kernel_init+0x0/0x1a4
> [    1.212875]  [<c1002d06>] ? kernel_thread_helper+0x6/0x10
> 
> 
> Could it be a problem with the fact that this system is a virtual box VM ?

It is hard to tell, we do not have the error message, which should be
right above this stack trace. Please post the full logs, as there may be
other interesting details in the logs.

> 
> 
> Thanks.
> 
> --
> Nicolas VEYSSIERE
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
                                                                Gilles.

