Subject: Re: [patch 1/4] fix: spi_master_read_rt()
References: <CAPm8-H7RNuMLSmiB-NdJ+Edck-GQy1dRmmPzc2un_V1f7QsQtA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <35685293-62b6-02c9-481f-9d1527d9bd73@siemens.com>
Date: Fri, 20 Dec 2019 15:30:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAPm8-H7RNuMLSmiB-NdJ+Edck-GQy1dRmmPzc2un_V1f7QsQtA@mail.gmail.com>
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

On 20.12.19 12:14, Laurentiu-Cristian Duca via Xenomai wrote:
>  From 6e9138e92a4b9a3f163faeb4ad04f257157fd2f5 Mon Sep 17 00:00:00 2001
> From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> Date: Fri, 20 Dec 2019 13:00:42 +0200
> Subject: [PATCH] - spi_master_read_rt(): if master->ops->read() returns > 0,
>   then copy data to userspace.
> 

I'm lacking a little bit the description of the issue here, means a 
brief but catchy subject line and then some separate paragraph which 
explains /why/ we need the change.

> Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> ---
>   kernel/drivers/spi/spi-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
> index 12a1ad1f1..1e81bd02e 100644
> --- a/kernel/drivers/spi/spi-master.c
> +++ b/kernel/drivers/spi/spi-master.c
> @@ -240,7 +240,7 @@ static ssize_t spi_master_read_rt(struct rtdm_fd *fd,
>   		do_chip_deselect(slave);
>   	}
>   	rtdm_mutex_unlock(&master->bus_lock);
> -	if (ret == 0)
> +	if (ret > 0)
>   		ret = rtdm_safe_copy_to_user(fd, u_buf, rx, len);
>   	
>   	xnfree(rx);
> 

To my reading of the two existing master drivers, this change is not 
needed so far. They either return < 0 on error or the requested length 
on success.

However, I see the point that, if the interface should be "return the 
actual length", we should only copy back that length. But that's also 
not what the change does because that would require passing ret as 
length to copy_to_user, rather than len. Am I missing something?

BTW, this claims to be patch 1 of 4, but the other three are still 
missing on the list.

Regarding submission format: buildroot has a nice setup tutorial how to 
route local git commits to mailing lists, individually or as series. 
Have a look at 
https://buildroot.org/downloads/manual/manual.html#submitting-patches, 
specifically "Preparing a patch series".

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

