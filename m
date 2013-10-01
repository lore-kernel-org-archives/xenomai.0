Message-ID: <524B1E12.2010909@xenomai.org>
Date: Tue, 01 Oct 2013 21:10:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <524ABEED.4090609@axelsw.it>
	<114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>
	<524AC518.2040901@axelsw.it>
In-Reply-To: <524AC518.2040901@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] high latency with imx6q without smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/01/2013 02:50 PM, Roberto Bielli wrote:
> Hi,
> 
> excuse me for the previous question i have not seen your email.
> i have tried the kernel with the ipipe patch 3.0.43 on xenomai 2.6.x 
> branch without smp and has very high worst latency:
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
> best|--lat worst
> RTD|      5.999|     11.333|     25.333|       0|     0| 5.666|    328.999
> RTD|     10.999|     11.333|     19.666|       0|     0| 5.666|    328.999
> RTD|      5.999|     10.999|     17.999|       0|     0| 5.666|    328.999
> RTD|     10.999|     11.333|     17.999|       0|     0| 5.666|    328.999
> RTD|      5.999|     11.333|     26.999|       0|     0| 5.666|    328.999
> 
> This behaviour isn't in smp version with 2 processors.

It may be here in SMP but you do not see it. You should run the latency
test under load to try and trigger the worst case latency.

> 
> So i read your email and if i understand correctly could be the L2 cache 
> spinlock that create large latencies (?328.999).

The L2 cache spinlock section are alreay reduced, the maximum was rather
around 40us anyway.

> I'm not using framebuffer directly.
> You told me that there is a patch that can fix this behaviour in the 
> last ipipe patch.
> is there a commit for fixing only this behaviour that i can move on my 
> kernel with patch 3.0.43 ?

Please try disabling the framebuffer driver completely, and see if it
changes anything. If it does not change anything, you have to use the
I-pipe tracer.

-- 
                                                                Gilles.

