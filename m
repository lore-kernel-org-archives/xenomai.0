Subject: Re: [xenomai-images][PATCH v2] distro/xenomai-demo: Update to Debian
 10
References: <20190814142414.25331-1-Quirin.Gylstorff@siemens.com>
 <20190822145008.1445-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e2d162ab-f05a-b812-b553-fea9cd22f272@siemens.com>
Date: Thu, 22 Aug 2019 17:01:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190822145008.1445-1-Quirin.Gylstorff@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 22.08.19 16:50, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Debian 10 (Buster) was released and Stretch is now old stable, update
> the distribution to the latest stable version.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes:
>    V2:
>    Updated for merge with next
> 
>   conf/distro/xenomai-demo.conf | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
> index 1fb7838..2610548 100644
> --- a/conf/distro/xenomai-demo.conf
> +++ b/conf/distro/xenomai-demo.conf
> @@ -9,9 +9,9 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require conf/distro/debian-stretch.conf
> +require conf/distro/debian-buster.conf
>   
> -HOST_DISTRO ?= "debian-stretch"
> +HOST_DISTRO ?= "debian-buster"
>   
>   KERNEL_NAME = "xenomai"
>   
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

