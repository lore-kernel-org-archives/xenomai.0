From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 22 Nov 2006 16:47:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GmuKK-0003pF-Hg@domain.hid>
Subject: [Adeos-main] [BUG?][ARM] System hangs with enabled I-pipe and USB
	devices
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

another tricky problem to solve with my I-pipe patch for S3C24xx ARM:

If I connect an USB device when I-pipe is enabled the system hangs. I found 
out that the Linux ack routine for the USB interrupt is called in an endless 
loop. With disabled I-pipe this routine is called 24 times at connection 
time.

Does anyone have a useful hint to locate the problem?

--
Sebastian

