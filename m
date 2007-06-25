Message-ID: <467FBC67.8030805@domain.hid>
Date: Mon, 25 Jun 2007 15:00:23 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai and mlockall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

I am trying to run my Xenomai application as non-root. I disabled 
XENO_OPT_SECURITY_ACCESS to allow non-root users to run Xenomai 
applications. However, this causes my application to exit with the error:

Xenomai: process memory not locked (missing mlockall?)

Is there a way to avoid this error? I am running on an embedded system 
without swap and without disk, so there is no real need for mlock or 
mlockall.

Is there a way to "tweak" the CAP_IPC_LOCK capability of the system or 
the task so that I can run mlockall call, or is there a way to disable 
this check on Xenomai?

Kind regards,
    Johan Borkhuis

