MIME-Version: 1.0
Date: Sat, 12 Jun 2010 12:09:32 +0800
Message-ID: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] error on rt_dev_read, code Success,
	what does it mean?
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

I am developing a real time programming using xenomai, RTDM. When
I try to read serial port, I sometimes get this message:

error on rt_dev_read, code Success

I checked my program and found that when rt_dev_read returns a
negative number, this message is printed. What does this error message
mean? It seems that my port is open when I tried to read from it.

Thanks in advance,

Everett

