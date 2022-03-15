MIME-Version: 1.0
References: <2a90b47a-43ea-5754-aed4-56966388ddc9@siemens.com>
In-Reply-To: <2a90b47a-43ea-5754-aed4-56966388ddc9@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 15 Mar 2022 15:02:09 -0400
Message-ID: <CALLqZ8S4YU5XsF4JwcWZJeq9-eFD0YUw9tc_8=tivNFB1DQi2g@mail.gmail.com>
Subject: Re: [PATCH] arm64: ipipe: Fix section mismatch of __ipipe_tsc_register
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Mar 15, 2022 at 3:00 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The kernel warns:
>
> The function dw_apb_clocksource_register() references
> the function __init __ipipe_tsc_register().
> This is often because dw_apb_clocksource_register lacks a __init
> annotation or the annotation of __ipipe_tsc_register is wrong.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Developed for 5.4 but probably also 4.19 material.
>
>  arch/arm64/kernel/ipipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
> index 9dcb54c636395..a60787230fd84 100644
> --- a/arch/arm64/kernel/ipipe.c
> +++ b/arch/arm64/kernel/ipipe.c
> @@ -228,7 +228,7 @@ void __ipipe_root_sync(void)
>
>  static struct __ipipe_tscinfo tsc_info;
>
> -void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info)
> +void __ipipe_tsc_register(struct __ipipe_tscinfo *info)
>  {
>         tsc_info =3D *info;
>         __ipipe_hrclock_freq =3D info->freq;
> --
> 2.34.1
>
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux


I=E2=80=99ll apply to 5.4 and check it it=E2=80=99s needed for 4.19

-Greg

>
>
