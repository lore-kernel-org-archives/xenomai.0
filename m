Message-ID: <469C7D3E.7020009@domain.hid>
Date: Tue, 17 Jul 2007 10:26:38 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Minor issue: compiler warning on rtdm.h
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

When compiling with an extended warnings I get the following warning:

/nfsroot/common/usr/xenomai/include/rtdm/rtdm.h: In function 
'rt_dev_sendto':
/nfsroot/common/usr/xenomai/include/rtdm/rtdm.h:323: warning: missing 
initializer
/nfsroot/common/usr/xenomai/include/rtdm/rtdm.h:323: warning: (near 
initialization for 'msg.msg_flags')

The structure-type msghdr has 7 elements, but the initializer only has 6 
elements.

Kind regard,
    Johan Borkhuis

