Message-ID: <503643C5.4030405@xenomai.org>
Date: Thu, 23 Aug 2012 16:52:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50350308.8010405@openwide.fr>
	<50350712.4020704@xenomai.org>	<5035E4CD.9080302@xenomai.org>
	<50364114.9090804@openwide.fr> <503641EA.2020201@xenomai.org>
In-Reply-To: <503641EA.2020201@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] s3c24xx: Priority rotate enable !?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 08/23/2012 04:44 PM, Gilles Chanteperdrix wrote:
>>> - failing that, check that the tsc emulation based on the decrementer
>>> really works, and maybe fix it if it does not work. Or simply use a
>>> different hardware timer for tsc emulation than for the timer.
>>>
>> I used Xenomai 2.6.0 with kernel 2.6.38.8 on mini2440 board during my 
>> internship.
>> I haven't seen bug with tsc emulation.
> 
> To see if there is a bug, you should read the tsc, sleep for 30 minutes,
> read the tsc again, and check if the difference corresponds to 30
> minutes. Have you done that test?

With a latency test running in parallel.

-- 
					    Gilles.

