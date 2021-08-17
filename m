Subject: Re: [PATCH 0/2] Allow GPIO timestamps also via real-time clock
References: <cover.1629109132.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a8dbaf64-7120-f7be-7f92-a4f95fdb30e3@siemens.com>
Date: Tue, 17 Aug 2021 08:11:52 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1629109132.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org, =?UTF-8?Q?Fran=c3=a7ois_LEGAL?= <francois.legal@thom.fr.eu.org>

On 16.08.21 12:18, Jan Kiszka via Xenomai wrote:
> As discussed, we need to add a separate control to manage whether the
> monotonic or the real-time clock should be used for GPIO timestamping.
> 
> Patch 1 adds this, keeping the default to monotonic. This can be added
> to 3.1.x stable as well. Patch 2 aligns the default to the rest of
> Xenomai, using real-time from now on. That's 3.2 material.
> 
> Jan
> 
> Jan Kiszka (2):
>   drivers/gpio: Add support for selecting real-time clock timestamps
>   drivers/gpio: Flip default for GPIO_RTIOC_TS to real-time clock
> 
>  include/cobalt/kernel/rtdm/gpio.h |  1 +
>  include/rtdm/uapi/gpio.h          |  4 +++-
>  kernel/drivers/gpio/gpio-core.c   | 14 +++++++++++---
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 

BTW, as I do not have a test setup for this in reach, I definitely need
someone to test this and let us know that it works as desired.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

