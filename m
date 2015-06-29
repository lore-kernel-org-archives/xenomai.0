Date: Mon, 29 Jun 2015 21:45:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150629194514.GC10993@hermes.click-hack.org>
References: <55919C0F.7020000@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55919C0F.7020000@laposte.net>
Subject: Re: [Xenomai] Arietta (AT91SAM9G25),
 strange kernel messages (3.0-rc5)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc Le Douarain <marc.le-douarain@laposte.net>
Cc: Xenomai@xenomai.org

On Mon, Jun 29, 2015 at 09:27:11PM +0200, Marc Le Douarain wrote:
> Hello everybody,
> 
> tested Xenomai 3.0-rc5 on the little Arietta (with patch
> ipipe-core-3.18.12-arm-2.patch),
> and even if it seems to work (I-pipe registered and latenty test running),
> theses lines seeems quite suspect :
> 
> NR_IRQS:16 nr_irqs:16 16
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/pm.c:48
> irq_pm_install_action+0x94/0xd0()
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.12-xeno-mld #1
> [<c000dc84>] (unwind_backtrace) from [<c000b9b4>] (show_stack+0x10/0x14)
> [<c000b9b4>] (show_stack) from [<c001671c>] (warn_slowpath_common+0x60/0x80)
> [<c001671c>] (warn_slowpath_common) from [<c0016754>]
> (warn_slowpath_null+0x18/0x1c)
> [<c0016754>] (warn_slowpath_null) from [<c003fc28>]
> (irq_pm_install_action+0x94/0xd0)
> [<c003fc28>] (irq_pm_install_action) from [<c003bcd8>]
> (__setup_irq+0x398/0x4f4)
> [<c003bcd8>] (__setup_irq) from [<c003bef8>]
> (request_threaded_irq+0xc4/0x124)
> [<c003bef8>] (request_threaded_irq) from [<c0526050>]
> (at91sam926x_pit_common_init+0xcc/0x1a0)
> [<c0526050>] (at91sam926x_pit_common_init) from [<c0525f40>]
> (clocksource_of_init+0x44/0x88)
> [<c0525f40>] (clocksource_of_init) from [<c050dae8>]
> (start_kernel+0x240/0x3cc)
> [<c050dae8>] (start_kernel) from [<20008040>] (0x20008040)
> ---[ end trace cb88537fdc8fa200 ]---

Does not the exact same kernel not patched with Xenomai and I-pipe
with the exact same configuration, only without CONFIG_IPIPE and
CONFIG_XENOMAI, have the same problem?

-- 
					    Gilles.
https://click-hack.org

