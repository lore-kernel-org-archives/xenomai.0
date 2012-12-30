Message-ID: <50E0BB31.8020502@xenomai.org>
Date: Sun, 30 Dec 2012 23:07:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFv1zn4i8M=m65+jxK9ch7R6GWdfuMOqXiCsz+GY=BiJ=10iOw@mail.gmail.com>
In-Reply-To: <CAFv1zn4i8M=m65+jxK9ch7R6GWdfuMOqXiCsz+GY=BiJ=10iOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real time Watchdog timer device driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Cc: xenomai@xenomai.org

On 12/30/2012 09:11 PM, RAGHAVENDRA GANIGA wrote:

> I am about to start my work on real time device driver for watch dog timers
> on panda board and want to benchmark my driver , for this i need a rtos
> model for the already existing device driver for watch dog timer to and
> also would like to have suggestions from your side to progress in my
> project. Thank you


If you are looking for a device profile for watchdog drivers, I do not
think we have one, however, I do not think you really need a real-time
driver for these either.

If you plan to use hardware timers as timers, then they are probably
best kept in kernel-space and used by drivers instead of being exposed
to applications.

-- 
                                                                Gilles.

