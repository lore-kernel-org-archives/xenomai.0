Message-ID: <4C73EC62.80703@domain.hid>
Date: Tue, 24 Aug 2010 17:59:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [RFT] ipipe patch for 2.6.35.3-x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-help <xenomai@xenomai.org>

Hi,

just uploaded a forward port of the 2.6.34 ipipe patch for x86 to latest
stable 2.6.35.3. It boots and runs fine here in 64-bit mode with Xenomai
head, but I only ran light tests so far. Anyone interested in upgrading
the host kernel (I think I read some request recently) is welcome to
give it a try and report results back (specifically on 32 bit as that is
a bit out of focus for me ATM). You can download the full git tree from

	git://git.kiszka.org/ipipe-2.6.git queues/2.6.35-x86
	(alternatively also via http://)

Looking forward to feedback,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

