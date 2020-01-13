Subject: Re: [patch 1/5] spi-master.c: spi_master_read_rt()
References: <CAPm8-H5XxArzdkjuy8dS-Hkud4aaNE11DrOQEmc+-a2MgxndbQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d7b646b-2a1d-ac39-f16c-f88623fb90bd@siemens.com>
Date: Mon, 13 Jan 2020 18:02:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAPm8-H5XxArzdkjuy8dS-Hkud4aaNE11DrOQEmc+-a2MgxndbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>, xenomai <xenomai@xenomai.org>

Sorry for the late feedback - my backlog grew too large.

On 30.12.19 16:06, Laurentiu-Cristian Duca via Xenomai wrote:
>  From 15c59317fe1a9d60e20d470de3aca09bca5b99d0 Mon Sep 17 00:00:00 2001
> From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> Date: Fri, 20 Dec 2019 17:35:50 +0200
> Subject: [PATCH] spi-master.c: spi_master_read_rt(): when master->ops->read()
>   completes successfully it returns > 0, so, in this case, copy data to
>   userspace.

Unfortunately, this is not a consumable format for me. I just need

From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>

at the top of the commit message body. Look at [1] e.g. for the 
resulting format.

When you use git format-patch, set --from to some dummy address. That 
will make it generate patches with the correct additional "From:" line 
included. For the actual sending, you can use the normal address again.

Moreover, I need a shorter subject line, something like

     spi: Fix return code handling in spi_master_read_rt

And then write about why this change is correct (basically your current 
subject line).

> 
> Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> ---
>   kernel/drivers/spi/spi-master.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
> index 12a1ad1f1..e04f7ca10 100644
> --- a/kernel/drivers/spi/spi-master.c
> +++ b/kernel/drivers/spi/spi-master.c
> @@ -240,8 +240,8 @@ static ssize_t spi_master_read_rt(struct rtdm_fd *fd,
>   		do_chip_deselect(slave);
>   	}
>   	rtdm_mutex_unlock(&master->bus_lock);
> -	if (ret == 0)
> -		ret = rtdm_safe_copy_to_user(fd, u_buf, rx, len);
> +	if (ret > 0)
> +		ret = rtdm_safe_copy_to_user(fd, u_buf, rx, ret);
>   	
>   	xnfree(rx);
>   	
> 

Jan

[1] https://xenomai.org/pipermail/xenomai/2019-December/042210.html

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

