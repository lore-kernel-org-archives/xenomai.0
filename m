Message-ID: <5332BF1F.3000504@xenomai.org>
Date: Wed, 26 Mar 2014 12:50:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5072ab06.2340b.144fe2d11ed.Coremail.ericvic@163.com>
In-Reply-To: <5072ab06.2340b.144fe2d11ed.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai  ipipe-3.0-imx6q
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

On 03/26/2014 12:36 PM, 嵌入式工程师 wrote:
> I use imx6q xenomai  ipipe-3.0-imx6q  ，i don`t know if rt_pipe and
> rt_timer will affect the latency?because I use lots of rt_pipe command
> and when I send the rt_pipe command the latency will like blow

Could you post an example of code allowing to reproduce this problem? 
Does the same problem happen if you use the xddp interface instead of 
the (deprecated) rt_pipe interface?

-- 
					    Gilles.

