References: <200911111422.11402.anisha.kaul@domain.hid>
	<4AFA8197.7070005@domain.hid>
In-Reply-To: <4AFA8197.7070005@domain.hid>
MIME-Version: 1.0
Date: Wed, 11 Nov 2009 18:49:24 +0530
Message-ID: <200911111849.24423.anisha.kaul@domain.hid>
From: Anisha Kaul <anisha.kaul@domain.hid>
content-type: text/plain; charset=iso-8859-1
content-transfer-encoding: 7bit
content-disposition: inline
Subject: Re: [Xenomai-help] unable to open serial port from a kernel module
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

> Anisha Kaul wrote:
> > hi,
> >
> > when i use rt_dev_open ("/dev/ttyS0", 0); from the function init_module
> > () of a self written kernel module, it returns -19 ! What must be the
> > reason, can't a file be opened from a kernel module ?
>
> Please read documentation and examples more carefully: "rtdev0" is the
> answer.
>
> Jan

Thanks for being patient, 

Did you mean this --> ''rtdm_open ("rtdev0", 0);" 
I tried this from the init_module () of the concerned kernel module, it still 
returns '-19'.

Anyways, as per your example '', I tried --> "rt_dev_open  ("rtdev0", 0);" 
from the main () function of the user space program. As per one of your mails 
I added "-lrtdm" to the LDFLAGS of the concerned Makefile for the compilation 
of rt_dev_open. The program compiled without errors but still it 
returns '-19'.

regards,
anisha

-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





