Message-ID: <535110C3.40500@xenomai.org>
Date: Fri, 18 Apr 2014 13:47:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7dad12a6.21b0a.14574613527.Coremail.ericvic@163.com>
In-Reply-To: <7dad12a6.21b0a.14574613527.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: huang.c.h@lynuc.cn, liu.h.f@lynuc.cn, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/18/2014 12:28 PM, 嵌入式工程师 wrote:
> 
> 
> I do the same on the imx53 with imx6 test, in the process of
> real-time task to run the same operation content, start the qt deform
> demo and copy large file  to memory, in 250 us the  latency on imx6
> board began to accumulate, lost real-time, but latency  on the imx53
> only value within 20 us. I do not run anyother rt task on my below
> test：

Looking at your code, it seems your problem (if I understand correctly),
is that a series of memcpy and memset takes a long time to execute when
non real-time activities are given an opportunity to thrash the cache.

Am I understanding correctly?

-- 
                                                                Gilles.

