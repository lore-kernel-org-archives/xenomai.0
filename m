MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Apr 2015 09:05:39 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <CADvZd9azLVdxYd8gy4BwT8Fh1LixV_=vbZoAAZegJ+rAut8mng@mail.gmail.com>
References: <CADvZd9azLVdxYd8gy4BwT8Fh1LixV_=vbZoAAZegJ+rAut8mng@mail.gmail.com>
Message-ID: <a3a9e8ae191d814acdbd1d12a7e7dbaa@grandegger.com>
Subject: Re: [Xenomai]
	=?utf-8?q?RT-CAN_driver_for_C=5FCAN=2CD=5FCAN_cores_rea?=
	=?utf-8?q?dy?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi Michael,

On Tue, 28 Apr 2015 17:47:40 +0200, Michael Haberler <haberlerm@gmail.com>
wrote:
> as requested:
> 
> 
>>From 84badf976ed149a352cbb34edc329685aaacb531 Mon Sep 17 00:00:00 2001
> From: Michael Haberler <git@mah.priv.at>
> Date: Tue, 7 Apr 2015 08:04:36 +0200
> Subject: [PATCH 1/3] as from 3.8
> 
> ---
>  c_can/Kconfig          |   23 +
>  c_can/Makefile         |    9 +
>  c_can/c_can.c          | 1292
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  c_can/c_can.h          |  187 +++++++
>  c_can/c_can_pci.c      |  221 +++++++++
>  c_can/c_can_platform.c |  347 +++++++++++++
>  6 files changed, 2079 insertions(+)
>  create mode 100644 c_can/Kconfig
>  create mode 100644 c_can/Makefile
>  create mode 100644 c_can/c_can.c
>  create mode 100644 c_can/c_can.h
>  create mode 100644 c_can/c_can_pci.c
>  create mode 100644 c_can/c_can_platform.c

As Gilles already pointed out, this patch is not suitable for a review
or mainline integration, sorry. It's even not complete. At least the
Kconfig entry in "ksrc/drivers/can" is missing. The patch should be
against the *Xenomai* tree. I would fix that by copying over the relevant
files into "ksrs/drivers/can" of an up-to-date Xenomai and generate a
fresh patch form that. The patch usually contains a subject starting with
"[PATCH] rtcan: " and should have a meaningful commit message. It would
also be good to mention the version (commit id) of the Linux driver the
port is based on. Finally it should have the usual "Author" and 
"Signed-of-by" lines.

Thanks for your patience.

Wolfgang.


