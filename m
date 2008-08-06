Date: Wed, 06 Aug 2008 12:30:53 +0200
Message-Id: <1251450790@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] unwanted switch to secondary mode on call to
	rt_dev_ioctl
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

Hello,

my xenomai application performs unwanted mode switches to secondary mode. To find out 
which function is causing the mode switch I activated the T_WARNSW bit for the xenomai 
task involved.  I figured out that a call to rt_dev_ioctl is the cause. Then I found out that the 
responsible rtdm driver does only register an ioctl_nrt handler leaving the ioctl_rt handler 
set to NULL. It seemed logical to me, that  calling a nonrt  driver function  from a xenomai task
in primary mode would cause a switch to secondary mode. 

So I modified the rtdm driver to register the ioctl handler for  both ioctl_nrt and 
ioctl_rt. Unfortunately this did not solve the problem. 

As a next step I reduced the ioctl handler to a "return 0" statement, to be sure that 
no function calls inside the ioctl handler could generate a switch to secondary  mode. 
Again this did not improve the situation. It even seems as if the driver's ioctl handler is not 
called at all.

For the most recent test I wrote a smaller xenomai application that does cyclic  rt_dev_ioctl 
calls on the same rtdm driver from within a seperate xenomai task. The application runs 
without problems, the rt task does not perform any unwanted switches to secondary mode
thus not receiving any SIGXCPU signals.

My configuration
Processor Celeron 400Hz
xenomai 2.4.2
Kernel 2.6.24

I have no idea what is going wrong, any hint is appreciated.
Thanks.


Jochen

_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114


