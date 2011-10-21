Message-ID: <4EA13402.8010605@domain.hid>
Date: Fri, 21 Oct 2011 10:57:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAtf-FfFezJdSr6w0YbStuVp8MdUxP+xLjw0LuvTAcdVuc8oXw@domain.hid>
In-Reply-To: <CAAtf-FfFezJdSr6w0YbStuVp8MdUxP+xLjw0LuvTAcdVuc8oXw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interruption of sata hard driver's during
 real-time task running
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Donggu Kang <cdslashboot@domain.hid>
Cc: xenomai@xenomai.org

On 10/21/2011 09:23 AM, Donggu Kang wrote:
> Dear all
> 
> 
> I tried to test of latnecy with a etherlab on the xenomai framework.
> The etherlab is ethercat master implimentation in the Linux Evironment
> and It's using normal ethernet interface card.
> 
> In my test, I have found huge latency under hard disk stress situation.
> For making hard disk stress, I ran nomal linux process that is "while:
> do ls -lR / > /tmp/list; done & > /dev/ null".
> After than I also run xenomai task with etherlab master api.
> 
> The latest latency is above a 500us. It is unacepptable on my system.
> When I run latency test tool of xenomai, the latency is under a 5us

I am a bit at a loss here. Is the latency 5us or 500us? If the 500us
latency is measured using a tool running through normal ethernet
interface card, it can not be considered a real-time task, even if the
task doing the measurement was created using one xenomai's skins, so the
latencies you measure are linux latlencies.

> 
> I think the real-time task and communication of NIC is intercepted by
> hard disk IRQ.
> 
> Is there any idea to prevent interruption of sata hard driver's during
> real-time task run.

When a real-time task runs in primary mode, it can not be interrupted by
any Linux interrupt. However, a real-time task using linux services
(such as linux network services), it will switch to secondary mode, and
a linux irq will be able to interrupt it.

-- 
					    Gilles.

