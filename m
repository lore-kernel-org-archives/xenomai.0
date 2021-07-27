Subject: Re: [xenomai-image PATCH v2 5/5] Add kas option for swithing off debug
References: <20210727004217.10892-1-hongzhan.chen@intel.com>
 <20210727004217.10892-6-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a7e2141-9889-d024-bd1d-abc36d70fb31@siemens.com>
Date: Tue, 27 Jul 2021 12:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <20210727004217.10892-6-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 27.07.21 02:42, Hongzhan Chen via Xenomai wrote:
> For performance or latency testing and demonstration, debug switches
> should be off but it is on by default.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  opt-set-nodbg.yml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 opt-set-nodbg.yml
> 
> diff --git a/opt-set-nodbg.yml b/opt-set-nodbg.yml
> new file mode 100644
> index 0000000..16a2fec
> --- /dev/null
> +++ b/opt-set-nodbg.yml
> @@ -0,0 +1,20 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (C) 2021 Intel Corporation
> +#
> +# Authors:
> +#  Hongzhan Chen <hongzhan.chen@intel.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 10
> +
> +# to use kernel config fragments for disabling dbg and
> +# improving performance
> +
> +local_conf_header:
> +  distro-nodbg: |
> +    DISTRO_NODBG = "YES"
> 

We tend to use "0" / "1" for bitbake boolean vars.

Furthermore, I wonder if we shouldn't switch default to no-debug and
explicitly turn debugging on in our CI/testing.

In any case, some short hint on this control in the README would be good.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

