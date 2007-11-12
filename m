Message-ID: <47389B04.7040700@domain.hid>
Date: Mon, 12 Nov 2007 19:27:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <fd6a47a90711120739n11b803cfy8bc4b8b09a995fef@domain.hid>	
	<4738839E.8020203@domain.hid>	
	<fd6a47a90711120911q34d2fba5w22683bd06598b150@domain.hid>	
	<47388CA0.6070405@domain.hid>	
	<fd6a47a90711120936m6c8eb691na49fae868b803470@domain.hid>	
	<4738945D.2030503@domain.hid>
	<fd6a47a90711121010k2fa1f393u10f3692f2a3b4bd7@domain.hid>
In-Reply-To: <fd6a47a90711121010k2fa1f393u10f3692f2a3b4bd7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Long execution time inside
	__ipipe_unstall_iret_root()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: Xenomai-core@domain.hid

Jeroen Van den Keybus wrote:
>> Ouch, this shouldn't be allowed in user space! WBINVD is a privileged
>> instruction. Do we leak privileges to user land??? Please check if your
>> execution mode (privilege ring) is correct there.
> 
> 
> No, I rather meant a kernel-mode program that was controlled from the user
> space. Sorry for upsetting you.

Puh... fine, the world is round again. :)

> 
> But indeed, wbinvd is devastating if you can execute it, causing
>> typically around 300 us latencies, at worst even milliseconds
>> (cache-size and state dependent)!
> 
> 
> If I recall correctly, some of the Linux AGP GART drivers use(d?) it.

Yep, some only require this during setup (while MTRR reconfig e.g.),
others also use it during runtime of X - making your graphical system a
real-time killer.

> 
> This raises another interesting question: to what extent is the x86 actually
> a viable and dependable realtime platform, with its SMI's and highly
> uncontrollable caching architecture ? How would VT-based solutions compare ?

No surprise: x86 is a real-time minefield. Actually, I have been told
that PCI Express also requires cache flushes before starting DMA
transactions, but I haven't checked this yet.

Regarding fun with virtualisation over RT:

http://thread.gmane.org/gmane.comp.emulators.kvm.devel/8520/focus=8540
(There are even more threads about this, and some light at the end of
this tunnel, also for Intel. Check the archive.)

This reminds me that I still need to post my experimental kvm-over-ipipe
patch for VMX (yet Intel only, no AMD at hand :( ).

> (BTW Intel should really have implemented a feature to use parts of the
> cache as SRAM.)

Ack.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

