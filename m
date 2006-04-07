Message-ID: <443695BB.6030502@domain.hid>
Date: Fri, 07 Apr 2006 18:39:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>	<4433C087.3020403@domain.hid>	<44341AE6.5030804@domain.hid>	<44343CF6.4090500@domain.hid>	<44352E12.1000502@domain.hid>
	<443533E3.6080305@domain.hid>	<4435363B.50701@domain.hid>
	<443537C5.1080801@domain.hid>	<44354CC5.8080405@domain.hid>
	<443662DE.8020804@domain.hid> <44369320.6030406@domain.hid>
In-Reply-To: <44369320.6030406@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>>
>> BTW, that trace hacking reminds me that we should really think about
>> making a kernel debugger run. I recently noticed that latest kgdb
>> applied with a single failing hunk on top of ipipe (2.6.15, x86). Maybe
>> it is just about making kgdb's irq-locks ipipe-aware and bypassing the
>> ipipe for int3 and the serial IRQ (so that ipipe can be debugged as
>> well) and catching the relevant exceptions. Hmm, the debugger seems to
>> get initialised in the "early" stage. Is this before or after ipipe 
>> setup?
>>
> 
> It depends. If "kgdbwait" is set in the bootargs to halt the kernel 
> waiting for the remote GDB to connect to the target, kgdb starts before 
> the ipipe. Otherwise, it's a late init, and kgdb starts after the ipipe 
> is fully initialized.
> 

Basically, kgdb could start before the i-pipe as soon as a breakpoint is 
hit before the latter is enabled in init/main.c.

-- 

Philippe.

