Message-ID: <4D20D7A7.2090003@domain.hid>
Date: Sun, 02 Jan 2011 20:53:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Build issue with rtcan and I-pipe for linux 2.6.36
	on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>


Hi Wolfgang,

It seems we have an issue building rtcan for mpc5xxx with Linux 2.6.36.
As far as I understood the of_device structure disappeared and the
"device tree" bits were integrated in the device structure, which causes
several errors when building ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c

Build log details here:
http://sisyphus.hd.free.fr/~gilles/bx/lite5200/2.6.36-ppc_6xx-gcc-4.2.2/log.html#1

Regards.

-- 
                                                                Gilles.

