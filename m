Message-ID: <4E412D63.4080105@domain.hid>
Date: Tue, 09 Aug 2011 14:51:47 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] xenomai-head compile failure
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm compiling xenomai-head on i386 debian/testing. I found that the file
src/skins/posix/wrappers.c is missing an include of signal.h for the
definition of pthread_kill().

Cheers,
-- 
Daniele

