From: Alessio Igor Bogani <abogani@domain.hid>
In-Reply-To: <43FA139D.9020906@domain.hid>
References: <43FA139D.9020906@domain.hid>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 11:30:50 +0100
Message-Id: <1140517850.7870.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Open a RTDM device driver with standard open()
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

Hi All, Hi Jan,

Apologize for my (very) bad english.

I have a doubt about RTDM:
Is it possible open a rtdm device driver with a open() standard syscall
(without rt_dev_open())? I already tried but open() return always -1 :-(
Obviously rt_dev_open() works perfectly.

Thanks you.

Regards,
Alessio Igor Bogani



