From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 15 Nov 2007 23:09:00 +0100
References: <473391B0.5040809@domain.hid> <47344759.4020505@domain.hid>
	<473484C6.6050101@domain.hid>
In-Reply-To: <473484C6.6050101@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200711152309.00386.niklaus.giger@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] buildbot and state of xenomai on PPC440?
Reply-To: niklaus.giger@domain.hid
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
Cc: "Steven A. Falco" <sfalco@domain.hid>

Hi

For a series of personal problems I have been away from the xenomai project 
and the buildbot I maintained for some time is quite bit rotten. If there is 
interest around I think I will soon be able to put in some work to bring into 
shape again.

I have a Yosemite PPC440 board at home which I could easily integrate in my 
buildbot environment. At work I sometimes can run tests on our Sequoia 
evaluation board.

At work I was very busy bringing up a custom HW board with a PPC440EPx (very 
close to the Sequoia evaluation board from AMCC) on it. It is running U-Boot 
and in June I ported Linux in a spare couple of hours and it compiled during 
a weekend happily the Linux kernel. As I am having problems getting a 
proprietary OS into a good shape (performance problems, unable to change the 
default page size). Also sometimes I observe a odd application behaviour 
(e.g. spurious problems running some testsuites).

Therefore I would like to get my old (but only half finished) port of our base 
library to the Xenomai vxWorks skin working again.

Following the xenomai mailing list there seems to be some activity on PPC440. 
Could someone please tell me which kernel (denx, stock kernel.org) 
flavour/version against which xenomai worked well? What were the exacts 
parameters for the prepare-kernel.sh? Are these parameters still correct 
against the trunk?

Any hints would be greatly appreciated.

Best regards

Niklaus Giger

