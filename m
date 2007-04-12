From: Sebastian Smolorz <ssm@domain.hid>
Date: Thu, 12 Apr 2007 09:32:32 +0200
References: <489168738@domain.hid>
In-Reply-To: <489168738@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HbtnE-0003o2-NP@mailer.emlix.com>
Subject: Re: [Xenomai-help] how to release file descriptor after application
	crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jochen Behnke <JK.Behnke@domain.hid>
Cc: xenomai@xenomai.org

Jochen Behnke wrote:
> Hello,
>
> is there any way to release a file descriptor associated with a rtdm device
> after an application crash ? The reason I'm asking this is the following:
> My application uses a rtdm device that can only be used in exclusive mode.
> When the application crashes while the device was opened, I have to reboot
> the system in order be able to use the device again. Is there a way to
> release the file descriptor or to close the device without rebooting.

See the note to the description of rt_dev_close in the RTDM API documentation.
(http://www.xenomai.org/documentation/trunk/html/api/group__userapi.html#ga34c1ddf4e2deb727a1ab3cd648ce5d9)

-- 
Sebastian

