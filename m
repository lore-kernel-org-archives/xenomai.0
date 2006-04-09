Message-ID: <44397CBF.905@domain.hid>
Date: Sun, 09 Apr 2006 23:29:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] kgdb over ipipe
References: <44377F75.9030707@domain.hid> <4438FAFA.3020105@domain.hid>
In-Reply-To: <4438FAFA.3020105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Hi,
>>
>>this is the preliminary, though already usable result of my recent
>>effort to extend the tool situation for Xenomai: A kgdb patch series for
>>2.6.15 on x86. It already works quite well but likely does not yet catch
>>all fatal scenarios (e.g. page faults in the Xenomai domain).
>>
> 
> 
> And here comes another revision (prepare patch remains unmodified).
> 
> It gets closer to what Philippe also just suggested in the original
> thread: hook KGDB into I-pipe in favour of registering a dedicated
> domain. The latter approach modifies the I-pipe state in a way which may
> blur the picture of I-pipe itself to the debugger. This revision hooks
> exception events into the I-pipe core so that they are delivered the
> normal way when the root domain is active, but get catched early for
> higher domains like Xenomai. I'm just not sure about the best way to
> handle the serial line IRQ. Philippe, do you see problems with current
> approach? Should we better hook into __ipipe_handle_irq (which would
> make things more complicated, I'm afraid)?
> 

The current approach works fine unless a runaway thread goes wild with 
interrupts disabled (i.e. stall bit set) in the root stage or in any 
higher priority domain regardless of the root domain state, in which 
case the serial IRQ won't make it through the pipeline to KGDB.

> In contrast to the first version, exceptions happening in the Xenomai
> domain now also get reported to KGDB. Debugging mostly works fine, I'm
> just facing unknown problems with intercepting and then continuing
> kernel-only RT threads. KGDB sometimes reports "E22" back in this case,
> but always locks up. Maybe it gets confused by the fact the there is no
> Linux task behind Xenomai kernel threads? I tested this by putting a
> breakpoint into xnpod_suspend_thread and running latency in mode 0 and
> 1. 0 works fine, 1 not.
> 

KGDB is relying on "current", so it's reading garbage over Xenomai's 
kernel threads.

-- 

Philippe.

