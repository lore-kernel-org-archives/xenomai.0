Subject: Re: [xenomai-images PATCH 04/11] recipes-kernel/linux: Add 4.4
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
 <20200214073259.1769-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <18785727-1343-13ed-8c1e-14adccf4b501@siemens.com>
Date: Fri, 14 Feb 2020 09:41:44 +0100
MIME-Version: 1.0
In-Reply-To: <20200214073259.1769-5-Quirin.Gylstorff@siemens.com>
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

On 14.02.20 08:32, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add recipe for linux 4.4.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   opt-linux-4.4.yml | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 opt-linux-4.4.yml
> 
> diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
> new file mode 100644
> index 0000000..bb24a04
> --- /dev/null
> +++ b/opt-linux-4.4.yml
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +local_conf_header:
> +  linux-xenomai-latest: |
> +    PREFERRED_VERSION_linux-xenomai = "4.4%"
> 

Subject and content no longer matches. This is just allowing to select a 
4.4 release, the recipe is already there (in next).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

