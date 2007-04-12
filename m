Date: Thu, 12 Apr 2007 09:24:05 +0200
Message-Id: <489168738@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] how to release file descriptor after application
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
To: xenomai@xenomai.org

Hello,

is there any way to release a file descriptor associated with a rtdm device after an application crash ? The reason I'm asking this is the following:
My application uses a rtdm device that can only be used in exclusive mode. When the application crashes while the device was opened, I have to reboot the system in order be able to use the device again. Is there a way to release the file descriptor or to close the device without rebooting.

Regards

Jochen
_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192


