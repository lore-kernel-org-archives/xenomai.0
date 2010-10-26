Message-ID: <4CC73D72.4080708@domain.hid>
Date: Tue, 26 Oct 2010 22:43:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTin30_=udvCD6D87cV4yqYoMt+BMTo4is8COdv_f@domain.hid>
In-Reply-To: <AANLkTin30_=udvCD6D87cV4yqYoMt+BMTo4is8COdv_f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Serial Driver for PCI Card
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

Peter Warner wrote:
> Hi,
> 
> I have two serial ports in my system one is generic and another one is
> on add-on cards(PCI).
> I compiled the xenomai serial driver as a module and when I am trying to
> load it using the following command:
> 
> modprobe xeno_16550A io=0x3f8, 0x2f8 irq=4,3 baud_base=115200,115200
> 
> then I am getting the error message unknown symbol in object for more
> information type dmesg.  when I am typing dmesg I am getting the
> message  unknown identifier "io".
> 
> Can anyone suggest what are the steps to be taken or to modify the
> driver for the extended serial port.  or Else I have the linux driver
> for it provided by the vendor Is there any way that it can be made to
> xenomai complaint. If it can be done then please suggest what are the
> steps to be taken.

See:
http://www.xenomai.org/index.php/16550A

And:
http://www.xenomai.org/index.php/Request_for_information


-- 
                                                                Gilles.

