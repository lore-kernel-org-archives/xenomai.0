Message-ID: <45D9DF65.9000300@domain.hid>
Date: Mon, 19 Feb 2007 18:33:25 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RT-Socket-CAN versioning
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

Hi Jan,

currently the RT-Socket-CAN drivers maintains it's own version or 
release number. As RT-Socket-CAN is part of Xenomai, I do not see the 
need for it (and so far I did not update it). What is the intended use 
of "driver_version" in "struct rtdm_device"? Furthermore, there is also
"profile_version" (which does not show up n the Doxygen docu for some 
strange reason). The latter one seems suitable to reflect CAN API changes.

Wolfgang.



