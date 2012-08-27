From: Paul <paul_c@tuxcnc.org>
Date: Mon, 27 Aug 2012 23:22:05 +0100
References: <201208262252.27556.paul_c@tuxcnc.org>
	<503B637F.4060302@xenomai.org>
In-Reply-To: <503B637F.4060302@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201208272322.05160.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] oops on ARM1176 SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Monday 27 August 2012, Gilles Chanteperdrix wrote:
> Please try the following patch:
> diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
> index 5eb7c52..052fcb5 100644
> --- a/ksrc/nucleus/module.c
> +++ b/ksrc/nucleus/module.c
> @@ -92,8 +92,19 @@ static inline void init_hostrt(void)
> =A0=A0=A0=A0=A0=A0=A0=A0nkvdso->hostrt_data.live =3D 0;
> =A0=A0=A0=A0=A0=A0=A0=A0rthal_catch_hostrt(&hostrt_event);
> =A0}
> +
> +static inline void cleanup_hostrt(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0rthal_catch_hostrt(NULL);
> +}
> =A0#else
> -static inline void init_hostrt(void) { }
> +static inline void init_hostrt(void)
> +{
> +}
> +
> +static inline void cleanup_hostrt(void)
> +{
> +}
> =A0#endif /* CONFIG_XENO_OPT_HOSTRT */
>
> =A0MODULE_DESCRIPTION("Xenomai nucleus");
> @@ -235,8 +246,9 @@ int __init __xeno_sys_init(void)
>
> =A0=A0=A0=A0=A0=A0=A0=A0xnpod_umount();
>
> - =A0 =A0 =A0cleanup_arch:
> +=A0=A0=A0=A0=A0=A0=A0cleanup_hostrt();
>
> + =A0cleanup_arch:
> =A0=A0=A0=A0=A0=A0=A0=A0xnarch_exit();
>
> =A0#endif /* __KERNEL__ */
> @@ -261,7 +273,7 @@ void __exit __xeno_sys_exit(void)
>
> =A0=A0=A0=A0=A0=A0=A0=A0xntbase_umount();
> =A0=A0=A0=A0=A0=A0=A0=A0xnpod_umount();
> -
> +=A0=A0=A0=A0=A0=A0=A0cleanup_hostrt();

Did a quick and dirty hack just after you posted your original response,=20
and this one function cured the bug.

> =A0=A0=A0=A0=A0=A0=A0=A0xnarch_exit();
>
> =A0#ifdef __KERNEL__

Reverted my hack and applied your patch, and xeno-nucleus has been=20
running fine all day - The skins on the other hand haven't...
Unloading any of the skins result in the kernel halting. It appears as=20
if it is a deadlock, but I suspect it is timer related - A subject for=20
another thread perhaps.


Regards, Paul.



