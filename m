Message-ID: <487DB064.9010301@domain.hid>
Date: Wed, 16 Jul 2008 10:25:08 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <6132061f0807141723u5125f946m324749aa81fbdcc6@domain.hid>	<200807150803.52326.Sebastian.Smolorz@domain.hid>
	<6132061f0807151602j50626e9bse74d5b578418fd56@domain.hid>
In-Reply-To: <6132061f0807151602j50626e9bse74d5b578418fd56@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtsocketcan in kernel space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: xenomai@xenomai.org

Breno Carneiro Pinheiro wrote:
> Thanks Sebastian. Btw, I'd like to know whether  it's possible to change the
> task's period or task's priority on-line. I mean, is there a way to change
> the period or priority using rt_task_set_priority or rt_task_set_periodic
> calls?

All this is described in the API documentation, see:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__task.html

In short: Yes, it is possible.

-- 
Sebastian

