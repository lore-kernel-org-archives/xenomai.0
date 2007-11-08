Message-ID: <473391B0.5040809@domain.hid>
Date: Thu, 08 Nov 2007 17:46:08 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] User space drivers on PPC440
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The rt_misc_get_io_region() has the "start" argument as an unsigned 
long.  On the PPC440, we have a 36-bit address space, where the I/O 
registers are generally above the 4GB area.  For example, the UART is at 
address 0x1ef600300.

The Linux request_region call has "start" typed as a resource_size_t, 
which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
though this is a 23-bit processor).

Is this something that should be handled by xeno-config?  It could 
append a CFLAG indicating the size of a resource.

    Steve


