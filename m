Subject: Re: [consult]locking/spinlock/:why *nklock* used in many places?
 hello,
References: <20200610140245.38252-1-alex_luca@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c5d7fd3b-9592-2f87-7f1c-910087a9639c@siemens.com>
Date: Fri, 12 Jun 2020 17:06:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200610140245.38252-1-alex_luca@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex_luca@163.com, xenomai@xenomai.org
Cc: jamienstar@163.com

On 10.06.20 16:02, alex_luca--- via Xenomai wrote:
> From: Carver lio <carver@tom.com>
> 
> We have some doubts on xenomai master.
> 
> We use ipipe-core-4.19.82-cip14-x86_64 + xenomai-3.1 on my machine
> with 16 processors; everything is fine until we run the *latency -t0*
> testcase on cpu1-cpu15 for our schedule benchmark.
> 
> What we found that the results of the testcase became very poor,
> worse than testing on one processor. Then we config *IPIPE_TRACE=y*
> and *XENO_OPT_DEBUG_LOCKING=y*, and run the same testcases, we found
> the delays of the testcase caused by the Global *nklock*.
> 
> We are wondering why the same lock *nklock* is used in many places
> in the xenomai source code. Is this necessary? Or do you have
> optimizations for this situation in the future?

Yes, this scalability limitation is well known and was primarily a
trade-off between locking simplicity and the ability to run RT
applications spread across a large number of cores.

Reasonable right now is 4, maybe 8 cores at most for RT usage. You can
scale the whole system to much more, we are deploying 32 cores and had
once a setup with almost 200 cores, but then only by restricting Xenomai
(and consequently its RT threads) to a small subset.

It's on the long-term agenda to lift this limitation because it can bite
you also earlier when you are hunting for microseconds between rather
independent applications spread across cores, like in the scenario you
created.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

