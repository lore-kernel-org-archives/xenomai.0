Message-ID: <46C04384.4030805@domain.hid>
Date: Mon, 13 Aug 2007 13:41:56 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
In-Reply-To: <46C02829.9020009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>

Roland Tollenaar wrote:
> Hi,
> 
> in a 1 ms period task of my xenomai application things work perfectly 
> with my BeckHoff devices addressing them via Ethercat with EML until I 
> activate rtcan. Then sometimes (not always) I get incessant warnings 
> from EML which read:
> 
> EC_Telegram:: check_index(): Index field does not correspond with 
> received data.
> low_level_input(): framebuilding failed.
> 
> The cycle time of the task is not being violated AFAI can see.
> 
> In dmesg the following can be found when the conflict occurs
> 
> RTnet:rtskb allocation from real-time cache failed.
> Assertion failed! drivers/xenomai/can/rtcan_raw.c: rtcan_tx_push:168 
> dev->tx_socket=0 (3) TX skb still in use.

Hm, this is not supposed to happen.

> Can anyone make any suggestions as to what might be the problem here or 
> what I could try to look at to establish this?

Can you show the output of /proc/rtcan/devices and /proc/rtcan/sockets 
before and after the problem showed up.

Wolfgang.


