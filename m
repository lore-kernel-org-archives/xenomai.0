Message-ID: <47B0B018.40301@domain.hid>
Date: Mon, 11 Feb 2008 21:29:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] irq0
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I used the idle=poll option so I’m running the tsc now, and irq0 handler
> still has a lot of overhead.
> 
>  
> 
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> 
>   0  0      0          2          0     00500080   94.2  ROOT
> 
>   0  0      0          1          0     00100082    0.0  sound task
> 
>   0  0      0          1          0     00100082    0.0  tone task
> 
> 0  0      0          775585     0     00000000    5.6  IRQ0: [timer]
> 
>  
> 
> I’m seeing about 17,000 context switches a second for IRQ0. Sound task
> and tone task are doing nothing. They’re just blocked.
> 

The number of context switches reported for an IRQ is actually the
number of invocations for the associated IRQ handler, IOW, the exact
count of interrupts received. So you get one timer tick each ~59us.
What's the highest periodic task frequency used in your app?

-- 
Philippe.

