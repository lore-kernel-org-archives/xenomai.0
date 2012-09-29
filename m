Message-ID: <5066A426.7060900@xenomai.org>
Date: Sat, 29 Sep 2012 09:32:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtctThpDZ=_QTGrLRXVkoc16hVg-CbFO1U7MsdWRtywFFg@mail.gmail.com>
In-Reply-To: <CAKKWdtctThpDZ=_QTGrLRXVkoc16hVg-CbFO1U7MsdWRtywFFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] some errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 09/29/2012 09:20 AM, ali hagigat wrote:

> I am using Xenomai, 2.6.0.


That is stupid.

> 
> The man page of latency program should be corrected:
> 
> "The system must run a suitable Xenomai enabled kernel with the respective
>        module (xeno_timerbench)"
> 
> There is no xeno_timerbench module in the system!


See CONFIG_XENO_DRIVERS_TIMERBENCH in kernel configuration.

-- 
                                                                Gilles.

