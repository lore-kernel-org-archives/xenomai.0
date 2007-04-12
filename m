Date: Thu, 12 Apr 2007 11:25:51 +0200
Message-Id: <489403086@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?how_to_release_file_descriptor_aft?=
 =?iso-8859-15?q?er_application_crash?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org


Hello Sebastian and Jan,

the following command line solved the problem :-)

# echo <fildescr_to_cleanup>   > /proc/xenomai/rtdm/open_fildes


Thanks for your help.

Regards

Jochen


> Sebastian Smolorz wrote:
> > Jochen Behnke wrote:
> >> Hello,
> >>
> >> is there any way to release a file descriptor associated with a rtdm device
> >> after an application crash ? The reason I'm asking this is the following:
> >> My application uses a rtdm device that can only be used in exclusive mode.
> >> When the application crashes while the device was opened, I have to reboot
> >> the system in order be able to use the device again. Is there a way to
> >> release the file descriptor or to close the device without rebooting.
> > 
> > See the note to the description of rt_dev_close in the RTDM API documentation.
> > (http://www.xenomai.org/documentation/trunk/html/api/group__userapi.html#ga34c1ddf4e2deb727a1ab3cd648ce5d9)
> > 
> 
> For trunk, the paragraph about stalled descriptors need to be removed
> (good that you referred to it). RTDM of upcoming Xenomai 2.4 performs
> automatic file descriptor cleanup now.
> 
> Jan
> 
> 
> 


_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192


