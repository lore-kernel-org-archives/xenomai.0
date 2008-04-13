Message-ID: <48024CFC.9030806@domain.hid>
Date: Sun, 13 Apr 2008 14:12:12 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_intr_create, rt_intr_enable returning ENOSYS
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

could anyone advise me under what circumstances would a call to 
rt_intr_create from user space return -ENOSYS ?

I'm probably trying to listen to an interrupt which the Linux kernel 
already listens to, could this be the case ?

Thanks,
Tomas

