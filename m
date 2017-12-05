References: <1512358311-120677-1-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <10fdebbc-77e8-1668-13d1-d04d1e6be6e8@xenomai.org>
Date: Tue, 5 Dec 2017 14:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <1512358311-120677-1-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Add zynq-7000 rtdm gpio driver.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org
Cc: Greg Gallagher <ggallagher31@gmail.com>

On 12/04/2017 04:31 AM, Greg Gallagher wrote:
> From: Greg Gallagher <ggallagher31@gmail.com>
> 
> ---
>  For the zynq platform (and possibly others in the future) we need to modify 
>  gpio-core to request gpio pins before using them. The open() function will 
>  now request a gpio and fail if it's already reserved. This should make 
>  the pin request transparent to the user. The ability to request and release 
>  pins is also available in an ioctrl message.  Tested on Microzed Zynq-7010 
>  platform and the raspberry pi 2 board.
> 

Thanks. Merged, as two separate commits, so that we can bisect through
changes to generic code more easily.

commit 56f9dd3ff8b70880f4609a52c91372a27308c2ac (HEAD -> stable-3.0.x,
origin/stable-3.0.x)
Author: Greg Gallagher <ggallagher31@gmail.com>
Date:   Mon Dec 4 04:31:00 2017 +0100

    drivers/gpio: Add zynq-7000 rtdm gpio driver

commit 70f9d8f15a3b4219cc86d49860e6b8b515954980
Author: Greg Gallagher <ggallagher31@gmail.com>
Date:   Tue Dec 5 09:39:05 2017 +0100

    drivers/gpio: Request gpio at open()

    For the zynq platform (and possibly others in the future) we need to
modify
    gpio-core to request gpio pins before using them. The open()
function will
    now request a gpio and fail if it's already reserved. This should make
    the pin request transparent to the user. The ability to request and
release
    pins is also available in an ioctrl message.  Tested on Microzed
Zynq-7010
    platform and the raspberry pi 2 board.

-- 
Philippe.

