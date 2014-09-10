Message-ID: <5410AAD6.3050808@xenomai.org>
Date: Wed, 10 Sep 2014 21:47:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>	<CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>	<CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>	<5357C92F.2060206@xenomai.org>	<CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>	<535828F6.6050308@xenomai.org>	<CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>	<53583DF7.3080700@xenomai.org>	<CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>	<CAPRPZsAyTQN936=phnT+NzvT7w_UxnY1ppQDucCjh39neOYn6g@mail.gmail.com>	<CAPRPZsB4+68QpNZ7sBCa6-wssNizkrBpG7vB_6q-cJXvCzkihg@mail.gmail.com>	<CAPRPZsCji_p56+CC+a6ueywq39piA=70RaTPP3Xtz62NL_nhcQ@mail.gmail.com>	<540F6B15.2070201@xenomai.org>
 <CAPRPZsCHZKW8kpGgacM3dtiF9UOU5+PsHP=L+L_ZMM1YbYWPxQ@mail.gmail.com>
In-Reply-To: <CAPRPZsCHZKW8kpGgacM3dtiF9UOU5+PsHP=L+L_ZMM1YbYWPxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/10/2014 03:50 PM, Jeroen Van den Keybus wrote:
> Hi Gilles,
> 
> 
> 
>> Answering with a "little" delay, could you try the following patch?
>>
> 
> No problem. And we understand you are busy.
> 
> The tests below consist of running ./latency at 10 kHz and continuously
> open, read and close /proc/xenomai/stat. We can read at about 200 Hz. We
> let it cook for 10 minutes.
> 
> To verify, we tested again without the patch (problems after one sec
> already, so we stopped this):
> 
> == Sampling period: 100 us
> 
> == Test mode: periodic user-mode task
> 
> == All results in microseconds
> 
> warming up...
> 
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> 
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> 
> RTD|      0.725|      0.956|      1.524|       0|     0|      0.725|
> 1.524
> 
> RTD|      0.782|      0.936|      1.482|       0|     0|      0.725|
> 1.524
> 
> RTD|      0.886|      0.936|      1.750|       0|     0|      0.725|
> 1.750
> 
> RTD|      0.886|      2.355|    546.854|       5|     0|      0.725|
> 546.854
> 
> RTD|      1.253|      4.380|    629.025|      15|     0|      0.725|
> 629.025
> 
> RTD|      1.292|      4.348|    578.529|      19|     0|      0.725|
>  629.025
> 
> RTD|      1.287|      4.375|    662.344|      27|     0|      0.725|
> 662.344
> 
> RTD|      1.265|      4.372|    369.331|      35|     0|      0.725|
> 662.344
> 
> 
> And with the patch (same conditions for 10 minutes):
> 
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> 
> RTD|      1.152|      1.230|      1.889|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.054|      1.231|      1.824|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.148|      1.229|      1.775|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.057|      1.231|      1.782|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.150|      1.231|      1.786|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.045|      1.230|      1.888|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.151|      1.231|      1.761|       0|     0|      0.547|
> 2.591
> 
> RTD|      0.999|      1.230|      2.049|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.148|      1.231|      1.818|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.031|      1.231|      1.784|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.149|      1.231|      1.818|       0|     0|      0.547|
> 2.591
> 
> RTD|      0.832|      1.228|      1.976|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.149|      1.226|      1.805|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.025|      1.225|      1.842|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.150|      1.225|      1.795|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.053|      1.225|      1.774|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.150|      1.226|      1.876|       0|     0|      0.547|
> 2.591
> 
> RTD|      0.910|      1.225|      2.205|       0|     0|      0.547|
> 2.591
> 
> RTD|      1.149|      1.225|      1.819|       0|     0|      0.547|
> 2.591
> 
> RTD|      0.716|      1.225|      1.774|       0|     0|      0.547|
> 2.591
> 
> RTD|      0.873|      1.225|      1.925|       0|     0|      0.547|
> 2.591
> 
> RTT|  00:09:49  (periodic user-mode task, 100 us period, priority 99)
> 
> 
> 
> We also checked the kernel performance without reading stat:
> 
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> 
> RTD|      0.906|      0.917|      1.377|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.916|      1.501|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.916|      1.357|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.960|      1.395|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.594|      0.916|      1.349|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.917|      1.364|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.916|      1.331|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.917|      1.333|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.846|      0.954|      1.363|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.917|      1.369|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.917|      1.365|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.917|      1.341|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.917|      1.354|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.957|      1.340|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.917|      1.380|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.918|      1.356|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.917|      1.339|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.905|      0.917|      1.331|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.955|      1.376|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.906|      0.917|      1.353|       0|     0|      0.494|
> 2.600
> 
> RTD|      0.604|      0.916|      1.379|       0|     0|      0.494|
> 2.600
> 
> RTT|  00:10:10  (periodic user-mode task, 100 us period, priority 99)
> 
> 
> 
> You can clearly observe an increase of the average latency (about 300 ns),
> but the worst case latency isn't necessarily worse.
> 
> Obviously the patch works. Thanks !
> 
> Do I understand correctly that currently a flag (lock) set on one CPU isn't
> observable by another CPU (due to e.g. cache) ?

Currently, freeing the lock is not perceived immediately by the cpus
waiting for the lock, that is because the lock is freed with atomic_set,
which does not contain a barrier. The lock, however, is locked with
atomic_cmpxchg, which is a full barrier, so, there is no way a locked
lock can be perceived as free.

That accountfs for the barriers in xnlock_put and __xnlock_spin. However
these two barriers do not seem to be sufficient to avoid the issue
completely, either busy sleeping in the snapshot code, or putting a
barrier in front of the cmpxchg in the xlock_get code seems to be
necessary. I have chosen the latter, because it has a smaller impact
than the former, but I am not entirely satisfied (busy sleeping is a bit
ugly).

-- 
                                                                Gilles.

