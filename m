Subject: Re: [Xenomai-help] Xenomai v2.2.3
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45118754.3000001@domain.hid>
References: <1158564530.5020.5.camel@domain.hid> <450F1686.3010304@domain.hid>
	<451068AD.6080000@domain.hid> <1158744278.5544.42.camel@domain.hid>
	<451153D5.2080200@domain.hid> <1158768864.5043.31.camel@domain.hid>
	<45118754.3000001@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 20:33:36 +0200
Message-Id: <1158777216.5043.46.camel@domain.hid>
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-09-20 at 13:24 -0500, Jeff Webb wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-09-20 at 09:44 -0500, Jeff Webb wrote:
> > 
> >> Switching to xenomai-2.2.3/linux-2.4.32 (ipipe-1.2) fixed this problem.
> > 
> > Could you try running 2.2.3 stock + fpu fix patch over 2.4.33.3/1.3-00,
> > and 2.2.3 stock over 2.4.33.3/1.2-08 ? I'm trying to find out if there
> > is a dependency on the kernel version, and/or the Adeos release, and/or
> > the fpu issue, for the segfault bug. TIA,
> 
> I just tested two more builds.  Both of them have the segfault bug.  Here is a summary of the results thus far:
> 
> Latency test works:
>   linux-2.4.32, adeos-ipipe-2.4.32-i386-1.2-07.patch
> 
> Latency test segfaults:
>   linux-2.4.33.3, adeos-ipipe-2.4.33-i386-1.3-00.patch
>   linux-2.4.33.3, adeos-ipipe-2.4.33-i386-1.2-07.patch
>   linux-2.4.33.3 (+ FPU fix patch), adeos-ipipe-2.4.33-i386-1.3-00.patch
> 
> All of these are with xenomai-2.2.3.  The last one has the FPU fix patch applied.  So, it appears to be something in the newer kernel version...
> 

Ok, that helps thanks. Now, running the latency test over GDB instead of
using the "run" script would likely give us a backtrace for the
segfault. I'd be interested to know where the latency application is
sent the fault signal. E.g.

modprobe xeno_nucleus
modprobe xeno_native
(if needed)

then,

cd /usr/xenomai/testsuite/latency
gdb latency
r
...(SIGSEGV)...
bt

TIA,

> Thanks,
> 
> Jeff
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



