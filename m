Subject: Re: [PATCH 6/6] drivers/can: add support for Bosch C_CAN controller
References: <20211124234648.7428-1-dariobin@libero.it>
 <20211124234648.7428-5-dariobin@libero.it>
 <41b7d33c-279c-1eae-936c-03d4786fbc39@siemens.com>
 <1883121671.566532.1638033617412@mail1.libero.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3f3e5f9e-d496-40e4-84cd-470ccede4752@siemens.com>
Date: Mon, 29 Nov 2021 10:11:39 +0100
MIME-Version: 1.0
In-Reply-To: <1883121671.566532.1638033617412@mail1.libero.it>
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
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>

On 27.11.21 18:20, Dario Binacchi wrote:
> Hi Jan,
> 
>> Il 25/11/2021 11:43 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:
>>
>>  
>> On 25.11.21 00:46, Dario Binacchi wrote:
>>> Bosch C_CAN controller is a full-CAN implementation which is compliant
>>> to CAN protocol version 2.0 part A and B.
>>>
>>> Starting from the RTDM porting [1] by Stephen Battazzo, Michael applied
>>> some fixes for proper driver operation. Then I ported the commits from
>>> Linux kernel version 5.12 and finally I added support for 64 message
>>> objects [2] and improved the FIFO management [2] to get the best
>>> possible RX/TX throughput. Features [2] and [3] led to the creation of
>>> patches applied to the Linux kernel too.
>>>
>>> The patch was tested on a custom board mounting an AM335x SOC.
>>>
>>> PCI support has not been developed.
>>>
>>> [1] http://xenomai.org/pipermail/xenomai/2015-July/034690.html
>>> [2] 132f2d45fb23 ("can: c_can: add support to 64 message objects")
>>> [3] 387da6bc7a82 ("can: c_can: cache frames to operate as a true FIFO")
>>>
>>> Signed-off-by: Stephen J. Battazzo <stephen.j.battazzo@nasa.gov>
>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>> Signed-off-by: Dario Binacchi <dariobin@libero.it>
>>> Signed-off-by: Gianluca Falavigna <gianluca.falavigna@inwind.it>
>>> Tested-by: Gianluca Falavigna <gianluca.falavigna@inwind.it>
>>>
>>> ---
>>>
>>>  kernel/drivers/can/Kconfig                    |    1 +
>>>  kernel/drivers/can/Makefile                   |    2 +-
>>>  kernel/drivers/can/README                     |    1 +
>>>  kernel/drivers/can/c_can/Kconfig              |   16 +
>>>  kernel/drivers/can/c_can/Makefile             |    8 +
>>>  kernel/drivers/can/c_can/rtcan_c_can.c        | 1388 +++++++++++++++++
>>>  kernel/drivers/can/c_can/rtcan_c_can.h        |  258 +++
>>>  .../drivers/can/c_can/rtcan_c_can_ethtool.c   |   47 +
>>>  .../drivers/can/c_can/rtcan_c_can_platform.c  |  461 ++++++
>>>  9 files changed, 2181 insertions(+), 1 deletion(-)
>>>  create mode 100644 kernel/drivers/can/c_can/Kconfig
>>>  create mode 100644 kernel/drivers/can/c_can/Makefile
>>>  create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.c
>>>  create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.h
>>>  create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
>>>  create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_platform.c
>>>
>>> diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
>>> index 1c055494d..c9ff36d94 100644
>>> --- a/kernel/drivers/can/Kconfig
>>> +++ b/kernel/drivers/can/Kconfig
>>> @@ -85,6 +85,7 @@ config XENO_DRIVERS_CAN_FLEXCAN
>>>  
>>>  	Say Y here if you want to support for Freescale FlexCAN.
>>>  
>>> +source "drivers/xenomai/can/c_can/Kconfig"
>>>  source "drivers/xenomai/can/mscan/Kconfig"
>>>  source "drivers/xenomai/can/peak_canfd/Kconfig"
>>>  source "drivers/xenomai/can/sja1000/Kconfig"
>>> diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
>>> index 65761a010..87bd0d070 100644
>>> --- a/kernel/drivers/can/Makefile
>>> +++ b/kernel/drivers/can/Makefile
>>> @@ -1,7 +1,7 @@
>>>  
>>>  ccflags-y += -I$(srctree)/drivers/xenomai/can
>>>  
>>> -obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/
>>> +obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/ c_can/
>>>  obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
>>>  obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) += xeno_can_virt.o
>>>  
>>> diff --git a/kernel/drivers/can/README b/kernel/drivers/can/README
>>> index cb0ef37ae..44aff9b1c 100644
>>> --- a/kernel/drivers/can/README
>>> +++ b/kernel/drivers/can/README
>>> @@ -20,6 +20,7 @@ devices:
>>>     SJA1000 PEAK parallel port Dongle
>>>     SJA1000 IXXAT PCI card
>>>     MSCAN for MPC5200 boards
>>> +   C_CAN/D_CAN for AM335x/AM437x Sitara processors and DRA7 SOC
>>>  
>>>  Utilities for RT-Socket-CAN are available in "src/utils/can".
>>>  
>>> diff --git a/kernel/drivers/can/c_can/Kconfig b/kernel/drivers/can/c_can/Kconfig
>>> new file mode 100644
>>> index 000000000..dda5f7517
>>> --- /dev/null
>>> +++ b/kernel/drivers/can/c_can/Kconfig
>>> @@ -0,0 +1,16 @@
>>> +config XENO_DRIVERS_CAN_C_CAN
>>> +	depends on XENO_DRIVERS_CAN && OF
>>> +	tristate "Bosch C-CAN based chips"
>>> +	default n
>>
>> "default n" is already default.
>>
> Ok, I'll drop it
> 
>>> +
>>> +config XENO_DRIVERS_CAN_C_CAN_PLATFORM
>>> +	depends on XENO_DRIVERS_CAN_C_CAN
>>> +	tristate "Generic Platform Bus based controller"
>>> +	help
>>> +
>>> +	This driver adds support for the C_CAN/D_CAN chips connected
>>> +	to the "platform bus" (Linux abstraction for directly to the
>>> +	processor attached devices) which can be found on various
>>> +	boards from ST Microelectronics (http://www.st.com) like the
>>> +	SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
>>> +	boards like am335x, dm814x, dm813x and dm811x.
>>
>> Please enable the driver also for our CI builds, on targets where it can
>> be compiled.
>>
> 
> Could you please explain to me what I need to do? I looked at the documentation 
> and other drivers but couldn't find anything about CI builds.

Check .gitlab-ci.yml, see e.g.
https://source.denx.de/Xenomai/xenomai/-/commit/1d8edbf6ce23d160fb3e8a2cd9c94e8453a967f1.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

