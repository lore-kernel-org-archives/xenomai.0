Message-ID: <4A28FD20.1020400@domain.hid>
Date: Fri, 05 Jun 2009 13:10:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid><4A28FAD7.3E52.00F8.0@domain.hid>
	<4A28E5E0.9020805@domain.hid> <4A2907EF.3E52.00F8.0@domain.hid>
In-Reply-To: <4A2907EF.3E52.00F8.0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

Karl Tyss wrote:
> Hi,
> 
> thank you for the quick answer.
> 
> The idea with deactivating the caches is to see if they are influencing
> this behavior. I also tried out the FCSE option and it did not help. My
> issue is that if there is a user space application that starts lots of
> short processes/threads and sleeps for a short time, in this case I get
> a large jitter. Till this point I was able to find out that it makes a
> difference if the idle task is running. 

How large ? If it is something around 200us it is normal for an ARM.
Note that the cache flush is not alone, there is also a TLB flush. If
you do not want the TLB flush, then you will have to run ucLinux.

-- 
					    Gilles.

