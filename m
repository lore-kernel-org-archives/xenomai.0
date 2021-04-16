Subject: Re: [PATCH V2 0/3] introduce latmus
References: <20210416053133.23412-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <18e241a9-358a-5e81-8511-7f8c0f425b1a@siemens.com>
Date: Fri, 16 Apr 2021 14:03:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210416053133.23412-1-hongzhan.chen@intel.com>
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
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 16.04.21 07:31, hongzha1 via Xenomai wrote:
> Latmus is a backport from EVL to Cobalt, the procedure is fully
> described here: https://evlproject.org/core/benchmarks/

...but in a EVL-specific way. At least terminology is different, but I
suspect more.

> 
> I verified all functions of latmus on hardware environment under which 
> Rock PI X board connect GPIOs with FRDM K64F.But actually Rock PI X V1.4
> board's GPIO I/O voltage is 1.8V does not match 3.3V of FRDM K64F board.
> Even though I tried to set up IO shifter board to bridge two boards,
> still can not get correct latecny data because of bad IO signal. So I
> have to work around to loopback Input/Output GPIOs on both boards to do
> verify functions.
> 
> Hardware setup:
> 
> ---------------------------------------------------
>      eth|                                     |eth
>         +                                     +
>       FRDM K64F board                   Rock PI X board                  
>       |         |                       |           |
>       +_________+                       +___________+  
>      GPIO Loopback                      GPIO Loopback
> 
> hongzha1 (3):
>   rtdm/testing: latmus: introduce latmus driver
>   drivers/gpio: core: introduce helper to find gpiochip
>   testsuite/latmus: introduce latmus benchmark
> 
>  configure.ac                      |    1 +
>  include/cobalt/kernel/rtdm/gpio.h |    3 +
>  include/rtdm/uapi/testing.h       |   79 ++
>  kernel/drivers/gpio/gpio-core.c   |   23 +
>  kernel/drivers/testing/Kconfig    |   10 +
>  kernel/drivers/testing/Makefile   |    1 +
>  kernel/drivers/testing/latmus.c   | 1237 ++++++++++++++++++++++++
>  testsuite/Makefile.am             |    4 +-
>  testsuite/latmus/Makefile.am      |   18 +
>  testsuite/latmus/latmus.c         | 1446 +++++++++++++++++++++++++++++
>  10 files changed, 2821 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/drivers/testing/latmus.c
>  create mode 100644 testsuite/latmus/Makefile.am
>  create mode 100644 testsuite/latmus/latmus.c
> 

I'm still missing a short README or manpage
(doc/asciidoc/man1/latmus.adoc) for Xenomai. Bonus for the migration of
the EVL page into the Xenomai doc-wiki.

I can assume that this targets next (=master right now)?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

