Message-ID: <4BA259D1.4020704@domain.hid>
Date: Thu, 18 Mar 2010 17:50:25 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Analogy: cancel ongoing commands when a device is
	closed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

After fixing analogy to permit continuous acquisition, I discovered that
ongoing commands are not canceled when a device is closed (I obtain a
DMA buffer owerwrite warning in the kernel log when I abruptly terminate
 my acquisition program).

I think this is quite a surprising behavior. I would expect that the
commands are canceled when there isn't a data consumer any more. Would
it be possible to cancel any ongoing command on device close? If there
is agreement on this, I can look into providing a patch.

Thanks. Cheers,
-- 
Daniele

