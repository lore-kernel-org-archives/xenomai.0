Message-ID: <45C8836C.70009@domain.hid>
Date: Tue, 06 Feb 2007 14:32:28 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTDM over linux-rt, code organisation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hi Philippe,

I'm currently porting RTDM over Linux with the real-time preemption 
patch (RTDM-native) and I have a first prototype running and can send 
and receive CAN messages with RT-Socket-CAN. Time to speak about code 
(re-)organisation and integration into Xenomai. I briefly discussed this 
issue with Jan and here is my proposal:

- the RTDM-native implementation goes to:

     ksrc/skins/rtdm/native/
     include/rtdm/rtdm_driver-native.h

   rtdm_driver-native.h will be included by rtdm_driver.h depending on
   CONFIG_IPIPE. A similar code organization could be chosen for
   RTDM-cosched.

- a modified version of prepare_kernel.sh adds the RTDM-native files
   as symbolic links to the kernel tree depending on CONFIG_IPIPE and
   CONFIG_PREEMPT_RT:

     include/rtdm/ -> include/xenomai/rtdm/
     ksrc/skins/rtdm/native/ -> kernel/xenomai/rtdm/native/
     ksrc/drivers/ -> drivers/xenomai/

- The idea is to keep the RTDM-native implementation in a separate
   branch and merge it sometime later (with Xenomai 3.x?).

What do you think? Does it match with your ideas of Xenomai over -rt?

Thanks.

Wolfgang.

