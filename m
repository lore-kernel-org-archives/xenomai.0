Subject: Re: [Xenomai-help] Oops on PPC405EP
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E9A3CF.6090405@domain.hid>
References: <44E9A3CF.6090405@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 14:57:43 +0200
Message-Id: <1156165063.4402.56.camel@domain.hid>
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
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 14:15 +0200, Dirk Eibach wrote:
> Oops: Exception in kernel mode, sig: 4 [#1]
> NIP: C016772C LR: C003C7B0 SP: C1A19E50 REGS: c1a19da0 TRAP: 0700
> Not tainted
> MSR: 0002b030 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
> TASK = c1a10b60[500] 'sampling-497' THREAD: c1a18000
> Last syscall: 50332203
> GPR00: C1A10D48 C1A19E50 C1A10B60 C1A10D48 C0005940 0002B030 0007C45F
> C1A10B5F
> GPR08: 00000001 00400000 00000001 C0260040 00000000 10020184 01FEF400
> 00000000
> GPR16: 00000001 FFFFFFFF 00000000 00000000 0FFAC420 00000000 C1A19F50
> C021C420
> GPR24: 0000000E C0250000 C0260000 00000000 00000018 C0261350 C0362768
> C0261380
> Call trace: [c00421fc]  [c0042668]  [c0043530]  [c0035708]  [c000b418]
> [c0002bf4]
> 

Oops indeed. Could you objdump the kernel, and locate the symbols close
to the addresses 0xC016772C and 0xC003C7B0? TIA,

-- 
Philippe.



