Message-ID: <4B992463.8050202@domain.hid>
Date: Thu, 11 Mar 2010 18:12:03 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Analogy a4l_fill_desc() bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello.

I found a bug in a4l_fill_desc(). If I call it on a descriptor obtained
for an unattached device, the memory allocated for the sbdata descriptor
field is corrupted in a bad way. When, after the failing a4l_fill_desc()
call, I free() it, glibc complains about an "invalid next size" for the
memory chunk.

I'm on x86 architecture using kernel 2.6.30.10 with xenomai 2.5.1.

Thanks. Cheers,
-- 
Daniele

