Date: Mon, 27 Aug 2007 13:14:49 +0200
From: "Axel Beierlein" <belatronix@domain.hid>
Content-Type: text/plain; format="flowed"; delsp="yes"; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.txptjeaot06gyn@domain.hid>
Subject: [Xenomai-help] rtdm driver Problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Hello,

i try to port a standard serial Driver into an RTDM one following Jan´s  
example 16550A.c.
When i try to initialize the rx/tx timeouts in my set_config routine with:

	if (testbits(config->config_mask, RTSER_SET_TIMEOUT_RX))
            ctx->config.rx_timeout = config->rx_timeout;

and call an rt_dev_open("sername",0) in my testapplikation i get an  
"floating point used in kernel ...." on my ppc.
I use all the structures that Jan have defined.
Could it bee that the uint64_t var´s rx_timeout / tx_timeout are the  
reasons (especially the <unsigned long long int> typedef for an ppc)?

Axel


