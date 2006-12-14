Subject: Re: [Xenomai-core] [RFC][PATCH] kill hard rwlocks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <458038A5.9080508@domain.hid>
References: <458038A5.9080508@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 21:57:35 +0100
Message-Id: <1166129856.23946.169.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Wed, 2006-12-13 at 18:30 +0100, Jan Kiszka wrote:
> Hi,
> 
> at the risk of overseeing some valid use case, I'm proposing to get rid
> of the hard rw-spinlocks in both Xenomai and I-pipe. Find attached
> patches to convert the only user, the IRQ shield, to a spinlock and
> remove the related wrappings in the HAL and in I-pipe.

I'm not fundamentally opposed since this removes the need for ironed
rwlock support, but we need some figures about the impact of replacing
the readlock by a spinlock when engaging the interrupt shield on large
SMP systems. I'm queuing this for now. Thanks.

> 
> Jan
> plain text document attachment (convert-shield-lock.patch)
> ---
>  include/asm-generic/hal.h |   23 ++++++-----------------
>  ksrc/nucleus/shadow.c     |   12 ++++++------
>  2 files changed, 12 insertions(+), 23 deletions(-)
> 
> Index: xenomai/include/asm-generic/hal.h
> ===================================================================
> --- xenomai.orig/include/asm-generic/hal.h
> +++ xenomai/include/asm-generic/hal.h
> @@ -84,24 +84,18 @@
>  
>  typedef struct ipipe_domain rthal_pipeline_stage_t;
>  
> -#ifdef IPIPE_RW_LOCK_UNLOCKED
> +#ifdef IPIPE_SPIN_LOCK_UNLOCKED
>  typedef ipipe_spinlock_t rthal_spinlock_t;
>  #define RTHAL_SPIN_LOCK_UNLOCKED IPIPE_SPIN_LOCK_UNLOCKED
> -typedef ipipe_rwlock_t rthal_rwlock_t;
> -#define RTHAL_RW_LOCK_UNLOCKED   IPIPE_RW_LOCK_UNLOCKED
> -#else /* !IPIPE_RW_LOCK_UNLOCKED */
> -#ifdef RAW_RW_LOCK_UNLOCKED
> +#else /* !IPIPE_SPIN_LOCK_UNLOCKED */
> +#ifdef RAW_SPIN_LOCK_UNLOCKED
>  typedef raw_spinlock_t rthal_spinlock_t;
>  #define RTHAL_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
> -typedef raw_rwlock_t rthal_rwlock_t;
> -#define RTHAL_RW_LOCK_UNLOCKED RAW_RW_LOCK_UNLOCKED
> -#else /* !RAW_RW_LOCK_UNLOCKED */
> +#else /* !RAW_SPIN_LOCK_UNLOCKED */
>  typedef spinlock_t rthal_spinlock_t;
>  #define RTHAL_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
> -typedef rwlock_t rthal_rwlock_t;
> -#define RTHAL_RW_LOCK_UNLOCKED RW_LOCK_UNLOCKED
> -#endif /* RAW_RW_LOCK_UNLOCKED */
> -#endif /* IPIPE_RW_LOCK_UNLOCKED */
> +#endif /* !RAW_SPIN_LOCK_UNLOCKED */
> +#endif /* !IPIPE_SPIN_LOCK_UNLOCKED */
>  
>  #define rthal_irq_cookie(ipd,irq)	__ipipe_irq_cookie(ipd,irq)
>  #define rthal_irq_handler(ipd,irq)	__ipipe_irq_handler(ipd,irq)
> @@ -131,11 +125,6 @@ typedef rwlock_t rthal_rwlock_t;
>  #define rthal_local_irq_disable_hw()	local_irq_disable_hw()
>  #define rthal_local_irq_flags_hw(x)	local_save_flags_hw(x)
>  
> -#define rthal_write_lock(lock)	write_lock_hw(lock)
> -#define rthal_write_unlock(lock)	write_unlock_hw(lock)
> -#define rthal_read_lock(lock)		read_lock_hw(lock)
> -#define rthal_read_unlock(lock)	read_unlock_hw(lock)
> -
>  #ifdef spin_lock_hw
>  #define rthal_spin_lock_init(lock)	spin_lock_init(lock)
>  #define rthal_spin_lock(lock)		spin_lock_hw(lock)
> Index: xenomai/ksrc/nucleus/shadow.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/shadow.c
> +++ xenomai/ksrc/nucleus/shadow.c
> @@ -295,7 +295,7 @@ static rthal_pipeline_stage_t irq_shield
>  
>  static cpumask_t shielded_cpus, unshielded_cpus;
>  
> -static rthal_rwlock_t shield_lock = RTHAL_RW_LOCK_UNLOCKED;
> +static rthal_spinlock_t shield_lock = RTHAL_SPIN_LOCK_UNLOCKED;
>  
>  static inline void engage_irq_shield(void)
>  {
> @@ -307,13 +307,13 @@ static inline void engage_irq_shield(voi
>  	if (xnarch_cpu_test_and_set(cpuid, shielded_cpus))
>  		goto unmask_and_exit;
>  
> -	rthal_read_lock(&shield_lock);
> +	rthal_spin_lock(&shield_lock);
>  
>  	xnarch_cpu_clear(cpuid, unshielded_cpus);
>  
>  	xnarch_lock_xirqs(&irq_shield, cpuid);
>  
> -	rthal_read_unlock(&shield_lock);
> +	rthal_spin_unlock(&shield_lock);
>  
>        unmask_and_exit:
>  
> @@ -330,7 +330,7 @@ static void disengage_irq_shield(void)
>  	if (xnarch_cpu_test_and_set(cpuid, unshielded_cpus))
>  		goto unmask_and_exit;
>  
> -	rthal_write_lock(&shield_lock);
> +	rthal_spin_lock(&shield_lock);
>  
>  	xnarch_cpu_clear(cpuid, shielded_cpus);
>  
> @@ -339,7 +339,7 @@ static void disengage_irq_shield(void)
>  	   (i.e. if no CPU asked for shielding). */
>  
>  	if (!cpus_empty(shielded_cpus)) {
> -		rthal_write_unlock(&shield_lock);
> +		rthal_spin_unlock(&shield_lock);
>  		goto unmask_and_exit;
>  	}
>  
> @@ -360,7 +360,7 @@ static void disengage_irq_shield(void)
>  	}
>  #endif /* CONFIG_SMP */
>  
> -	rthal_write_unlock(&shield_lock);
> +	rthal_spin_unlock(&shield_lock);
>  
>  	rthal_stage_irq_enable(&irq_shield);
>  
> plain text document attachment (remove-rwlocks.patch)
> ---
>  include/linux/ipipe.h |   43 -------------------------------------------
>  lib/spinlock_debug.c  |   18 ------------------
>  2 files changed, 61 deletions(-)
> 
> Index: linux-2.6.19-ipipe/include/linux/ipipe.h
> ===================================================================
> --- linux-2.6.19-ipipe.orig/include/linux/ipipe.h
> +++ linux-2.6.19-ipipe/include/linux/ipipe.h
> @@ -229,49 +229,6 @@ do { \
>  	} \
>  } while(0)
>  
> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> -#define write_lock_hw(x)		__raw_write_lock(&(x)->raw_lock)
> -#define write_trylock_hw(x)		__raw_write_trylock(&(x)->raw_lock)
> -#define write_unlock_hw(x)		__raw_write_unlock(&(x)->raw_lock)
> -#define read_lock_hw(x)		__raw_read_lock(&(x)->raw_lock)
> -#define read_trylock_hw(x)		__raw_read_trylock(&(x)->raw_lock)
> -#define read_unlock_hw(x)		__raw_read_unlock(&(x)->raw_lock)
> -#else /* UP non-debug */
> -#define write_lock_hw(lock)		do { (void)(lock); } while (0)
> -#define write_trylock_hw(lock)	({ (void)(lock); 1; })
> -#define write_unlock_hw(lock)		do { (void)(lock); } while (0)
> -#define read_lock_hw(lock)		do { (void)(lock); } while (0)
> -#define read_trylock_hw(lock)		({ (void)(lock); 1; })
> -#define read_unlock_hw(lock)		do { (void)(lock); } while (0)
> -#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
> -
> -typedef rwlock_t			ipipe_rwlock_t;
> -#define IPIPE_RW_LOCK_UNLOCKED		RW_LOCK_UNLOCKED
> -
> -#define read_lock_irqsave_hw(lock, flags)	\
> -do {						\
> -	local_irq_save_hw(flags);		\
> -	read_lock_hw(lock);			\
> -} while (0)
> -
> -#define read_unlock_irqrestore_hw(lock, flags)	\
> -do {						\
> -	read_unlock_hw(lock);			\
> -	local_irq_restore_hw(flags);		\
> -} while (0)
> -
> -#define write_lock_irqsave_hw(lock, flags)	\
> -do {						\
> -	local_irq_save_hw(flags);		\
> -	write_lock_hw(lock);			\
> -} while (0)
> -
> -#define write_unlock_irqrestore_hw(lock, flags)	\
> -do {						\
> -	write_unlock_hw(lock);			\
> -	local_irq_restore_hw(flags);		\
> -} while (0)
> -
>  DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
>  
>  extern struct ipipe_domain ipipe_root;
> Index: linux-2.6.19-ipipe/lib/spinlock_debug.c
> ===================================================================
> --- linux-2.6.19-ipipe.orig/lib/spinlock_debug.c
> +++ linux-2.6.19-ipipe/lib/spinlock_debug.c
> @@ -129,8 +129,6 @@ void _raw_spin_lock(spinlock_t *lock)
>  	debug_spin_lock_after(lock);
>  }
>  
> -EXPORT_SYMBOL(_raw_spin_lock);
> -
>  int _raw_spin_trylock(spinlock_t *lock)
>  {
>  	int ret = __raw_spin_trylock(&lock->raw_lock);
> @@ -146,16 +144,12 @@ int _raw_spin_trylock(spinlock_t *lock)
>  	return ret;
>  }
>  
> -EXPORT_SYMBOL(_raw_spin_trylock);
> -
>  void _raw_spin_unlock(spinlock_t *lock)
>  {
>  	debug_spin_unlock(lock);
>  	__raw_spin_unlock(&lock->raw_lock);
>  }
>  
> -EXPORT_SYMBOL(_raw_spin_unlock);
> -
>  static void rwlock_bug(rwlock_t *lock, const char *msg)
>  {
>  	if (!debug_locks_off())
> @@ -201,8 +195,6 @@ void _raw_read_lock(rwlock_t *lock)
>  	__raw_read_lock(&lock->raw_lock);
>  }
>  
> -EXPORT_SYMBOL(_raw_read_lock);
> -
>  int _raw_read_trylock(rwlock_t *lock)
>  {
>  	int ret = __raw_read_trylock(&lock->raw_lock);
> @@ -216,16 +208,12 @@ int _raw_read_trylock(rwlock_t *lock)
>  	return ret;
>  }
>  
> -EXPORT_SYMBOL(_raw_read_trylock);
> -
>  void _raw_read_unlock(rwlock_t *lock)
>  {
>  	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
>  	__raw_read_unlock(&lock->raw_lock);
>  }
>  
> -EXPORT_SYMBOL(_raw_read_unlock);
> -
>  static inline void debug_write_lock_before(rwlock_t *lock)
>  {
>  	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
> @@ -283,8 +271,6 @@ void _raw_write_lock(rwlock_t *lock)
>  	debug_write_lock_after(lock);
>  }
>  
> -EXPORT_SYMBOL(_raw_write_lock);
> -
>  int _raw_write_trylock(rwlock_t *lock)
>  {
>  	int ret = __raw_write_trylock(&lock->raw_lock);
> @@ -300,12 +286,8 @@ int _raw_write_trylock(rwlock_t *lock)
>  	return ret;
>  }
>  
> -EXPORT_SYMBOL(_raw_write_trylock);
> -
>  void _raw_write_unlock(rwlock_t *lock)
>  {
>  	debug_write_unlock(lock);
>  	__raw_write_unlock(&lock->raw_lock);
>  }
> -
> -EXPORT_SYMBOL(_raw_write_unlock);
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



