Subject: Re: [PATCH v2 1/1] license: summarize the licensing terms
References: <20210804073546.3372409-1-rpm@xenomai.org>
 <20210804073546.3372409-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4c1efa86-f999-7d72-1fbc-1ee5f8d7c870@siemens.com>
Date: Wed, 4 Aug 2021 22:47:57 +0200
MIME-Version: 1.0
In-Reply-To: <20210804073546.3372409-2-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 04.08.21 09:35, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  COPYING | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 COPYING
> 
> diff --git a/COPYING b/COPYING
> new file mode 100644
> index 000000000..839938c62
> --- /dev/null
> +++ b/COPYING
> @@ -0,0 +1,45 @@
> +
> +Xenomai 3 Licensing terms
> +=========================
> +
> +Xenomai 3 is composed of a number of libraries, user-space application
> +programs, and kernel code. This file summarizes the licenses used for
> +the libraries and kernel code (aka 'Cobalt core'). Please refer to the
> +COPYING file in the corresponding directory for details. The licensing
> +terms of each application program shipped with Xenomai 3 is stated in
> +the corresponding source code.
> +
> +====================================================================
> +  User space interface    |        SPDX identifier [1]
> +====================================================================
> +                          |
> +  alchemy                 |     LGPL-2.1-or-later
> +  boilerplate             |     LGPL-2.1-or-later, some MIT portions
> +  boilerplate/iniparser   |     MIT
> +  cobalt                  |     LGPL-2.1-or-later
> +  copperplate             |     LGPL-2.1-or-later
> +  psos                    |     LGPL-2.1-or-later
> +  smokey                  |     LGPL-2.1-or-later

smokey has "some MIT portions" as well (network tests).

> +  trank                   |     LGPL-2.1-or-later
> +  vxworks                 |     LGPL-2.1-or-later
> +  include                 |     LGPL-2.1-or-later with exception [2]
> +------------------------------------------------------------------- 
> +
> +==================================================================
> +     Cobalt core          |        SPDX identifier
> +==================================================================
> +                          |
> +  kernel/cobalt           |     GPL-2.0-or-later
> +  kernel/cobalt/posix     |     GPL-2.0-or-later
> +  kernel/cobalt/rtdm      |     GPL-2.0-or-later
> +  include/cobalt/kernel   |     GPL-2.0-or-later with exception [2]

Analogously to that, we have a few RTnet header under a similar
exceptions: include/rtdm/net.h, include/rtdm/uapi/net.h,
kernel/drivers/net/stack/include/rtmac.h.

> +------------------------------------------------------------------  
> +
> +Please note that the Linux licensing rules apply to the Xenomai kernel
> +code once compiled in the Linux kernel. These rules can be found at:
> +https://www.kernel.org/doc/html/latest/process/license-rules.html#kernel-licensing
> +
> +[1] See https://spdx.org/licenses
> +
> +[2] The exception grants additional permission to use the header files
> +    in user-space application programs. See include/COPYING.
> 

I just browsed a report from a commercial license scanner for Xenomai
3.0.11. Only those minor deviations above, rest is in line (minus a few
mis-classifications the scanner and/or the operators produced...).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

