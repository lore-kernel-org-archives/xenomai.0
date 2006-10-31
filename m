Subject: Re: [Xenomai-help] Increasing UVMs heap size
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF46135D04.DC659798-ONC1257218.0026EC51@domain.hid>
References: <OF46135D04.DC659798-ONC1257218.0026EC51@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:32:01 +0100
Message-Id: <1162283521.4996.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 08:12 +0100, Thomas Necker wrote:
> I tried to increase the heap size for UVM. I did so by using
> --enable-uvm-heapsz=512 when compiling the user space parts
> and also setting CONFIG_XENO_OPT_SYS_HEAPSZ=512 in the
> kernel configuration. Somehow it seems to work, at least I now can
> create a lot more pSOS skin queues than before. However, if I do
> a "cat /proc/xenomai/heap" I still get "size=131072:used=16:pagesz=512".
> So, why can't I see the increased heap size here? Thanks.
> 

Because passing --enable-uvm-heapsz changes the heap size for the
local/slave nucleus embodied (as a library) into your application
process (i.e. the UVM). /proc/xenomai/heap reports this size for the
"master" nucleus running in kernel space, each slave nucleus end up
using to emulate context switches and other low-level ops. UVM
strangeness.

> Thomas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



