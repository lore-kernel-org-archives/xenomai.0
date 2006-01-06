Message-ID: <43BE3F92.1000107@domain.hid>
Date: Fri, 06 Jan 2006 10:59:46 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Problem with #define uint  "i"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: RTnet-users <rtnet-users@domain.hid>
Cc: xenomai@xenomai.org

Hallo,

when trying to build RTnet with Xenomai and Linux 2.4.25 for PowerPC, I 
stumbeld over the following problem:

In "linuxppc_2_4_devel/include/asm-generic/xenomai/wrappers.h" there is 
defined:

   #define ulong "i"
   #define uint  "i"

This makes trouble when a driver uses the types uint or ulong, which is 
the case for the MPC RTnet drivers. Can we use different names for the 
above definitions?

Thanks.

Wolfgang.

