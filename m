Message-ID: <5335B354.5000404@xenomai.org>
Date: Fri, 28 Mar 2014 18:37:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5072ab06.2340b.144fe2d11ed.Coremail.ericvic@163.com>
 <5332BF1F.3000504@xenomai.org>
 <76a8b1fe.2477d.144fe96fb16.Coremail.ericvic@163.com>
 <5332D759.7010806@xenomai.org>
 <23d0b1ec.250da.144fecc28e4.Coremail.ericvic@163.com>
 <53335E2F.4040608@xenomai.org>
 <594fd0f5.8241.14501ff6aba.Coremail.ericvic@163.com>
 <53341923.3050401@xenomai.org>
 <73b7ea7c.981e.14507c57f41.Coremail.ericvic@163.com>
In-Reply-To: <73b7ea7c.981e.14507c57f41.Coremail.ericvic@163.com>
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

On 03/28/2014 09:19 AM, 嵌入式工程师 wrote:
> THis is my newtest on my imx6q board with  ipipe-3.0-imx6q

Note that the latency test only really make sense if no other real-time 
activity is running on the board. Otherwise you are not really measuring 
the system worst case latency.

-- 
					    Gilles.

