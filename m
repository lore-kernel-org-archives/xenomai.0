Message-ID: <4921761C.5020204@domain.hid>
Date: Mon, 17 Nov 2008 14:48:12 +0100
From: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Subject: [Xenomai-help] save FPU context in userspace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi List,

I wrote an interrupt handler a few times ago. This handler is an idle=20
task which use the function *rt_intr_wait(&intr_desc, TM_INFINITE).
*
The programm works fine, but I would like to know if I have to save the=20
fpu context when an interrupt occurs and if there's a function to do it?

Best regards,
C=E9dric

