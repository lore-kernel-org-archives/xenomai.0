Subject: Re: [Xenomai-core] [BUG] rtf_put broken due to kernel 2.4 bug
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45297772.5080500@domain.hid>
References: <45297772.5080500@domain.hid>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 23:08:30 +0200
Message-Id: <1160860110.5151.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2006-10-09 at 00:10 +0200, Jan Kiszka wrote:
> Hi,
> 
> this issue
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0211.html
> 
> was revealed by the rtai fifo code. We currently have the double
> __test_and_set_bit combination at least here:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtai/fifo.c#L309
> (resolves to __test_and_set_bit via ipipe_test_and_stall_pipeline_from)
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtai/fifo.c#L311
> 
> The effect on this code is that multiple rtf_put on an unconnected fifo
> corrupts its queue.
> 
> I'm now awaiting the comment of the 2.4 maintainer, but we will still
> have to cope with this issue on current 2.4 kernels. There is also the
> risk that more spots are affected or will be affected in the future
> given the embedded use of __test_and_set_bit in pipeline stalling commands.
> 
> Anyone any smart idea how to handle this? Should we simply include the
> bitops patch in 2.4-x86-ipipe?

Yes, I'm going to wire this patch into 1.3-01 for 2.4.33.

> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



