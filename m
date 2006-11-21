Message-ID: <4562BA12.8080809@domain.hid>
Date: Tue, 21 Nov 2006 09:34:26 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RT-Socket-CAN, shorter names
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Hallo,

I plan to shorten the following names using "can" instead of "rtcan" to 
be consistent with the naming scheme:

CONFIG_XENO_DRIVERS_RTCAN_* -> CONFIG_XENO_DRIVERS_CAN_
xeno_rtcan_* -> xeno_can_*

Jan, I think you already suggested such a modification?

Wolfgang.

