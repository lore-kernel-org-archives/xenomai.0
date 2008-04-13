MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18434.20091.539340.811557@domain.hid>
Date: Sun, 13 Apr 2008 20:18:35 +0200
In-Reply-To: <005301c89d88$918f9b80$0202a8c0@domain.hid>
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>
	<18433.65.910459.873472@domain.hid>
	<000701c89d68$8857e380$0202a8c0@domain.hid>
	<48020FEA.20309@domain.hid>
	<003401c89d78$d187bf70$0202a8c0@domain.hid>
	<18434.11505.241730.648326@domain.hid>
	<005301c89d88$918f9b80$0202a8c0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Communication between Xenomai and Linux domains
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: van der Linden <ejvanderlinden@domain.hid>
Cc: xenomai@xenomai.org

van der Linden wrote:
 > Gilles,
 > 
 > I see the problem.
 > I think the best (easiest) way is not using the libasound library but using 
 > the kernel driver directly.

It will not work either. The kernel driver uses some synchronization
objects such as mutexes, semaphores, spinlocks that only work in Linux
domain. So, you really need to rewrite a driver using RTDM's own
synchronization objects.

 > 
 > Then using "borderline" threads for the non-realtime tasks.
 > 
 > If this is right I keep still one question,
 > 
 > What can be used as performance measurement tool.
 > The normal "top" Linux command will only show IRQ's taking almost 100% of 
 > the cpu loading. I gues that must be the Xenomai schedular but how can I 
 > display the loading the Xenomai threads realy take?

cat /proc/xenomai/sched or /proc/xenomai/stat but you really have other
issues to solve before you care about that.


-- 


					    Gilles.

