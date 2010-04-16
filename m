Message-ID: <4BC85722.3030202@domain.hid>
Date: Fri, 16 Apr 2010 14:25:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1O2jBI-0000y0-DS@xenomai.org>
In-Reply-To: <E1O2jBI-0000y0-DS@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : rttest: Resolved test
 device conflicts via separate name spaces
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: dede8fde31b175ddccaee610b7b0ff21560872a5
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=dede8fde31b175ddccaee610b7b0ff21560872a5
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Sun Apr 11 17:35:51 2010 +0200
> 
> rttest: Resolved test device conflicts via separate name spaces
> 
> Usually, all devices of some RTDM class use the same naming scheme. But
> as test devices are different as they do not provide compatible APIs,
> let's give them separate name space for their device names. That finally
> resolves all the detection troubles that showed up once more than one
> test device was registered.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> ---
> 
>  include/rtdm/rttesting.h              |   10 ++++--
>  ksrc/drivers/testing/irqbench.c       |    4 +-
>  ksrc/drivers/testing/switchtest.c     |    4 +-
>  ksrc/drivers/testing/timerbench.c     |    4 +-
>  src/testsuite/irqbench/irqloop.c      |    3 +-
>  src/testsuite/latency/latency.c       |    2 +-
>  src/testsuite/switchtest/switchtest.c |   50 +++++++-------------------------
>  7 files changed, 27 insertions(+), 50 deletions(-)
> 
> diff --git a/include/rtdm/rttesting.h b/include/rtdm/rttesting.h
> index ce0418e..56df43b 100644
> --- a/include/rtdm/rttesting.h
> +++ b/include/rtdm/rttesting.h
> @@ -29,13 +29,14 @@
>   * Feel free to comment on this profile via the Xenomai mailing list
>   * (xenomai@xenomai.org) or directly to the author (jan.kiszka@domain.hid).
>   *
> - * @b Profile @b Revision: 1
> + * @b Profile @b Revision: 2
>   * @n
>   * @n
>   * @par Device Characteristics
>   * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE @n
>   * @n
> - * @ref rtdm_device.device_name "Device Name": @c "rttest<N>", N >= 0 @n
> + * @ref rtdm_device.device_name "Device Name": @c "rttest[-<subclass>]<N>",
> + * N >= 0, optional subclass name to simplify device discovery @n
>   * @n
>   * @ref rtdm_device.device_class "Device Class": @c RTDM_CLASS_TESTING @n
>   * @n
> @@ -61,7 +62,7 @@
>  
>  #include <rtdm/rtdm.h>
>  
> -#define RTTST_PROFILE_VER		1
> +#define RTTST_PROFILE_VER		2
>  
>  typedef struct rttst_bench_res {
>  	long long avg;
> @@ -145,8 +146,11 @@ struct rttst_swtest_error {
>  /*!
>   * @name Sub-Classes of RTDM_CLASS_TESTING
>   * @{ */
> +/** subclass name: "tmbench" */
>  #define RTDM_SUBCLASS_TIMERBENCH	0
> +/** subclass name: "irqbench" */
>  #define RTDM_SUBCLASS_IRQBENCH		1
> +/** subclass name: "switchtst" */
>  #define RTDM_SUBCLASS_SWITCHTEST	2
>  /** @} */
>  
> diff --git a/ksrc/drivers/testing/irqbench.c b/ksrc/drivers/testing/irqbench.c
> index 3dfb646..db520cb 100644
> --- a/ksrc/drivers/testing/irqbench.c
> +++ b/ksrc/drivers/testing/irqbench.c
> @@ -515,8 +515,8 @@ static int __init __irqbench_init(void)
>  	int err;
>  
>  	do {
> -		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
> -			 start_index);
> +		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN,
> +			 "rttest-irqbench%d", start_index);
>  		err = rtdm_dev_register(&device);
>  
>  		start_index++;
> diff --git a/ksrc/drivers/testing/switchtest.c b/ksrc/drivers/testing/switchtest.c
> index 057094b..47702fc 100644
> --- a/ksrc/drivers/testing/switchtest.c
> +++ b/ksrc/drivers/testing/switchtest.c
> @@ -750,8 +750,8 @@ int __init __switchtest_init(void)
>  	int err;
>  
>  	do {
> -		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rttest%d",
> -			 start_index);
> +		snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN,
> +			 "rttest-switchtst%d", start_index);

Why not rttest-switchtest ?


-- 
					    Gilles.

