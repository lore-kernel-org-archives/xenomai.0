Message-ID: <4C51EE52.4050506@domain.hid>
Date: Thu, 29 Jul 2010 23:10:42 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTikTyH5R8oMS-f-1jcJqryAwT-DKfzxNf1YROALK@mail.gmail.com>	<AANLkTinvhF72tWwCEy85jT3Kk2cQZwRyCtBZNcSZk-yA@mail.gmail.com>	<4C51223A.2070700@domain.hid>	<AANLkTikib3KYn-m7owo83LKUUMdfPP3=p_g7BPqgb-Gh@domain.hid>	<4C517FF1.1040902@domain.hid>	<AANLkTim4HheofHzPvJkMaCtYp49egWmJAzWLM2o3AXJo@domain.hid>	<4C5198A5.6010002@domain.hid>	<AANLkTi=s+24Sravpy=r91M9bRoNdKzafopTcngV7rLLv@domain.hid>	<4C51D317.9020103@domain.hid>	<4C51E361.8020102@domain.hid>
	<AANLkTikNB7c3E58Q1kxg99TPUVo3E_deojtzgDvW5asL@mail.gmail.com>
In-Reply-To: <AANLkTikNB7c3E58Q1kxg99TPUVo3E_deojtzgDvW5asL@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Bug - Can 2 devices.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodolfo Oliveira <rodolforomao@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hello,

On 07/29/2010 10:37 PM, Rodolfo Oliveira wrote:
> I copied the command "# rtcanrecv 0xFFF-e" for my microcontroller and I can
> not run it, this appeared the following message "/
> opt/denx/xenomai_2_2_91/src/utils/can: No such file or directory."
> Microcontroller shipped with Linux 2.4 with Xenomai is cross compiled on
> Linux on my desktop computer, so he will not find the directory that the
> rtcanrecv are trying to access.
> Is there another way to do?

I usually mount the root filesystem of the ELDK via NFS and install the
Xenomai libraries and utilities into it.

> CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4

OK, I checked your sources and realized, that you use a very very early
version of RT-Socket-CAN. Any chance to switch to a more recent version
of Xenomai 2.3? If not, please check the related commits of the
xenomai-2.3 or xenomai-2.4 git repositories. I spotted a few fixes which
may help.

Wolfgang.

