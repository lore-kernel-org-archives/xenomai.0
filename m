From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Jun 2010 15:30:02 +0200
Message-ID: <1276090202.18906.86.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC] Deprecating the RTAI emulator
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


I have committed a change in my tree, marking the RTAI emulator as
deprecated, with a complete removal scheduled for 2.6.x. The reasons are
explained there:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=2b66eb3839defc67f60ca75f73b4437c6023411f

I intend to submit the deprecation patch to Gilles, to be merged into
2.5.4, for warning users about the planned removal. If you have any
strong argument against this removal, you should really make some noise
now.

-- 
Philippe.



