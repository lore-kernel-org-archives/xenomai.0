MIME-Version: 1.0
In-Reply-To: <540F6B9D.3020109@xenomai.org>
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
 <53E3CD23.5040909@xenomai.org> <53E3D084.2000506@tuebingen.mpg.de>
 <53E3D2FF.5000407@xenomai.org> <53E3D50D.7060701@tuebingen.mpg.de>
 <53E3D712.3070801@xenomai.org> <web-589558@tuebingen.mpg.de>
 <53E47905.5070402@xenomai.org> <oqoavunbgo.fsf@merlin.sez.to>
 <53E5081C.8050807@xenomai.org> <oqiom2n8ex.fsf@merlin.sez.to>
 <53E7964B.6080200@xenomai.org> <oq8umvm0fr.fsf@merlin.sez.to>
 <53E8FC9C.90508@xenomai.org> <oq38d2ncql.fsf@merlin.sez.to>
 <540F6B9D.3020109@xenomai.org>
Date: Wed, 10 Sep 2014 10:12:38 -0700
Message-ID: <CAMoEH9V2yEvoCEm_R5eGiXtaXFEA8V3hpc=b9cdWmepY+fTheg@mail.gmail.com>
From: Nicholas Rotella <nrotella@usc.edu>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

I work with Alexander Herzog (who started this thread originally) and
Ludovic Righetti.  I just tested this patch on our Xenomai system
(Ubuntu 12.04, linux kernel 3.8.13, Xenomai 2.6.3) and it fixes all of
our problems.  We can now watch in parallel to running the xeno
latency test without observing high latencies.

Thanks!

- Nick

On Tue, Sep 9, 2014 at 2:05 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 08/11/2014 07:43 PM, Paul Janzen wrote:
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
>>
>>> What about combining the 2, like:
>>>
>>>      } else {
>>>              xnarch_memory_barrier();
>>>              cpu_relax();
>>>      }
>>
>> No, this does not help either.
>
>
> Could you try the following patch?
>
> diff --git a/include/asm-generic/bits/pod.h b/include/asm-generic/bits/pod.h
> index a6be0dc..cfb0c71 100644
> --- a/include/asm-generic/bits/pod.h
> +++ b/include/asm-generic/bits/pod.h
> @@ -248,6 +248,7 @@ void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
>                         cpu_relax();
>                         xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
>                                             XNLOCK_DBG_PASS_CONTEXT);
> +                       xnarch_memory_barrier();
>                 } while(atomic_read(&lock->owner) != ~0);
>  }
>  EXPORT_SYMBOL_GPL(__xnlock_spin);
> diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
> index 25bd83f..7a8c4d0 100644
> --- a/include/asm-generic/system.h
> +++ b/include/asm-generic/system.h
> @@ -378,6 +378,8 @@ static inline void xnlock_put(xnlock_t *lock)
>         xnarch_memory_barrier();
>
>         atomic_set(&lock->owner, ~0);
> +
> +       xnarch_memory_barrier();
>  }
>
>  static inline spl_t
> diff --git a/ksrc/nucleus/vfile.c b/ksrc/nucleus/vfile.c
> index c8e0363..066c12f 100644
> --- a/ksrc/nucleus/vfile.c
> +++ b/ksrc/nucleus/vfile.c
> @@ -279,6 +279,15 @@ redo:
>                         data += vfile->datasz;
>                         it->nrdata++;
>                 }
> +#ifdef CONFIG_SMP
> +               {
> +                       /* Leave some time for other cpus to get the lock */
> +                       xnticks_t wakeup = xnarch_get_cpu_tsc();
> +                       wakeup += xnarch_ns_to_tsc(1000);
> +                       while ((xnsticks_t)(xnarch_get_cpu_tsc() - wakeup) < 0)
> +                               cpu_relax();
> +               }
> +#endif
>         }
>
>         if (ret < 0) {
>
>
> --
>                                                                 Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

