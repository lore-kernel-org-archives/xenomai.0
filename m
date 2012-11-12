Message-ID: <50A16CA2.7060403@xenomai.org>
Date: Mon, 12 Nov 2012 22:39:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50A10873.9030907@axelsw.it> <50A109F3.9090106@axelsw.it>
In-Reply-To: <50A109F3.9090106@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debug a xenomai application with gdb stops another
 xenomai application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: xenomai@xenomai.org

On 11/12/2012 03:38 PM, Roberto Bielli wrote:

> 
> Hi,
> 
> i have two different applications with xenomai task.
> When i put a gdb breakpoint into a task in the first application, the
> xenomai tasks in the second applications stops.
> 
> Is it a correct behaviour ?
> 
> the system is:
>   - cpu = arm - freescale imx25
>   - kernel 2.6.31
>   - xenomai 2.5.6
>   - adeos-ipipe-2.6.31-arm-1.16-02.patch
> 
> Thanks for all


I think so. This is a feature, the timers stops, because otherwise, if
you use timeouts, you get cascaded timeouts all over the place when one
thread stops in the debugger.

-- 
                                                                Gilles.

