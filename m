From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 18 Nov 2008 00:20:53 +0100
References: <9c789a000811080850q47f5b429k130fff3f64985aa3@domain.hid>
	<9c789a000811131546j367ad76fk7d05a21848b18bd@domain.hid>
	<9c789a000811160611h6658153ao32f643c8fda1af5b@domain.hid>
In-Reply-To: <9c789a000811160611h6658153ao32f643c8fda1af5b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811180020.53836.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] SegFault on all multiple apps!!
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

> I finally managed to solve the SegFault problem, so the thread should be
> closed.
>
>  I've created a root filesystem on my USB Flash stick where I added the
> xenomai dir (including /bin /lib /include...) generated during the Xenomai
> (from the trunk) install and also the devices rtheap rtp0... in the /dev
> directory of my FS. I also used the proper libc-2.6 standard shared
> libraries so the dynamic linker does't send a SIGSEGV anymore and  I am
> able now to run ./latency or ./cyclictest (altough I'm not really sure if
> the results are proper !). I don't receive SegFault anymore.
>
> But a problem when running ./cmd_write I get :
>     cmd_write: comedi_get_chinfo failed (ret=-22)
> So it cannot find any channel info , so is it possible that an error ocured
> when loading a specific file descriptor??

Did you attach a driver to a specific Comedi device (thanks to 
comedi_config) ?

> I also would like to check somehow the validity of my Xenomai and Comedi
> installation. Is it possible to do this ??

Could you send the results of "cat /proc/comedi/devices" 
and "cat /proc/comedi/drivers" ?

Best regards ,

Alexis.


