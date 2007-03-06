Message-ID: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
Date: Tue, 6 Mar 2007 08:03:11 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] CAN problem continued
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

FYI

With enlarged ring buffer the overflow still takes place.

I have still not figured out why the can controller only runs in
passive mode from my application.

And i get these messages in dmessage.

Assertion failed! drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:171
dev->tx_socket == 0
(3) TX skb still in use
xeno_can: socket buffer overflow (fd=0), message discarded

The top message only once the bottom one the famous message that
happens all the time. I am now going to turn off the debug messages in
the config. I think there is something wrong with rt-can's error
logging behaviour.

Regards,

Roland.

