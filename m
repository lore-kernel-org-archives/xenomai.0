Message-ID: <445613AE.7000902@domain.hid>
Date: Mon, 01 May 2006 15:57:02 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] UVM build error in todays head of SVN
References: <4455E3D4.8060007@domain.hid> <4455E720.70509@domain.hid>
In-Reply-To: <4455E720.70509@domain.hid>
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
> Wolfgang Grandegger wrote:
> 
>>Hello,
>>
>>I just checked out Xenomai and realized the UVM build error below (while
>>building for PPC 405 with IPIPE tracer).  "xnlock_put/get" seems not to
>>be dummy without SMP.
>>
>>Wolfgang.
>>
> 
> 
> Try this patch. It fixes the problem and also appears to me as the
> correct way to solve it (UVM is a UP-machine, spinlocks are void).
> 
> Jan
> 
> 
> --- include/asm-uvm/system.h    (Revision 1022)
> +++ include/asm-uvm/system.h    (Arbeitskopie)
> @@ -67,6 +67,8 @@ typedef unsigned long xnlock_t;
>  #define XNARCH_LOCK_UNLOCKED 0
> 
>  #define xnlock_init(lock)              do { } while(0)
> +#define xnlock_get(lock)               do { } while(0)
> +#define xnlock_put(lock)               do { } while(0)
>  #define xnlock_get_irqsave(lock,x)     ((x) = xnarch_lock_irq())
>  #define xnlock_put_irqrestore(lock,x)  xnarch_unlock_irq(x)
>  #define xnlock_clear_irqoff(lock)      xnarch_lock_irq()
> 
> 

Fixed, thanks.

-- 

Philippe.

