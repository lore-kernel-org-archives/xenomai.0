Message-ID: <44603695.2020407@domain.hid>
Date: Tue, 09 May 2006 14:28:37 +0800
From: Liu Zhenghui <ferretliu@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] A bug of udev rules?
Reply-To: ferretliu@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai <xenomai@xenomai.org>

I installed xenomai on Debian Linux sid. For some reason, I recently
changed to udev to manage the /dev. Then udev always report error on
rules installed by xenomai at boot time like following:

: add_to_rules: invalid KERNEL operation
: add_to_rules: invalid rule '/etc/udev/rules.d/udev.rules:100'

As a result, the device rtheap and rtp* is not controlled by udev rules
and always has default mode "0660".

I found there is wrong with rules installed by xenomai, which source is
located at ksrc/nucleus/udev/*.rules:

# real-time heap device (Xenomai:rtheap)
KERNEL="rtheap",  NAME="rtheap", MODE="0666"
      ~should be "==" here, not "="

My udev version in debian is 0.091-2, kernel version is 2.6.15.7

Is it a bug? Luckly, it works after I changed "=" to "=="


