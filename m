References: <1517366181-6547-1-git-send-email-greg@embeddedgreg.com>
 <1517366181-6547-2-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9e78d306-dab0-e091-b535-2a4b0bddd178@xenomai.org>
Date: Thu, 1 Feb 2018 11:29:41 +0100
MIME-Version: 1.0
In-Reply-To: <1517366181-6547-2-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 2/3] Handle device paths from the device tree
 that start with a forward slash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 01/31/2018 03:36 AM, Greg Gallagher wrote:
> If the device name from the device tree starts with a forward slash (/) the
> rtdm device stores it in the registry including the forward slash.  When we
> go to use that device and do the registry lookup we use a relative path from
> /dev/rtdm which doesn't contain the forward slash and fails to find a match.
> Open won't return an error but IO calls will fail.  To fix this when we
> register an RTDM device skip the first character if it's a forward slash.
> 
> In my case the path from the device tree is
>         /amba_pl/gpio@41200000/gpio905
> which gets stored in the registry. When we want to use the device and look up
> the device path in the registry we use
>         amba_pl/gpio@41200000/gpio905
> which won't find a match in the registry.
> 

Good catch, thanks.

> Tested on Zynq7000 gpio drivers
> ---
>  kernel/cobalt/rtdm/device.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
> index 4533dfb..89e0815 100644
> --- a/kernel/cobalt/rtdm/device.c
> +++ b/kernel/cobalt/rtdm/device.c
> @@ -91,9 +91,12 @@ struct rtdm_device *__rtdm_get_namedev(const char *path)
>  	if (strncmp(path, "rtdm/", 5) == 0)
>  		path += 5;
>  
> +	printk(KERN_ERR "path to bind %s\n", path);

Debug stuff to remove before merging.

-- 
Philippe.

