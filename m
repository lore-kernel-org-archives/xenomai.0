Subject: Re: [PATCH] RTNet builtin kernel - Fix IP protocols
References: <7231-5e86f600-29-3b6a0580@56072459>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c46bad0-be55-14de-0312-66f560bc22bd@siemens.com>
Date: Mon, 6 Apr 2020 07:57:49 +0200
MIME-Version: 1.0
In-Reply-To: <7231-5e86f600-29-3b6a0580@56072459>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 03.04.20 10:37, François Legal via Xenomai wrote:
> From: François LEGAL <devel@thom.fr.eu.org>
> 
> The link order of IP protocols does not allow to do UDP/TCP over IP with RTNet builtin as protocol list gets zeroed by af_inet when initializing

Thanks, applied.

Actually, that rt_inet_protocols clearing in rt_ipv4_proto_init is 
redundant because that variable is global, thus zero-initialized anyway. 
Still, the ordering should be as you patch now put it.

> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> 
> Subject: [PATCH] RTNet builtin kernel - Fix IP protocols

This line is wrong here. The email already carries the subject, and this 
will only show up at the wrong place in the commit log.

Jan

> ---
>   kernel/drivers/net/stack/ipv4/Makefile | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/ipv4/Makefile b/kernel/drivers/net/stack/ipv4/Makefile
> index f0fcd36..7d45d23 100644
> --- a/kernel/drivers/net/stack/ipv4/Makefile
> +++ b/kernel/drivers/net/stack/ipv4/Makefile
> @@ -1,9 +1,5 @@
>   ccflags-y += -Idrivers/xenomai/net/stack/include
>   
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP) += udp/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP) += tcp/
> -
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += rtipv4.o
>   
>   rtipv4-y := \
> @@ -16,4 +12,8 @@ rtipv4-y := \
>   	ip_output.o \
>   	ip_fragment.o
>   
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP) += udp/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP) += tcp/
> +
>   rtipv4-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP) += icmp.o
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

