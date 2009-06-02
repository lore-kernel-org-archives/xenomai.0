Message-ID: <4A2580C5.4000806@domain.hid>
Date: Tue, 02 Jun 2009 15:43:01 -0400
From: Jeff Angielski <jeff@domain.hid>
MIME-Version: 1.0
References: <4A2452CB.2030909@domain.hid>
In-Reply-To: <4A2452CB.2030909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to chose between xenomai and preempt RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LECOINTRE <adrien20@domain.hid>
Cc: xenomai@xenomai.org

Adrien LECOINTRE wrote:
> Hi,
> 
> I've been testing for a while, Xenomai and Linux preempt RT latencies 
> under different loads and I couldn't find any big differences. Latencies 
> are almost the same.
> So my question is, do you know any case where Xenomai is really better 
> than a simple preempt RT?
> Or which specification in a real time application should make me chose 
> Xenomai instead of preempt RT?

I suspect your loads are not sufficiently exercising your system.

To answer your question, though, it all depends on your requirements, 
whether you need hard or soft realtime.  In other words, is it ok to 
miss your deadline every so often?  If so, CONFIG_PREEMPT would be fine 
for you. If you can't miss any deadlines, use Xenomai.

Of course, just by choosing to use Xenomai, you don't get hard realtime. 
  You still need to design your system and software correctly.

As time marches on, the CONFIG_PREEMPT is getting closer to hard 
realtime, especially with the interrupt threading, but I don't think 
that time is now.

-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com

