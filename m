MIME-Version: 1.0
From: Peter Soetens <peter@domain.hid>
Date: Fri, 9 Jul 2010 12:26:39 +0200
Message-ID: <AANLkTilLcPtUo564fICdJQtOQAjbvVj2l2Oxq8F3yycp@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] IXXAT SJA_MOD register refuses to set up dual
	channel cards
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,

(Xenomai 2.5.2&2.5.3)

I'm testing the rtcan ixxat driver for a dual channel card (PLX
Technology, Inc. Device 2540)

It recognizes the first channel, but refuses to setup the second one
because the SJA_MOD flag is 0x7f instead of 0x21
The SJA_IR and SJA_SR flags read as are what the driver expects.

Any suggestions on what it means and how to fix this ?

Thanks,
Peter

