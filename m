Message-ID: <4829AA19.8070405@domain.hid>
Date: Tue, 13 May 2008 16:47:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid>
	<48297566.1010607@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

DOURNES Guillaume wrote:
> ***********************
> Warning: Your file, V02R00.rar, contains more than 32 files after decompression and cannot be scanned.
> ***********************
> 
> 
> I join to this mail my source code of my driver and my test software. The read and write function of this driver version are already tested, and work as waiting.
> 
> I tried to break out the loop. If I break out after 1 loop, the software works, but if I break out after 2 loops, the sofware freeze and the result (printf) of the first loop is not printed.

Didn't have to time to unpack your archive (is the driver so complex?).
So you may try to continue with debugging: Does the watchdog catch
something? Is there something on the kernel console after lockup. If
not, attach a serial line and redirect the console to it. Maybe you see
an oops.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

