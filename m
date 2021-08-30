Subject: Re: [PATCH 0/3] add support for cherryview gpio controller driver
References: <20210830064527.18206-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bdf39dd6-fc39-e4b7-3159-87bc86269014@siemens.com>
Date: Mon, 30 Aug 2021 09:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <20210830064527.18206-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 30.08.21 08:45, Hongzhan Chen via Xenomai wrote:
> 1. move out of OF config conditional compilation so that non-OF platform
>   call same API to remove rtdm gpio chip device.
> 2. Introduce helper to find gpiochip as referring to pair of 
>    rtdm_gpiochip_scan_of and rtdm_gpiochip_scan_array_of. 
> 3. Add Intel Cherryview pinctrl driver based on on 1 and 2.
> 

Looks good, except for that naming issue.

> I also did following tests with this patchset:
> 1. run /usr/lib/xenomai/testsuite/gpiobench -i 334 -i 335 -c INT33FF:02
>    to validate patch 9afea5ff2d7ba97db96b22a005a9a7fcf5f2d892 when
>    setting GPIO_RTIOC_TS
> 2. apply following patch, and rerun 1.
> 
> index f83d7689f..50afbd418 100644
> --- a/testsuite/gpiobench/gpiobench.c
> +++ b/testsuite/gpiobench/gpiobench.c
> @@ -619,7 +619,7 @@ int main(int argc, char **argv)
>                         goto out;
>                 }
> 
> -               ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS, &value);
> +               ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS_MONO, &value);
>                 if (ret) {
>                         printf("ioctl gpio port ts, failed\n");
>                         goto out;
> 
> Hardware env:
> 1. Rock PI X V1.4.
> 2. GPIO loopback connection between GPIO 334 and 335.
>  

Did you check if timestamps are as expected (different)?

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

