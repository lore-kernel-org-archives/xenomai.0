Date: Wed, 17 Aug 2011 16:04:30 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <alpine.DEB.1.10.1108171557300.25850@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] Freeze with gpio-keys with Xenomai on Blackfin
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I was just trying to use the gpio-keys driver on a Blackfin BF537 in
uClinux environment with Xenomai integrated. However, whenever a key
is pressed (regardless whether anyone reads from input event dev),
the whole system freezes. No more communication, no network access.
Without Xenomai however, I was able to use the driver.

Before I set up my JTAG interface to get more details (need to make a new
cable...) I'd like to ask if anyone else has experienced this (and remedy..)?

- Linux version 2.6.34.7-ADI-2010R1
- I-pipe 1.15-01
- Xenomai: real-time nucleus v2.5.5.2

Thanks,
Kolja


