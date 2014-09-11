Message-ID: <54112EFA.4080901@web.de>
Date: Thu, 11 Sep 2014 07:11:22 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>	<CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>	<CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>	<5357C92F.2060206@xenomai.org>	<CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>	<535828F6.6050308@xenomai.org>	<CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>	<53583DF7.3080700@xenomai.org>	<CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>	<CAPRPZsAyTQN936=phnT+NzvT7w_UxnY1ppQDucCjh39neOYn6g@mail.gmail.com>	<CAPRPZsB4+68QpNZ7sBCa6-wssNizkrBpG7vB_6q-cJXvCzkihg@mail.gmail.com>
 <CAPRPZsCji_p56+CC+a6ueywq39piA=70RaTPP3Xtz62NL_nhcQ@mail.gmail.com>
 <540F6B15.2070201@xenomai.org>
In-Reply-To: <540F6B15.2070201@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-09-09 23:03, Gilles Chanteperdrix wrote:
> On 04/25/2014 12:44 PM, Jeroen Van den Keybus wrote:
>> For testing, I've removed the locks from the vfile system. Then the
>> high latencies reliably disappear.
>>
>> To test, I made two xeno_nucleus modules: one with the xnlock_get/put_
>> in place and one with dummies. Subsequently, I use a program that
>> simply opens and reads the stat file 1,000 times.
>>
>> With locks:
>>
>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--la=
t worst
>> RTD|     -2.575|     -2.309|      9.286|       0|     0|     -2.575|    =
  9.286
>> RTD|     -2.364|     -2.276|      1.600|       0|     0|     -2.575|    =
  9.286
>> RTD|     -2.482|     -2.274|      2.165|       0|     0|     -2.575|    =
  9.286
>> RTD|     -2.368|    135.261|   1478.154|   13008|     0|     -2.575|   1=
478.154
>> RTD|     -2.368|     -2.272|      2.602|   13008|     0|     -2.575|   1=
478.154
>> RTD|     -2.499|     -2.272|      6.933|   13008|     0|     -2.575|   1=
478.154
>>
>> Without locks:
>>
>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--la=
t worst
>> RTD|     -2.503|     -2.270|      3.310|       0|     0|     -2.503|    =
  3.310
>> RTD|     -2.418|     -2.284|     -1.646|       0|     0|     -2.503|    =
  3.310
>> RTD|     -2.496|     -2.275|      4.630|       0|     0|     -2.503|    =
  4.630
>> RTD|     -2.374|     -2.285|     -1.458|       0|     0|     -2.503|    =
  4.630
>> RTD|     -2.452|     -2.273|      3.559|       0|     0|     -2.503|    =
  4.630
>> RTD|     -2.370|     -2.285|     -1.518|       0|     0|     -2.503|    =
  4.630
>> RTD|     -2.458|     -2.274|      4.203|       0|     0|     -2.503|    =
  4.630
>>
>> I'll now have a closer look into the vfile system but if the locks are
>> malfunctioning, I'm clueless.
> =

> Answering with a "little" delay, could you try the following patch?
> =

> diff --git a/include/asm-generic/bits/pod.h b/include/asm-generic/bits/po=
d.h
> index a6be0dc..cfb0c71 100644
> --- a/include/asm-generic/bits/pod.h
> +++ b/include/asm-generic/bits/pod.h
> @@ -248,6 +248,7 @@ void __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_C=
ONTEXT_ARGS)
>  			cpu_relax();
>  			xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
>  					    XNLOCK_DBG_PASS_CONTEXT);
> +			xnarch_memory_barrier();
>  		} while(atomic_read(&lock->owner) !=3D ~0);
>  }
>  EXPORT_SYMBOL_GPL(__xnlock_spin);
> diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
> index 25bd83f..7a8c4d0 100644
> --- a/include/asm-generic/system.h
> +++ b/include/asm-generic/system.h
> @@ -378,6 +378,8 @@ static inline void xnlock_put(xnlock_t *lock)
>  	xnarch_memory_barrier();
>  =

>  	atomic_set(&lock->owner, ~0);
> +
> +	xnarch_memory_barrier();

That's pretty heavy-weighted now (it was already due to the first memory
barrier). Maybe it's better to look at some ticket lock mechanism like
Linux uses for fairness. At least on x86 (and other strictly ordered
archs), those require no memory barriers on release.

Jan

>  }
>  =

>  static inline spl_t
> diff --git a/ksrc/nucleus/vfile.c b/ksrc/nucleus/vfile.c
> index c8e0363..066c12f 100644
> --- a/ksrc/nucleus/vfile.c
> +++ b/ksrc/nucleus/vfile.c
> @@ -279,6 +279,15 @@ redo:
>  			data +=3D vfile->datasz;
>  			it->nrdata++;
>  		}
> +#ifdef CONFIG_SMP
> +		{
> +			/* Leave some time for other cpus to get the lock */
> +			xnticks_t wakeup =3D xnarch_get_cpu_tsc();
> +			wakeup +=3D xnarch_ns_to_tsc(1000);
> +			while ((xnsticks_t)(xnarch_get_cpu_tsc() - wakeup) < 0)
> +				cpu_relax();
> +		}
> +#endif
>  	}
>  =

>  	if (ret < 0) {
> =

> =

>>
>>
>> BTW I found that unloading and loading xeno_nucleus didn't work due to
>> a missing rthal_free_ptdkey call in xnshadow_cleanup. I used the
>> following patch to fix that. (The ability to swap out xenomai modules
>> is a real lifesaver when debugging. Thanks!)
>>
>> --- /home/vdkeybus/work/xenomai/ksrc/nucleus/shadow.c   2014-04-16
>> 22:46:19.018851844 +0200
>> +++ shadow.c    2014-04-25 09:43:49.838735832 +0200
>> @@ -3139,6 +3139,8 @@ void xnshadow_cleanup(void)
>>         }
>>
>>         rthal_apc_free(lostage_apc);
>> +
>> +       rthal_free_ptdkey(nkmmptd);
>>         rthal_free_ptdkey(nkerrptd);
>>         rthal_free_ptdkey(nkthrptd);
> =

> Merged, thanks.
> =

> =


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140911/90346dd=
e/attachment.sig>
