Message-ID: <469E10D5.8000602@domain.hid>
Date: Wed, 18 Jul 2007 15:08:37 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Problems with compat_module_param_array() with Linux
	2.4
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

yesterday I realized a problem with compat_module_param_array() with
ksrc/drivers/can/sja1000/rtcan_mem.c under Linux 2.4. It uses
CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV to define the number of mem
devices, which is set to '(4)' by "make [menuc]onfig". Unfortunately, 
the brackets '()' break compat_module_param_array() because it treats 
the count as string:

#define compat_module_param_array(name, type, count, perm) \
         static inline void *__check_existence_##name(void) { return
&name; } \
         MODULE_PARM(name, "1-" __MODULE_STRING(count)
_MODULE_PARM_STRING_##type)

Any idea how to fix that? I actually tend to remove the configuration 
option CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM_MAX_DEV and hardcode it to 
"4" (without brackets) in the driver. It's kind of overkill, anyhow.

Wolfgang.



