From: Asutosh Satapathy <sasutosh@ethz.ch>
Message-ID: <78f5f51a-dce0-f7f3-bed3-e2c908a14276@ethz.ch>
Date: Wed, 24 Aug 2016 21:07:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  16550A Baud Rate Limitation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello All,

This is my first ever mail to this mailing list. I apologize in advance 
if my mail is not adhering to the etiquettes of this mailing list. 
Having said that,

Context: I have recently started working with xenomai 2.6.4 for serial 
communication. My program needs to read and write to an IMU. The serial 
card supports higher baud rate. I do an insmod to load the 
xeno_16550A.ko driver for the serial port at 230400 baud base. And then 
when I run the program, error occurs. But the program runs fine for 
115200 baud base.

Problem: To restate, my program works fine for serial communication at 
baud rate of 115200. But I am getting errors when I try to read data at 
a higher baud-rate i.e. 230400 and higher.

Errors: 1. rt_dev_read : Input/Output Error
             2. rt_dev_read : Broken Pipe

Questions:
1. Is there a driver limitation on the baudrate? I was not able to find 
any documentation regarding this.
2. If there are no limitations, any suggestions on this?
2.1. Why am I getting the error while trying to read the data and not 
when I am trying to open the port.

Thanks a lot in advance.

Thanks
Asutosh

