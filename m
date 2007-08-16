MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18116.37871.209453.702969@domain.hid>
Date: Thu, 16 Aug 2007 20:14:07 +0200
In-Reply-To: <46C44CE5.5050202@domain.hid>
References: <46C44CE5.5050202@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Time for rt_mutex_acquire
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dirk Eibach wrote:
 > Hello,
 > 
 > I'm wondering how long a rt_mutex_acquire is supposed to take on a PPC405 
 > platform. I'm getting times about 50 usec here, which is too much for my 
 > application. Is anything wrong in my kernel/xenomai configuration or is 
 > this time to expected?

How do you measure this ? Are you sure the mutex is free when you try to
acquire it ?

-- 


					    Gilles Chanteperdrix.

