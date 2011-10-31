Message-ID: <4EAE9E50.1060507@domain.hid>
Date: Mon, 31 Oct 2011 14:10:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAtf-FfFezJdSr6w0YbStuVp8MdUxP+xLjw0LuvTAcdVuc8oXw@domain.hid>	<4EA13402.8010605@domain.hid>
	<CAAtf-FdauMEM4s7xUNjm7GKEvUE6di5f=h-yU9Qxbwh1Y5yPZw@domain.hid>
In-Reply-To: <CAAtf-FdauMEM4s7xUNjm7GKEvUE6di5f=h-yU9Qxbwh1Y5yPZw@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

On 10/31/2011 12:39 PM, Donggu Kang wrote:
> Dear Gilles
> 
> I re-made xenomai task that use etherlab kernel module.
> Xenomai task is working as kernel module.
> 
> As your comment, when I call the etherlab api, the mode of real-time
> task is changed to secondary mode.
> And the real-time task could be interrupted by linux irq. right?
> 
> but, In "Xenomai's primary and secondary domains" section of "Life
> With Adeos" says, xenomai have interrupt shield function.
> So, if I turn on the interrupt shield option, latency could be more reduced.
> 
> Is it collect ?

The interrupt shield no longer exists. If you want a task to meet its
deadlines, it should remain in primary mode.

Please do not send private mails.

-- 
                                                                Gilles.

