Message-ID: <45D9BDE0.3030900@domain.hid>
Date: Mon, 19 Feb 2007 16:10:24 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN bug fix for no-filter
	definition
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

Hello,

I just applied the following bug fix to the trunk for RT-Socket-CAN when 
using the no-filter definition. Here is the ChangeLog entry:

2007-02-19  Wolfgang Grandegger  <wg@domain.hid>

* ksrc/drivers/can/rtcan_raw.c (rtcan_raw_bind),
   ksrc/drivers/can/rtcan_socket.h: Fix bug using rtcan_flist_no_filter
   and use proper type for RTCAN_FLIST_NO_FILTER to get warnings.

Will do the same for 2.3.x.

Wolfgang.

