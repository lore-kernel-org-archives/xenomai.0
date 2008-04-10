Message-ID: <d6c8ef150804100739n3201e282u812e0ce316c7da3d@domain.hid>
Date: Thu, 10 Apr 2008 16:39:07 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] RTDM example: Ethernet driver
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

Hi!

Is there any kind of a small example of Ethernet driver done in RTDM?
I know for RTnet, but don't need full Ethernet driver - I just have to
send and receive one frame. I'm migrating our application from kernel
modules to user space, so I need to migrate also stripped version of
MACB driver. (MACB is connected directly to EtherCAT ET1200 asic,
without PHY) Actually, I need to export to the user space only one
function.

Thanks

