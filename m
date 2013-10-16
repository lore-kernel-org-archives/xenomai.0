From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<52558563.2010408@xenomai.org>	<8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<525587A2.5000507@xenomai.org>
	<73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
In-Reply-To: <73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
Date: Wed, 16 Oct 2013 11:30:32 -0700 (MST)
Message-ID: <8a1928a6.00000970.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] t_suspend and XNBREAK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Philippe Gerum' <rpm@xenomai.org>, xenomai@xenomai.org



-----Original Message-----
From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] On
Behalf Of Daniel Merrill
Sent: Wednesday, October 09, 2013 10:02 AM
To: 'Philippe Gerum'; xenomai@xenomai.org
Subject: Re: [Xenomai] t_suspend and XNBREAK

On 10/09/2013 06:37 PM, Daniel Merrill wrote:
> On 10/09/2013 06:29 PM, Daniel Merrill wrote:
>> All,
>>
>>
>>
>> I'm hoping maybe someone can shed a little more light on the issue we 
>> see occasionally. Occasionally our code using the psos+ skin will 
>> fail a
>> t_suspend(0) with error code -4, which I found to be EINTR and 
>> appears to be set if the XNBREAK flag is set. After digging around in 
>> the documentation I found some references that seem to indicate that 
>> this means the thread was forcibly unblocked for some reason. Is 
>> there some way to diagnose what caused this (I'm having trouble 
>> pinpointing anything)? It appears when debugging that the thread 
>> never really suspends at all but returns immediately from the call.
>> Does anyone have some pointers on what might be a good place to start 
>> looking for
> the culprit? Thanks in advance.
>
> Are you tracing the application with GDB?
>
> We are using GDB to diagnose problems, can this cause the issue?

It should not, but one of the reasons for a thread to get forcibly
unblocked is to receive a regular linux signal when blocked in primary
mode. Since GDB does send quite a few signals to the application when
single-stepping/breakpointing the code, this information may be useful to
know. In short, GDB/ptracing might magnify a bug in this area.

If this issue also happens with no ptracing, then some other source kicked
the thread out of wait state, and we'd have to instrument the code to know
who does this.

I believe we do see it more often when we are using GDB, I do know of one
specific example that happens in gdb but does not happen if we run with no
debugger. In that particular case it doesn't matter if we are single
stepping or not, with breakpoints or without, the mere fact that gdb is
attached seems to activate the issue. We haven't been able to tell if it
is gdb itself that is directly causing the issue or if attaching gdb is
causing some other side effect (maybe timing related) that then causes the
problem to appear.

So I've been playing around trying to pinpoint the issue, It does appear
only to be caused by GDB, which is unfortunate cause it makes it harder
for us to find issues with our platform, but we can live with it if we
have to. My question now is this. Is there any way to clear the XNBREAK?
It seems that once the issue happens no thread will suspend correctly and
in our case we have a few that get stuck in an infinite loop since they
were depending on the suspend to keep them from doing so. Thanks Again.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

