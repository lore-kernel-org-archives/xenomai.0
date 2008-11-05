From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 5 Nov 2008 22:54:49 +0100
References: <9c789a000811031222oab34c08n32d94f83288154f3@domain.hid>
	<9c789a000811050028s6cad302erdb4afd7b7d56fa23@domain.hid>
	<9c789a000811051100y23a562a9nd69416a63b859ea@domain.hid>
In-Reply-To: <9c789a000811051100y23a562a9nd69416a63b859ea@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811052254.49588.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] SegFault on Comedi-rtdm for Xenomai!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>, xenomai@xenomai.org

Hi,

> > I build a new kernel with the Xenomai + COmedi trunk and also added
> > XENO_DRIVERS_COMEDI_FAKE AND LOOP  but it seems that the Segmentation
> > Fault is still an open problem. So after compiling my kernel I manually
> > copied the libs (libcomedi.so, librtdm.so....) in my target's /lib
> > directory, and wanted to run ./comedi_config (i.e.) and the problem
> > persists.
>
>    What shall I do , am I missing something , am I doing wrong with the
> kernel build steps??

If I understand correctly your tests:

-> launching comedi_config with the "attach" arguments (./comedi_config 
comedi0 comedi_fake) makes this program crash.

-> Even launching comedi_config without any argument (./comedi_config 
or ./comedi_config -h) does not work.

-> If the attach procedure worked (which is not supposed to be the case as 
comedi_config crashed), cmd_read crashed without any trace.

Is it right ?

If comedi_config (launched with no argument) ends with a segfault, the problem 
might not be related with comedi (the code may not be executed).

Could you launch comedi_config with the tool strace ?

Regards.

Alexis.


