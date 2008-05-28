Message-ID: <483D1FEE.7050203@domain.hid>
Date: Wed, 28 May 2008 11:03:42 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <483D1D9A.7010209@domain.hid>
In-Reply-To: <483D1D9A.7010209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with semaphores in an RTDM driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Johan Borkhuis wrote:
> I am trying to use semaphores inside my driver. It is a driver that can 
> be used as standard Linux driver and RTDM driver.
> 
> However, when I use rt_sem_p or rtdm_sem_timeddown in my read_nrt 
> function I get a -1 return value, indicating EPERM.

Your read_nrt function is only for non real-time tasks. So if you use a 
call to a service which requires primary execution mode of Xenomai it 
consequentially fails.

> When I look at the 
> thread state I see a value of 0x00400080, which indicates a standard 
> Linux thread. The rtdm-context is 0x00000001.
> The userspace thread has a thread state of 00300380.
> 
> What am I doing wrong here? How can I get a semaphore or other sync 
> mechanism to work inside my RTDM driver?

Use RTDM services inside the *_rt functions and plain Linux services 
inside the *_nrt functions of your driver.

-- 
Sebastian

