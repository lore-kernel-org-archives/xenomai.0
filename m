References: <1437498780-3412-1-git-send-email-sbattazzo@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55F13E6D.4060906@xenomai.org>
Date: Thu, 10 Sep 2015 10:25:17 +0200
MIME-Version: 1.0
In-Reply-To: <1437498780-3412-1-git-send-email-sbattazzo@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Added drivers for C_CAN ported from original
 Linux driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 07/21/2015 07:13 PM, Steve Battazzo wrote:
> From: SteveB <user@ubuntu.(none)>
> 
> ---
>  ksrc/drivers/can/Kconfig                      |    7 +
>  ksrc/drivers/can/Makefile                     |    6 +-
>  ksrc/drivers/can/c_can/Kconfig                |   23 +
>  ksrc/drivers/can/c_can/Makefile               |   36 +
>  ksrc/drivers/can/c_can/README                 |    5 +
>  ksrc/drivers/can/c_can/rtcan_c_can.c          | 1289 +++++++++++++++++++++++++
>  ksrc/drivers/can/c_can/rtcan_c_can.h          |  209 ++++
>  ksrc/drivers/can/c_can/rtcan_c_can_pci.c      |  221 +++++
>  ksrc/drivers/can/c_can/rtcan_c_can_platform.c |  326 +++++++
>  9 files changed, 2120 insertions(+), 2 deletions(-)
>  create mode 100644 ksrc/drivers/can/c_can/Kconfig
>  create mode 100644 ksrc/drivers/can/c_can/Makefile
>  create mode 100644 ksrc/drivers/can/c_can/README
>  create mode 100644 ksrc/drivers/can/c_can/rtcan_c_can.c
>  create mode 100644 ksrc/drivers/can/c_can/rtcan_c_can.h
>  create mode 100644 ksrc/drivers/can/c_can/rtcan_c_can_pci.c
>  create mode 100644 ksrc/drivers/can/c_can/rtcan_c_can_platform.c
> 

Thanks, and sorry for the late reply.

Wolfgang/Jan, any objection with this driver? I'm willing to pick it for
3.x if ok. Thanks.

-- 
Philippe.

