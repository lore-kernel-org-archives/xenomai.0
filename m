From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 09:18:05 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
In-Reply-To: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOUrr-0000FF-0J@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> And i get these messages in dmessage.
>
> Assertion failed! drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:171
> dev->tx_socket == 0
> (3) TX skb still in use

Why are you trying to send loopback messages? Please strip your application 
down to the actual problematic situation. That means, remove all sending code 
and deactivate CONFIG_XENO_DRIVERS_CAN_LOOPBACK. We don't need it here. 
Please ensure that you open only one socket and bind it once. Start a RT 
thread that does nothing else than receiving CAN messages with a blocking 
call inside a while(1)-loop.

--
Sebastian

