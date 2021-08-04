Subject: Re: [PATCH 2/2] testsuite/smokey: net_client: skip late packet error
 in vm mode
References: <20210804024714.665-1-hongzhan.chen@intel.com>
 <20210804024714.665-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <28fa1684-0e42-0879-234e-7eec12badf8c@siemens.com>
Date: Wed, 4 Aug 2021 12:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <20210804024714.665-2-hongzhan.chen@intel.com>
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
> In vm mode, skip late packet error in functional test to avoid
> test failure.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
> index d13d72918..752ea55ed 100644
> --- a/testsuite/smokey/net_common/client.c
> +++ b/testsuite/smokey/net_common/client.c
> @@ -204,7 +204,7 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
>  		} while (err != -ETIMEDOUT);
>  	}
>  
> -	if (glost || glate)
> +	if (glost || (!smokey_on_vm && glate))
>  		fprintf(stderr, "RTnet %s test failed", client->name);
>  	if (glost) {
>  		if (glost == limit)
> @@ -214,11 +214,11 @@ static int smokey_net_client_loop(struct smokey_net_client *client)
>  			fprintf(stderr, ", %Lu packets lost (%g %%)",
>  				glost, 100.0 * glost / limit);
>  	}
> -	if (glate)
> +	if (!smokey_on_vm && glate)
>  		fprintf(stderr, ", %Lu overruns", glate);

I think we can keep this report, just not mark the test failed in case
of smokey_on_vm.

>  	if (glost || glate)
>  		fputc('\n', stderr);
> -	err = glost || glate ? -EPROTO : 0;
> +	err = glost || (!smokey_on_vm && glate) ? -EPROTO : 0;
>  
>    err:
>  	sock = smokey_check_errno(__RT(close(sock)));
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

