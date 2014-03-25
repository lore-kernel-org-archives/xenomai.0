Message-ID: <533168CA.6010703@xenomai.org>
Date: Tue, 25 Mar 2014 12:30:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <40a355c3.3a46.144f6fe3c91.Coremail.ericvic@163.com>
 <36d2cb6f.ac9a.144f81578c0.Coremail.ericvic@163.com>
In-Reply-To: <36d2cb6f.ac9a.144f81578c0.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] On mx6q specifically,
	it seems the framebuffer is a latency killer
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

On 03/25/2014 08:12 AM, 嵌入式工程师 wrote:
> 
> Thanks ,I find the problem like mine ,http://www.marshut.com/iqphrn/user-space-problems.html

Please try the
ipipe-3.0-imx6q
branch on git://git.xenomai.org/ipipe-gch.git

It should solve high latencies with imx6q. Note however that a 40us
latency is not really considered a problem for this class of processors.

-- 
                                                                Gilles.

