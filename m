Message-ID: <4438D698.1020104@domain.hid>
Date: Sun, 09 Apr 2006 11:40:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ - now traced with kgdb :)
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>	<4433C087.3020403@domain.hid>	<44341AE6.5030804@domain.hid>	<44343CF6.4090500@domain.hid>	<44352E12.1000502@domain.hid>
	<443533E3.6080305@domain.hid>	<4435363B.50701@domain.hid>
	<443537C5.1080801@domain.hid>	<44354CC5.8080405@domain.hid>
	<443662DE.8020804@domain.hid> <44369320.6030406@domain.hid>
	<443695BB.6030502@domain.hid> <4436A8D2.2060603@domain.hid>
In-Reply-To: <4436A8D2.2060603@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> 
> 
> Yep, I dug deeper meanwhile and also came across this.
> 
> I already have a trivial hack running here. The most tricky part for me
> was to learn quilt, but now I start to love it :). Here is a snapshot
> series for 2.6.15.5:
> 
> <kgdb series from CVS>
> prepare-ipipe-x86.patch
> adeos-ipipe-2.6.15-i386-1.2-01.patch
> kgdb-ipipe-x86.patch
>

In order to ease patch maintenance, we should move the relevant portions 
of this infrastructure to the I-pipe patch directly (i.e. I-pipe 
specific kgdb-ipipe-* code).

> I'm currently wondering if it makes sense to register a kgdb domain and
> "officially" capture all involved IRQs and events. So far the serial
> line IRQ is hard-coded (should be retrieved from some internal kgdb
> structure later). Anyway, it seems to work quite well, I'm currently
> stepping through a network IRQ at ipipe-level.
> 

Having a separate domain would allow to break into any runaway code from 
lower priority domains even with disabled interrupts, except the ipipe 
itself. This said, pushing a domain on top of Xenomai would break the 
assumption that hw interrupts are indeed disabled when operating due to 
the 'last domain optimization' feature, and introduce additional 
jittery. The other option would be to install a KGDB 'redirector' in 
__ipipe_handle_irq so that serial or network interrupts to KGDB would 
never be blocked by the stall bit; I would actually prefer this one.

> 
> While playing with this tool a bit, displaying the the ipipe structures,
> and thinking about the original problem again, I wondered what could
> cause a temporary (as I think to found out now) stalled xeno domain
> without locking up the system? Some irq-lock leaks at driver level (i.e.
> inside our own code)?
> 

At first sight, it might be related to the way __ipipe_unstall_iret_root 
operates. Basically, the idea is to make sure that the stall flag of the 
root domain upon return from the pipelining process always reflects the 
state of the hw interrupt flag at the time the processed event was taken 
by the CPU. It seems that your testcase shows that under some 
cicumstances, the root stage might be spuriously left in a stalled state 
by __ipipe_unstall_iret_root.

-- 

Philippe.

