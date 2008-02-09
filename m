Date: Sat, 9 Feb 2008 12:13:37 +0100 (CET)
From: Michael Trimarchi <trimarchimichael@domain.hid>
In-Reply-To: <d6c8ef150802081142y54648ecex5b307eb3c25e5086@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <246938.91746.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: david-b@domain.hid, adeos-main@gna.org

Hi,
> Thanks. Actually, I have simillar problems (buffer
> overrun) when working
> with serial port (at91sam9260-ek based board). But,
> I haven't inspected the
> problem more than that. I'll do that next week.
> 
> On Feb 8, 2008 8:36 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org>
> wrote:
> 
> >
> > I received a mail from Michael recently telling me
> that he observes the
> > same behaviour with the PREEMPT_RT patch, so the
> I-pipe patch is
> > probably out of cause. He now suspects a hardware
> issue (one serial port
> > pin seems to be shared with another peripheral, as
> I think I understood).
> >
> >
>
I finish my investigation, and I think that depens
only 
in some overhead. In linux is present using hrtimer
and doesn't depends on NO_HZ options. If some hrtimer
is executed with the interrupts disabled and the
serial
must receive a single char, you receive and overrun.
I suppose that the NO_HZ option can be a solution
(less interrupt) but an the end, doesn't change. The
dma
patch on serial device resolve the problem. I think
that for adeos is the same. I try to investigate, how
long is the max blocking time in hrtimer interrupt.

Using TC timer is ok. David and Gilles, you are right
but I want to know how in linux-rt and adeos, I can
reduce the latency to support this interrupts
frquency.

Regards Michael



      ___________________________________ 
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: 
http://it.docs.yahoo.com/nowyoucan.html

