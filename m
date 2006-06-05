Message-ID: <44845D59.5040608@domain.hid>
Date: Mon, 05 Jun 2006 18:35:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] nervous nmi-watchdog
References: <44736EE4.2060807@domain.hid>
In-Reply-To: <44736EE4.2060807@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> I'm getting nmi alarms about latency being > 100 us on a dual P-III 1GHz
> (with and without CONFIG_SMP) once I start the latency test tool. But
> the must be false positive. Can someone comment on this trace:
> 

Issue confirmed here, on a dual 750 Mhz PIII Celeron. Starting the 
latency test, the NMI watchdog pulls the break on cpu #0 after a few us, 
albeit rthal_nmi_arm() had been told to trigger the NMI more than a 
millisecond in the future (likely the HTICK emulation + 100 us NMI 
threshold).

Running a UP + LAPIC enabled kernel on the same hw did not trigger the 
spurious NMI, so I'd bet that the issue is SMP related, and not 
hw/perfctr related.

-- 

Philippe.

