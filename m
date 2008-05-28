Message-ID: <483D2177.7010909@domain.hid>
Date: Wed, 28 May 2008 11:10:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <483D1D9A.7010209@domain.hid>
In-Reply-To: <483D1D9A.7010209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
> Hello,
> 
> I am trying to use semaphores inside my driver. It is a driver that can 
> be used as standard Linux driver and RTDM driver.
> 
> However, when I use rt_sem_p or rtdm_sem_timeddown in my read_nrt 

Calling those blocking RT services over a non-RT RTDM handler is a
strong indication that you are doing something fundamentally wrong.

(BTW, for consistency reasons, you shouldn't use native API services in
RTDM drivers. Technically, this can be OK, but it is at least very unclean.)

> function I get a -1 return value, indicating EPERM. When I look at the 
> thread state I see a value of 0x00400080, which indicates a standard 
> Linux thread. The rtdm-context is 0x00000001.
> The userspace thread has a thread state of 00300380.
> 
> What am I doing wrong here? How can I get a semaphore or other sync 
> mechanism to work inside my RTDM driver?

RT resources are for RT threads in _primary_ mode. Why do you want to
pend on those resources while the threads are in secondary ("nrt") more?

> 
> We are using Xenomai 2.4.1 on Linux 2.6.20 for powerpc.
> 
> Kind regards,
>     Johan Borkhuis
> 

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

