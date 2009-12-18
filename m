Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <4AE9E5AC.7050401@domain.hid>
Date: Fri, 18 Dec 2009 13:10:42 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F6D4575-0CF0-49E6-A7ED-1A045BE8D5B4@domain.hid>
References: <1B242B31-29DB-4363-8B08-8E77B2928C34@domain.hid>
	<4AE9A1DB.1060506@domain.hid>
	<67A93E2E-3273-45B0-ACCE-9FC7A104F9A5@domain.hid>
	<FF6D4747-95BE-4B18-8B77-864B7DA5EAEF@usc.edu>
	<4AE9E5AC.7050401@domain.hid>
Subject: [Xenomai-core] digital I/O with analgoy using ni_pcmcia
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jonas Buchli <jonas@domain.hid>, Peter Pastor Sampedro <pastorsa@domain.hid>, Ludovic Righetti <ludovic.righetti@domain.hid>

Hi everybody,

  we have an NI6259 board working xenomai 2.5, using the analogy APIs. =
Read/write to analog channels is quite straightforward and can be =
inferred from the cmd_read and cmd_write source code. Now I would also =
like to use the digital I/O of this board (e.g., the 32 digital I/O =
lines). In Comedi, there are functions to set the DIO lines to =
input/output mode (comedi_dio_config), and then functions to read/write, =
like comedi_dio_read and comedi_dio_write. Does xenomai/analogy already =
have similar functionality?

Thanks a lot,

-Stefan=

