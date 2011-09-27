Message-ID: <4E81D866.5000504@domain.hid>
Date: Tue, 27 Sep 2011 16:06:30 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Analogy: idx_write_subd field in a4l_desc_t
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

I'm using xenomai-head on a 2.6.38.8 kernel on x86 with a NI-6251 DAQ
board. In this configuration the idx_write_subd field of the a4l_desc_t
structure filled by a4l_open() is not set to the proper value but is set
to NULL.

In previous xanomai/analogy releases this was working properly. Has some
initialization code been removed in the latest analogy drivers refactoring?

Thank you. Cheers,
-- 
Daniele

