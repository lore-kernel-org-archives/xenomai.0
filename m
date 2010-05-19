Message-ID: <4BF3C9D7.8010808@domain.hid>
Date: Wed, 19 May 2010 13:21:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BF3B1F5.6040303@domain.hid>
In-Reply-To: <4BF3B1F5.6040303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] RTDM device profiles: Document open_rt,
 socket_rt and close_rt deprecation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> regards, stefan
> 

Good point.

Thanks,
Jan

> From e8459dc079118f9f635ef31c996019a0652e4907 Mon Sep 17 00:00:00 2001
> From: Stefan Kisdaroczi <kisda@domain.hid>
> Date: Wed, 19 May 2010 11:31:00 +0200
> Subject: [PATCH] RTDM device profiles: Document open_rt, socket_rt and close_rt deprecation
> 
> ---
>  include/rtdm/rtcan.h     |    4 ++--
>  include/rtdm/rtserial.h  |    4 ++--
>  include/rtdm/rttesting.h |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/rtdm/rtcan.h b/include/rtdm/rtcan.h
> index 43399e2..34a2044 100644
> --- a/include/rtdm/rtcan.h
> +++ b/include/rtdm/rtcan.h
> @@ -59,7 +59,7 @@
>   * @par Supported Operations
>   * @n
>   * @b Socket @n
> - * Environments: non-RT (RT optional)@n
> + * Environments: non-RT (RT optional, deprecated)@n
>   * @n
>   * Specific return values:
>   * - -EPROTONOSUPPORT (Protocol is not supported by the driver.
> @@ -72,7 +72,7 @@
>   * Blocking calls to any of the @ref Send or @ref Recv "Receive" functions
>   * will be unblocked when the socket is closed and return with an error. @n
>   * @n
> - * Environments: non-RT (RT optional)@n
> + * Environments: non-RT (RT optional, deprecated)@n
>   * @n
>   * Specific return values: none @n
>   * @n
> diff --git a/include/rtdm/rtserial.h b/include/rtdm/rtserial.h
> index 48712b2..00dc536 100644
> --- a/include/rtdm/rtserial.h
> +++ b/include/rtdm/rtserial.h
> @@ -42,11 +42,11 @@
>   *
>   * @par Supported Operations
>   * @b Open @n
> - * Environments: non-RT (RT optional)@n
> + * Environments: non-RT (RT optional, deprecated)@n
>   * Specific return values: none @n
>   * @n
>   * @b Close @n
> - * Environments: non-RT (RT optional)@n
> + * Environments: non-RT (RT optional, deprecated)@n
>   * Specific return values: none @n
>   * @n
>   * @b IOCTL @n
> diff --git a/include/rtdm/rttesting.h b/include/rtdm/rttesting.h
> index e936630..a3a7ae9 100644
> --- a/include/rtdm/rttesting.h
> +++ b/include/rtdm/rttesting.h
> @@ -43,11 +43,11 @@
>   *
>   * @par Supported Operations
>   * @b Open @n
> - * Environments: non-RT (RT optional)@n
> + * Environments: non-RT (RT optional, deprecated)@n
>   * Specific return values: none @n
>   * @n
>   * @b Close @n
> - * Environments: non-RT (RT optional)@n
> + * Environments: non-RT (RT optional, deprecated)@n
>   * Specific return values: none @n
>   * @n
>   * @b IOCTL @n
> -- 1.7.0.4 

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

