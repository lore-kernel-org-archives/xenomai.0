From: "Grau, Gunter" <gunter.grau@philips.com>
Subject: RE: [PATCH] ipipe_tsc: Use WRTIE_ONCE for updating last_tsc
Date: Tue, 11 May 2021 14:57:47 +0000
Message-ID: <DB7P122MB01061ED94990DB2540D9E54FF2539@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
References: <20210305082208.18335-1-gunter.grau@philips.com>
In-Reply-To: <20210305082208.18335-1-gunter.grau@philips.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> -----Original Message-----
> From: Gunter Grau <gunter.grau@philips.com>
> Sent: Freitag, 5. M=E4rz 2021 09:22
> To: xenomai@xenomai.org
> Cc: rpm@xenomai.org; Grau, Gunter <gunter.grau@philips.com>
> Subject: [PATCH] ipipe_tsc: Use WRTIE_ONCE for updating last_tsc
>
> The gcc 8.3 compiler generated for the update of the last_tsc
> 8 byte value two store commands (see __ipipe_update_tsc).
>
>         e2500001        subs    r0, r0, #1
>         e5830000        str     r0, [r3]
>         e2c11000        sbc     r1, r1, #0
>         e5831004        str     r1, [r3, #4]
>
> This may lead to wrong reading of the counter in the assembler part
> __ipipe_tsc_get if a CPU core just reads this value when only half of the
> last_tsc field is updated.
>
>         __ipipe_freerunning_32:
>         ldr     r0, .LCfr32_cntr_addr
>         /* User-space entry-point: r0 is the hardware counter virtual add=
ress */
>         myldrd  r2, r3, r1, .LCfr32_last_tsc
>         #ifndef CONFIG_CPU_BIG_ENDIAN
>         /* Little endian */
>         ldr     r0, [r0]
>         cmp     r2, r0
>         adc     r1, r3, #0
>
> The issue can be seen when enabling DEBUG_TIMEKEEPING option in the
> kernel and may lead to a jump backwards in time for the monotonic timer i=
n
> Linux.
>
> WARNING: Underflow in clocksource 'ipipe_tsc' observed, time update
> ignored.
>          Please report this, consider using a different clocksource, if p=
ossible.
>          Your kernel is probably still fine.
>
> Fix this by using the WRITE_ONCE macro to prevent the compiler from
> tearing the write since this fields are accessed from different CPU cores=
.
> After this change the resulting assembler is using a double store command=
,
> which should fix the issue.
>
>         e2506001        subs    r6, r0, #1
>         e2c17000        sbc     r7, r1, #0
>         e1c360f0        strd    r6, [r3]
>
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  arch/arm/kernel/ipipe_tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/ipipe_tsc.c b/arch/arm/kernel/ipipe_tsc.c in=
dex
> 7e58118254b8..6d9e1cefa964 100644
> --- a/arch/arm/kernel/ipipe_tsc.c
> +++ b/arch/arm/kernel/ipipe_tsc.c
> @@ -199,7 +199,7 @@ void __ipipe_tsc_update(void)
>
>         /* Update last_tsc, in order to remain compatible with legacy
>            user-space 32 bits free-running counter implementation */
> -       ipipe_tsc_value->last_tsc =3D __ipipe_tsc_get() - 1;
> +       WRITE_ONCE(ipipe_tsc_value->last_tsc, __ipipe_tsc_get() - 1);
>  }
>  EXPORT_SYMBOL(__ipipe_tsc_get);
>
> --
> 2.17.1
>
>

Hi,

I wanted to ask if someone could have a look on this patch.
I sent 2 patches for the ipipe at this time but did not see any follow ups =
regarding this.

The other one was just a goodie I wondered about while investigating this a=
bove one.

This was really a pain and I wanted to save others from having the same iss=
ues.
The observed issues where haning processes (looping in gettimeofday) or rcu=
_stalls on different cores.

If I see this correct this issue is present in any ipipe patch from xenomai=
 2.6 to 3.1.  I haven't checked older ones.
If the compiler decides to generate such code (which it is allowed to) you =
will see sporadic issues of the same type. Not really reproducible.

So please have a look and take into account to accept this.

Thanks in advance,
Gunter


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

