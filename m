From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<52558563.2010408@xenomai.org>
In-Reply-To: <52558563.2010408@xenomai.org>
Date: Wed, 9 Oct 2013 09:37:09 -0700 (MST)
Message-ID: <8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
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

On 10/09/2013 06:29 PM, Daniel Merrill wrote:
> All,
>
>
>
> I'm hoping maybe someone can shed a little more light on the issue we 
> see occasionally. Occasionally our code using the psos+ skin will fail 
> a
> t_suspend(0) with error code -4, which I found to be EINTR and appears 
> to be set if the XNBREAK flag is set. After digging around in the 
> documentation I found some references that seem to indicate that this 
> means the thread was forcibly unblocked for some reason. Is there some 
> way to diagnose what caused this (I'm having trouble pinpointing 
> anything)? It appears when debugging that the thread never really 
> suspends at all but returns immediately from the call. Does anyone 
> have some pointers on what might be a good place to start looking for
the culprit? Thanks in advance.

Are you tracing the application with GDB?

We are using GDB to diagnose problems, can this cause the issue?
>
>
>
>
>
> Dan Merrill
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


--
Philippe.

