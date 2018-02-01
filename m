References: <1517366181-6547-1-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a5753245-78d0-c9b3-d7d3-c0b79b2c57c5@xenomai.org>
Date: Thu, 1 Feb 2018 11:26:59 +0100
MIME-Version: 1.0
In-Reply-To: <1517366181-6547-1-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/3] Add Xilinx AXI gpio driver
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
> ---
>  kernel/drivers/gpio/Kconfig       | 10 +++++++++-
>  kernel/drivers/gpio/Makefile      |  3 ++-
>  kernel/drivers/gpio/gpio-xilinx.c | 40 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 2 deletions(-)

[snip]

> diff --git a/kernel/drivers/gpio/gpio-xilinx.c b/kernel/drivers/gpio/gpio-xilinx.c
> new file mode 100644
> index 0000000..72d4364
> --- /dev/null
> +++ b/kernel/drivers/gpio/gpio-xilinx.c
> @@ -0,0 +1,40 @@
> +/**
> + * @note Copyright (C) 2017 Greg Gallagher <greg@embeddedgreg.com>
> + *
> + * This driver controls the gpio that can be located on the PL
> + * of the Zynq SOC
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +#include <linux/module.h>
> +#include "gpio-core.h"
> +

The change below is required for this driver to build since recently,
due to moving gpio-core.h to a public header containing the generic GPIO
bits some client drivers may need. Other than that, this looks ok.

diff --git a/kernel/drivers/gpio/gpio-xilinx.c
b/kernel/drivers/gpio/gpio-xilinx.c
index 72d436435..cae88b62f 100644
--- a/kernel/drivers/gpio/gpio-xilinx.c
+++ b/kernel/drivers/gpio/gpio-xilinx.c
@@ -19,7 +19,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.
  */
 #include <linux/module.h>
-#include "gpio-core.h"
+#include <rtdm/gpio.h>

 #define RTDM_SUBCLASS_XILINX  5

-- 
Philippe.

