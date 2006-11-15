Message-ID: <455AD876.7010606@domain.hid>
Date: Wed, 15 Nov 2006 10:05:58 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, TX loopback and further
	improvements
References: <4559D38C.2080001@domain.hid>	<4559DA0E.7060406@domain.hid>
	<455A02AD.9000403@domain.hid> <455AC0EA.9000001@domain.hid>
	<455AC829.3080109@domain.hid>
In-Reply-To: <455AC829.3080109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hi Jan,
>>
>> Jan Kiszka wrote:
>>> Hi Wolfgang,
>> [...deletions...]
>>
>>> Last remark: For the sake of completeness, tx-loopback should also be
>>> implemented in the virtual CAN driver.
>> The virtual CAN driver already works like TX loopback. It routes TX
>> messages to local foreign sockets (but without sending them to any bus).
> 
> There is a minor difference: When application A is attached to a socket
> on virtual CAN device 1, B to device 2, and C to 1 again, a message sent
> by A will only be received by B. TX loopback as you are introducing it
> should make C receive it as well - in order to have a fully compatible
> test environment.

Ah, I missed the case (rx_dev == tx_dev). This should work then:

	/* Deliver to all other devices on the virtual bus */
	for (i = 0; i < devices; i++) {
		rx_dev = rtcan_virt_devs[i];
		if (rx_dev->state == CAN_STATE_ACTIVE) {
			if (tx_dev != rx_dev) {
				rx_frame->can_ifindex = rx_dev->ifindex;
				rtcan_rcv(rx_dev, &skb);
			} else if (rtcan_tx_loopback_pending(tx_dev))
				rtcan_tx_loopback(tx_dev);
		}
	}

Thanks.

Wolfgang.

