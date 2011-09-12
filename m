Message-ID: <4E6DC272.9050305@domain.hid>
Date: Mon, 12 Sep 2011 10:27:30 +0200
From: varname <varname@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Undefined 'pc_sysrootdir' in libxenomai_posix.pc ?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Trying to use pkg-config with 2.6.0-rc2 results in the following error 
message:

   Variable 'pc_sysrootdir' not defined in 
'/home/test/usr/xenomai-2.6.0-rc2/lib/pkgconfig/libxenomai_posix.pc'

Same behaviour in rc1.

Removing ${pc_sysrootdir} seems to work, but I'm not sure that is the 
correct fix for this.

