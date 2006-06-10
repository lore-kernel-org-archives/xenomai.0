Message-ID: <448B4204.9050302@domain.hid>
Date: Sun, 11 Jun 2006 00:04:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fix breakage by #1185
References: <448AF8B0.4090505@domain.hid>
In-Reply-To: <448AF8B0.4090505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
> Hi,
> 
> I guess this is more like what check-in #1185 wanted to achieve:
> 
> --- src/skins/vrtx/task.c       (Revision 1186)
> +++ src/skins/vrtx/task.c       (Arbeitskopie)
> @@ -247,5 +247,6 @@ void sc_unlock (void)
>  void sc_delay (long timeout)
>  {
>      XENOMAI_SKINCALL1(__vrtx_muxid,
> -                     __vrtx_delay);
> +                     __vrtx_delay,
> +                     timeout);
>  }
> 
> Jan
> 
> 
> PS: Is this distribution of sc_delay() intended: src/skins/vrtx/task.c
> vs. ksrc/skins/vrtx/time.c?
>

Not really, but I will reorganize this stuff as work progresses on the 
VRTX skin.

> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

