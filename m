From: "George Pontis" <GPontis@z9.com>
References: <009c01cd539e$e9f81420$bde83c60$@com>	<4FF057F2.7040109@xenomai.org>
	<03de01cd580a$f9016d70$eb044850$@com>
	<4FF16086.1030903@xenomai.org>
In-Reply-To: <4FF16086.1030903@xenomai.org>
Date: Mon, 2 Jul 2012 08:03:23 -0700
Message-ID: <001801cd5863$d3484d70$79d8e850$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Monday, July 02, 2012 1:49 AM
> To: George Pontis
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] ARM, exception #0 ?
> 
> On 07/02/2012 06:27 AM, George Pontis wrote:
> > on the host. And I _still_ have not been able to coax any detailed
> > output from the kernel with CONFIG_DEBUG_USER and user_debug=29. I
> > know that this is declared because an added printk shows that it is
> > executing the function user_debug_setup in arch/arm/kernel/traps.c
> > which is dependent on CONFIG_DEBUG_USER. But no additional info shows
> > after the fault, including the fault from your test application.
> 
> That is supposed to work. What does /proc/sys/kernel/printk say?
> On my side, I get:
> # cat /proc/sys/kernel/printk
> 7       4       1       7
> 
> --
> 					    Gilles.

The same here.

George



