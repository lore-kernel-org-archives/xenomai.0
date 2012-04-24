Message-ID: <4F965FB0.7030609@domain.hid>
Date: Tue, 24 Apr 2012 10:09:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F965F04.3060403@domain.hid>
In-Reply-To: <4F965F04.3060403@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 1/3] Fix hwtimer_uaccess in IMX architecture
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <michael@domain.hid>
Cc: Adeos <adeos-main@gna.org>, b.morelli@domain.hid

On 04/24/2012 10:06 AM, Michael Trimarchi wrote:
> Fix the code for IMX architectures in order to call the software
> workaround to clear the off platform peripheral modules Supervisor
> Protect clear the off platform peripheral modules Supervisor Protect
> bit for the SDMA to access them.
> 
> Signed-off-by: Michael Trimarchi <michael@domain.hid>
> Signed-off-by: Bruno Morelli <b.morelli@domain.hid>
> ---
>  arch/arm/plat-mxc/devices.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
> index 253b711..a2c0e66 100644
> --- a/arch/arm/plat-mxc/devices.c
> +++ b/arch/arm/plat-mxc/devices.c
> @@ -93,19 +93,19 @@ err:
>  
>  static int post_cpu_init(void)
>  {
> -#ifdef CONFIG_MACH_MX27
> +#ifdef CONFIG_ARCH_MX27

What kernel version are we talking about? In version 3.2.1, MACH_MX27 is
still there and has not been replacced with ARCH_MX27

-- 
                                                                Gilles.

