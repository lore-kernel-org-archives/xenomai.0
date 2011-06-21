Message-ID: <4E01050D.8000800@domain.hid>
Date: Tue, 21 Jun 2011 22:54:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <737283.11182.qm@domain.hid>
	<4DEF2D3D.9090409@domain.hid>
	<213583.55278.qm@domain.hid>
In-Reply-To: <213583.55278.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sanjay anvekar <sanjayanvekar@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/21/2011 02:02 PM, sanjay anvekar wrote:
> Hi Gilles, Thanks for your reply. I am using 'rt_task_sleep(100us)'
> at the end of every task to let Linux task run. With this I am able
> to run my application program , but I am not able to debug using
> 'GDB'.

What happens when you try and debug with gdb?

> Also is there any better way to allow Linux task run instead
> of using 'rt_task_sleep' ? My application has got 5 different task of

First, the application should wait interrupts and react upon them, not
do any polling, this should normally leave some time for Linux to run if
the system is well dimensioned.

> 
> 
> equal priority and I want to run these in Round Robin fashion , I
> used 'rt_task_set_mode(0,XNRRB ,NULL)' to enable Round Robin
> scheduling mode, but task are not getting executed in Round Robin
> fashion.

I do not think round-robin is what you want: it will not let linux run.
rt_task_set_mode probably returns an error when you use XNRRB, because
it does not expect this bit to be set.

-- 
                                                                Gilles.

