MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18098.6825.990775.730780@domain.hid>
Date: Thu, 2 Aug 2007 19:55:53 +0200
In-Reply-To: <1186053839.6611.326.camel@domain.hid>
References: <46B1A842.1090708@domain.hid>
	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>
	<1186053839.6611.326.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
 > On Thu, 2007-08-02 at 12:54 +0200, Johan Borkhuis wrote:
 > > Philippe Gerum wrote:
 > > > On Thu, 2007-08-02 at 11:47 +0200, Johan Borkhuis wrote:
 > > >   
 > > >> I am experiencing an unexpected switch to secondary mode in a 
 > > >> rt_timer_tsc2ns call from userspace.
 > > >>
 > > >> The following code give a switch:
 > > >>     SRTIME timeStamp;
 > > >>     timeStamp = rt_timer_tsc2ns(rt_timer_tsc());
 > > >>     while((rt_timer_tsc2ns(rt_timer_tsc()) - timeStamp) < (usecs*1000)) {}
 > > >>
 > > >> while the following code does not:
 > > >>     RTIME timeStamp;
 > > >>     timeStamp = rt_timer_tsc();
 > > >>     while((rt_timer_tsc() - timeStamp) < (usecs*1000)) {}
 > > >>
 > > >> (I know that the second example causes a longer timeout, but this was to 
 > > >> show the testcase).
 > > >>
 > > >> When splitting up the 2nd line in the first example I see that the 
 > > >> rt_timer_tsc() call does not cause a switch, but the rt_timer_tsc2ns 
 > > >> does. What am I doing wrong here?
 > > >>
 > > >> I am using Xenomai-2.3.2.
 > > >>
 > > >>     
 > > >
 > > > - Which CPU architecture, and which Adeos patch release are you using?
 > > >   
 > > Processor: ppc 85xx, patch 1.5-03, Xenomai 2.3.2
 > > 
 > > > - How do you notice the switches, SIGXCPU or /proc/xenomai/stat?
 > > >   
 > > SIGXCPU
 > > 
 > 
 > So it's unfortunately possible to experiment such switches on ppc hw for
 > now. It is likely happening when the ns value is copied back to a user
 > variable for which there is a PTE miss to handle in Linux kernel space
 > first. Check the mail archive about "pte", "cow" (copy-on-write) and
 > such things.

Err. ppcs have a tsc accessible in user-space, don't they ? So, I would
expect the conversion to be done in user-space.

-- 


					    Gilles Chanteperdrix.

