Message-Id: <200711261415.lAQEFdoD028307@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Mon, 26 Nov 2007 15:15:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <2ff1a98a0711260528nd5b56b1he0a41f0239b2236e@domain.hid>
Subject: [Xenomai-help] RTDM blocking non RT task
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

I have a non-RT task (from user space) reading an RTDM driver (nrt_read).
I would like to block the task on read as long as RTDM doesn't have data to
read.
For the moment I use rt_event_wait but it doesn't work with non-RT task (it
works only with a RT task).

Do you have any idea?

Thanks Patrick



