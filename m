Message-ID: <46DE59D6.1040107@domain.hid>
Date: Wed, 05 Sep 2007 09:25:10 +0200
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] pb sharing xeno heap data with std kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,

I have setted up a shared heap between a kernel module and an user space
app.

However another "std" kernel model would need a ptr to some data in it .

rt_heap are virtual adresses I suppose.

Is there a way to give a phys pointer to the other kernel module  ?

Best Regards
Steph


