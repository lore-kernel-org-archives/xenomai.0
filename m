From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46ECF430.9000402@domain.hid>
References: <46ECF430.9000402@domain.hid>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 10:14:05 +0200
Message-Id: <1191485645.20623.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] i386: remove another useless hunk
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Sun, 2007-09-16 at 11:15 +0200, Jan Kiszka wrote:
> With the introduction of
> 
> --- a/arch/i386/boot/compressed/Makefile
> +++ b/arch/i386/boot/compressed/Makefile
> @@ -9,6 +9,7 @@
>  EXTRA_AFLAGS   := -traditional
> 
>  LDFLAGS_vmlinux := -T
> +CFLAGS := $(subst -pg,,$(CFLAGS))
>  CFLAGS_misc.o += -fPIC
>  hostprogs-y    := relocs
> 
> quite some time ago the dummy mcount function in compressed/misc.c
> became redundant. Let's remove this dead code.

Merged, thanks.

> 
> Jan
-- 
Philippe.



