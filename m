Subject: Re: [xenomai-images][PATCH 4/9] beagle-bone-black: Add Devicetree and
 fake-hwclock
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
 <20190905154425.10007-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
Date: Tue, 10 Sep 2019 12:27:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190905154425.10007-5-Quirin.Gylstorff@siemens.com>
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

On 05.09.19 17:44, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To deploy the target with LAVA it is necessary to use a devicetree.
> Isar extracts the tree from the kernel build and stores the tree
> in the deploy-DIR
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   conf/machine/beagle-bone-black.conf | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
> index 73abe12..90b9f13 100644
> --- a/conf/machine/beagle-bone-black.conf
> +++ b/conf/machine/beagle-bone-black.conf
> @@ -14,5 +14,6 @@ DISTRO_ARCH = "armhf"
>   IMAGE_INSTALL += "u-boot-script"
>   
>   IMAGE_TYPE ?= "wic-img"
> -
> +DTB_FILE = "am335x-boneblack.dtb"
>   IMAGER_INSTALL += "u-boot-omap"
> +IMAGE_PREINSTALL += "fake-hwclock"
> 

Patch 3 and 4 should likely come before activating LAVA...

I'm taking those two into next already.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

