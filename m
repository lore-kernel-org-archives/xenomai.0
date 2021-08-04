Subject: Re: [PATCH 1/2] testsuite/smokey: net: load rtnet module if it has
 not been loaded
References: <20210804024714.665-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6600245f-5b05-6ed1-6a53-78551ac29f52@siemens.com>
Date: Wed, 4 Aug 2021 12:17:48 +0200
MIME-Version: 1.0
In-Reply-To: <20210804024714.665-1-hongzhan.chen@intel.com>
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

On 04.08.21 04:47, Hongzhan Chen via Xenomai wrote:
> Before checking net config, rtnet should be ready.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
> index 1badabdfb..719d8175f 100644
> --- a/testsuite/smokey/net_common/setup.c
> +++ b/testsuite/smokey/net_common/setup.c
> @@ -408,6 +408,14 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
>  	struct sockaddr_in *in_peer = vpeer;
>  	struct sockaddr *peer = vpeer;
>  
> +	err = access("/dev/rtnet", F_OK);

Not needed. smokey_net_modprobe() checks /proc/modules and loads only if
the module is missing.

> +	if (err) {
> +		/* device does not exist and load rtnet*/
> +		err = smokey_net_modprobe(MODID_RTNET);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
>  			&net_config, sizeof(net_config));
>  	if (err == -EINVAL)
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

