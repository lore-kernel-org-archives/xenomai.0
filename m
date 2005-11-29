From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17292.17415.406282.867476@domain.hid>
Date: Tue, 29 Nov 2005 13:05:27 +0100
Subject: Re: [Xenomai-core] NMI-WD dependencies
In-Reply-To: <438C40AC.5020800@domain.hid>
References: <438C40AC.5020800@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi,
 > 
 > what precisely are the requirements to build Xenomai's NMU watchdog?
 > Something like
 > 
 > "depends on X86_LOCAL_APIC || X86_VISWS_APIC"?
 > 
 > Please add the correct dependency to the build system to avoid
 > compilation errors like I just got after switching off the UP_APIC and
 > forgetting the NMI watchdog.

linux/arch/i386/kernel/nmi.o depends only on X86_LOCAL_APIC. Xenomai NMI
watchdog dependency is now fixed in the repository.

-- 


					    Gilles Chanteperdrix.

