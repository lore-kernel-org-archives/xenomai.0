Message-ID: <4B9FE7FC.5090907@domain.hid>
Date: Tue, 16 Mar 2010 21:20:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100316150037.11405209mnid677k@domain.hid>	<4B9FB4A8.6000903@domain.hid>	<20100316183247.34995yxgivc3ilj4@domain.hid>	<4B9FC1F2.1070002@domain.hid>
	<20100316191024.117214qo52wr9aps@domain.hid>
In-Reply-To: <20100316191024.117214qo52wr9aps@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mini2440 on the kernel 2.6.30.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

Michel He wrote:
> How can I exactly figure out which driver is using the Timer 3 ? I  
> wonder if there's a list of interrupt somewhere ? in irq.c ->  
> watch-dog and ac97, Both are disactivated from the kernel.

You are the one who mentioned timer 3 in the first place, but if no
other code than the I-pipe uses it then, that is not your problem. You
have basically no way of knowing that two drivers are accessing the same
hardware registers. Only code inspection cal tell you that.

Please stop top-posting, it makes things really hard to follow for those
who read us.


-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

