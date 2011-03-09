From: Nazarov Sergey <s-nazarov@domain.hid>
MIME-Version: 1.0
Message-Id: <540841299685269@domain.hid>
Date: Wed, 09 Mar 2011 18:41:09 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: Re: [Xenomai-core] Runtime error on PXA270 for branch
	'for-ipipe-2.6.35-arm' in 'ipipe-gch.git'
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: michael.bernhard@domain.hid
Cc: xenomai@xenomai.org

Hello!
The problem is the same as on my Compulab EM-X270 board, I think. dm9000 ethernet controller works unstable with level-type irq handler.
Sergey.

