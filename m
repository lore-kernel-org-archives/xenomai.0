References: <4846b03e4108ca6b4036.1481033769@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5c4d6296-90e8-04af-579c-457cbeb5fcb0@xenomai.org>
Date: Fri, 9 Dec 2016 15:01:39 +0100
MIME-Version: 1.0
In-Reply-To: <4846b03e4108ca6b4036.1481033769@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] psos: add tunables to configure region 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/06/2016 03:16 PM, Ronny Meeus wrote:
> In the pSOS interface region 0 can be used by applications to allocate
> memory from. It contains 'system' memory and is created by default during
> system init. Region 0 is currently not supported by the xenomai psos skin.
> 
> This patch adds functionality to configure the total size and the unit
> size by means of following tunabels:
>   set_config_tunable(region0_size, 128000);
>   set_config_tunable(region0_unitsize, 256);
> 
> The corresponding command-line options are:
>   psos-rn0-size
>   psos-rn0-unitsize
> 

> +	if (psos_region0_size) {
> +		printf("Creating region 0. size=%lu\n",psos_region0_size); /*TODO meeusr */

Debug left over it seems.

> +		ret = rn_create_region0(psos_region0_size, psos_region0_unitsize);

There is no need for this indirection, since rn_create_region0() is
basically a single-line wrapper to rn_create() without any added value.
Since we have access to the region interface from psos/init.c, we may
call the latter directly.

> +	if (rnid == 0)
> +		rnid = region0_id;
> +

This can be factored by adding this mapping to get_rn_from_id(), making
per-call mapping useless.

-- 
Philippe.

