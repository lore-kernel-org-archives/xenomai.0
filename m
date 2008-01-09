Message-ID: <4784EEF3.2090906@domain.hid>
Date: Wed, 09 Jan 2008 16:57:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <014d01c852bc$5d4bff10$2903050a@domain.hid>
In-Reply-To: <014d01c852bc$5d4bff10$2903050a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Interrupt Sharing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
Cc: xenomai@xenomai.org

kapilkumar.jain wrote:
> Dear Mr. Jan Kiszka
> 
> Long before i have asked solution for Interrupt sharing problem between non real time & real time module,
> as i have found it is difficult to disable the non real time.
> 
> I have found the solution by return RTDM_IRQ_NONE | XN_ISR_PROPAGATE. from the ISR.

That's not a solution, it's a fragile workaround: Your RT device's IRQ
may suffer from priority inversion when an IRQ event for the non-RT side
is pending but cannot be handled timely (due to Linux stalling its IRQs
or some low-prio RT thread is blocking Linux). Then succeeding IRQ
events for the RT side will also have to wait until the non-RT side has
completed its processing.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

