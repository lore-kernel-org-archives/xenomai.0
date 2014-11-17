Date: Mon, 17 Nov 2014 11:12:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117101217.GD23508@sisyphus.hd.free.fr>
References: <20141113145115.GD4656@sisyphus.hd.free.fr>
 <37845582.117817940.1415960100507.JavaMail.root@zimbra90-e16.priv.proxad.net>
 <20141114102833.GF4656@sisyphus.hd.free.fr>
 <54690CC9.9070201@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54690CC9.9070201@free.fr>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <tbultel@free.fr>
Cc: nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org

On Sun, Nov 16, 2014 at 09:44:57PM +0100, Thierry Bultel wrote:
> Le 14/11/2014 11:28, Gilles Chanteperdrix a écrit :
> >On Fri, Nov 14, 2014 at 11:15:00AM +0100, tbultel@free.fr wrote:
> >>Gilles, it has taken time (about 3 hours), but I finally got
> >>a backtrace with IPIPE_DEBUG: (I have disabled
> >>CONFIG_IPIPE_TRACE_VMALLOC)
> >
> >Normally CONFIG_IPIPE_TRACE_VMALLOC is required on ARM. kmalloc fails
> >to allocate large enough areas, which causes the kernel to fail booting.
> >
> >>
> >>Before the trace went to the serial console, I saw that there were no more timer irq
> >>on 2 CPUs (my ssh session froze). Some 3 or 4 seconds later it came up.
> >>Not clear to me why there are only 100 points, because I have CONFIG_IPIPE_TRACE_SHIFT=14
> >
> >You have to write the number of back_trace_points you want to
> >/proc/ipipe/trace/back_trace_points
> >
> >Also your trace contains a lot of writing to the console, you should
> >move the ipipe_trace_panic_freeze to before any console output.
> >
> >Also note that the UART being slow, a lot of trace points will take
> >a lot of time to print out.
> >
> >You may want to enable the tracer verbose mode to have the timestamps.
> >
> 
> FYI, the kernel without IPIPE but with the PREEMPT_RT patch freezes
> as well, when flooding with ping, and mostly when started after a
> poweroff.
> I have not been able (yet) to freeze it after a reboot.
> I will consider looking deeper in the bootloader.

Is it still with the 3.0 kernel, or with something more current?

-- 
					    Gilles.

