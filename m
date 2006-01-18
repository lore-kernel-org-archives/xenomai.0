Message-ID: <43CEBD90.7080603@domain.hid>
Date: Wed, 18 Jan 2006 23:13:36 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601181204g4c86f778x@domain.hid>	
	<43CEA323.7000701@domain.hid> <43CEAF25.6010705@domain.hid>	
	<43CEB291.4020609@domain.hid>
	<fd6a47a90601181334y14b06d6an@domain.hid>
In-Reply-To: <fd6a47a90601181334y14b06d6an@domain.hid>
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

Jeroen Van den Keybus wrote:
> - Could you replace MAXLONG on line 119 with TM_INFINITE and rerun the 
> sem test (to avoid printf'ing) You can terminate with Ctrl+C.
> - Could you try to run with tmax somewhat lower (to increase the load): 
> e.g. ./sem 5.0e6 or so. Be careful not to starve Linux. I think 1.0e5 
> will be too low.
>  
> Crashes with me happen within the first 10 secs with 1.0e7

On Xeno2.0, kernel 2.6.13.4:

# ./sem 1.0e5
Running for 2.15 seconds.
L119: Operation not permitted.

Kernel.log:
Unable to handle kernel NULL pointer dereference at virtual address 00000114
[freeze]

# ./sem 1.0e4
Running for 2.15 seconds.

Kernel.log:
(sorry no serial console available yet)
...default_idle
...ipipe_supend_domain
...default_idle
...cpu_idle
...start_kernel
...unknown_bootoption
Kernel panic

# ./mutex 1.0e5
ALERT: No lock! (lockcnt=0) Offending task: task0
ALERT: No lock! (lockcnt=0) Offending task: task0
ALERT: No lock! (lockcnt=0) Offending task: task0
[...]
[freeze]

kernel.log:
[off-screen]
...panic
...do_exit
...printk
...die
...__ipipe_sync_stage
...do_page_fault
...__do_softirw
...irq_exit
...do_IRQ
...restore_raw
...__ipipe_handle_exception
...error_code
...__ipipe_sync_stage
...default_idle
...ipipe_supend_domain
...default_idle
...cpu_idle
...start_kernel
...unknown_bootoption
Kernel panic

Best regards,
Hannes.

