Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1077)
From: Stefan Schaal <sschaal@domain.hid>
Date: Wed, 17 Feb 2010 13:23:20 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid>
Subject: [Xenomai-core] Analogy DIO speed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>

Thanks to Alexis's Analogy development, digital I/O is possible with =
Xenomai using National Instrument DAQs. While the basic DIO =
functionality works in the most current xenomai-head, I am  wondering =
how to achieve maximal I/O speed with the 32 bit digital I/O sub-device =
on my NI6259 card.=20

The options are

1) single acquisition with a4l_sync_dio()
2) instructions and instruction lists using a4l_snd_insnlist() and =
a4l_snd_insn()
3) streaming acquisition with commands (e.g., a4l_snd_command() and =
related functions)

My question concerns how many 32-bit DIO instructions per second I
should be able to achieve with the various options.

For instance, option 1) seems to take about 5000 nanoseconds on my
Ubuntu 8 core i386 computer (3Ghz processors).
Is this normal? Or should it be faster?

Option 2) seems to give me about 50% speed up, i.e., roughly 3500
nanoseconds per DIO.

Would option 3) give me a massive speed up and get me closer to the
20Mhz processing power of the NI 6259 board? I have some problems with=20=

implementing commands on my NI6259 so far.

Thanks a lot for any help!

-Stefan

