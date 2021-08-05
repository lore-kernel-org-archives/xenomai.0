Subject: Re: [PATCH V2] testsuite/smokey: net: load rtnet module if it has not
 been loaded
References: <20210805031327.10873-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <06d98602-f257-518c-aac2-8f4378ac14bc@siemens.com>
Date: Thu, 5 Aug 2021 07:00:38 +0200
MIME-Version: 1.0
In-Reply-To: <20210805031327.10873-1-hongzhan.chen@intel.com>
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

On 05.08.21 05:13, Hongzhan Chen via Xenomai wrote:
> Before checking net config, rtnet should be ready.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
> index 1badabdfb..a0512b00d 100644
> --- a/testsuite/smokey/net_common/setup.c
> +++ b/testsuite/smokey/net_common/setup.c
> @@ -408,6 +408,10 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
>  	struct sockaddr_in *in_peer = vpeer;
>  	struct sockaddr *peer = vpeer;
>  
> +	err = smokey_net_modprobe(MODID_RTNET);
> +	if (err < 0)
> +		return err;
> +
>  	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
>  			&net_config, sizeof(net_config));
>  	if (err == -EINVAL)
> 

Sorry, only realized now: The checks that come right after this should
not be affected by rtnet being loaded or not yet. I think they check
whether it is configured and could be loaded. If we try to load when it
is not configured, the test case will fail rather than be skipped.
Please check and reorder the modprobe accordingly.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

