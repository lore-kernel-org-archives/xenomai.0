Message-ID: <533A99AD.4010404@xenomai.org>
Date: Tue, 01 Apr 2014 12:49:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <36553bb2.3800.1451b23ccfc.Coremail.ericvic@163.com>
In-Reply-To: <36553bb2.3800.1451b23ccfc.Coremail.ericvic@163.com>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/01/2014 04:35 AM, 嵌入式工程师 wrote:
> Hello Gilles ，this is my test about xenomai ，this can also effect the
> my program  and the latency test
> ，thanks 。

For the third time: running the latency test while other real-time
activity is running gives meaningless results. Here, the following piece
of code:
>  for(i=1;i<1000;i++)
> for(j=1;j<i;j++)
> k=i*j;

Takes 1.6ms to execute, this is what the latency test measures.

-- 
                                                                Gilles.

