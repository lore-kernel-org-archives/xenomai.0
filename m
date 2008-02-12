Message-ID: <2ff1a98a0802120527r30f1e00ena0417d26e75d3250@domain.hid>
Date: Tue, 12 Feb 2008 14:27:05 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47B17600.4040900@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18350.7135.108901.491437@domain.hid>
	<18351.31369.697255.825404@domain.hid>
	<47AF7F3C.6080805@domain.hid>
	<18352.48401.264561.143362@domain.hid>
	<47B0C7BD.3020609@domain.hid>
	<18352.51397.803115.798009@domain.hid>
	<47B0C9B6.7080207@domain.hid>
	<18352.52347.906633.550225@domain.hid> <47B14C92.204@domain.hid>
	<47B17600.4040900@domain.hid>
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
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
Cc: xenomai@xenomai.org

On Tue, Feb 12, 2008 at 11:33 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>
> >> I also have the choice of defining the service needed
>  >> (rt_dev_select_bind) as a callback in the posix module, the RTDM module
>  >> setting this callback when loaded (like what the rtcap module does with
>  >> rtnet). But I wanted something simple, so I aimed at Kconfig stuff.
>  >>
>  >
>  > If you can live with the callback being NULL, you could also perfectly
>  > wrap some ifdef CONFIG_...RTDM[_MODULE] around the current invocations.
>  > Then you don't need the dependency above. I think I have to look at the
>  > code...
>  >
>
>  I understood the core of your problem meanwhile. Here is a better
>  suggestion:
>
>  Index: ksrc/skins/posix/Kconfig
>  ===================================================================
>  --- ksrc/skins/posix/Kconfig    (Revision 3499)
>  +++ ksrc/skins/posix/Kconfig    (Arbeitskopie)
>  @@ -47,9 +47,15 @@ config XENO_OPT_POSIX_INTR
>         RTDM skin is the preferred way of implementing drivers), leave this
>         option unselected.
>
>  +if XENO_SKIN_RTDM = m && XENO_SKIN_RTDM != XENO_SKIN_POSIX
>  +       comment "Note: Select support only available if the POSIX skin is built"
>  +       comment "as module or the RTDM skin is built into the kernel as well."
>  +endif
>  +
>   config XENO_OPT_POSIX_SELECT
>         bool "Select syscall"
>         select XENO_OPT_SELECT
>  +       depends on XENO_SKIN_RTDM != m || XENO_SKIN_RTDM = XENO_SKIN_POSIX
>         help
>
>         This option allows applications using the Xenomai POSIX skin in
>  @@ -65,10 +71,3 @@ config XENO_OPT_DEBUG_POSIX
>         cleaned up POSIX objects it detects on process termination.
>
>   endif
>  -
>  -if XENO_OPT_POSIX_SELECT && XENO_SKIN_POSIX = y && XENO_SKIN_RTDM = m
>  -       comment "This configuration will not work ! If you enable the POSIX"
>  -       comment "select syscall while the POSIX skin is built-in the kernel,"
>  -       comment "you have to compile the POSIX skin as a module or the RTDM"
>  -       comment "skin built-in the kernel."
>  -endif

This looks much better, thanks, I will use that approach.

-- 
 Gilles Chanteperdrix

