Message-ID: <4C1353D8.2060507@domain.hid>
Date: Sat, 12 Jun 2010 11:31:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
In-Reply-To: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error on rt_dev_read, code Success,
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
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> Hi,
> 
> I am developing a real time programming using xenomai, RTDM. When
> I try to read serial port, I sometimes get this message:
> 
> error on rt_dev_read, code Success
> 
> I checked my program and found that when rt_dev_read returns a
> negative number, this message is printed. What does this error message
> mean? It seems that my port is open when I tried to read from it.

It means that you are probably using errno, and since rt_dev_read does
not set errno, you get "Success" as error message instead of the real
error message. If you want to print the real error message, you should
use strerror(-rc) where rc is the return code of rt_dev_read.

But of course, I am just guessing here, seeing your test code would help
more.


-- 
					    Gilles.

