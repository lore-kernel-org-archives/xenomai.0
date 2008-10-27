Message-ID: <4905B40D.5050109@domain.hid>
Date: Mon, 27 Oct 2008 13:29:01 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] CAN filter issues
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: wg@domain.hid, xenomai-core <xenomai@xenomai.org>

Hi Wolfgang,

we currently face an issue regarding the filtering of CAN messages since 
Xenomai 2.4. It was introduced in rev. 2202 (I know it is long ago but 
the problem popped up last week). The line in question is

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw_filter.c?v=2.3.5#064

and

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw_filter.c?v=2.4.4#062

respectively.

What worries me is the removal of the AND-operation (can_id & can_mask). 
 From my POV this offends the CAN specification which says that the CAN 
filter mask shall indicate which bits are taken into account when 
comparing a CAN identifier and which shall be seen as "don't care".

 From your Changelog entry the reason for this modification was to be up 
to date with the Linux Socket CAN project. So maybe there is also the 
need to bring up this topic on their ML, too.

-- 
Sebastian

