Message-ID: <5332D759.7010806@xenomai.org>
Date: Wed, 26 Mar 2014 14:34:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5072ab06.2340b.144fe2d11ed.Coremail.ericvic@163.com>
 <5332BF1F.3000504@xenomai.org>
 <76a8b1fe.2477d.144fe96fb16.Coremail.ericvic@163.com>
In-Reply-To: <76a8b1fe.2477d.144fe96fb16.Coremail.ericvic@163.com>
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

On 03/26/2014 02:31 PM, 嵌入式工程师 wrote:
> I actually don't know  if it caused by rt_pipe ,in user layer i used Qt and Qt call large quantity rt_pipe

I doubt very much QT uses rt_pipes, unless you modified it to do so. 
 From the latencies below, I would say you are not running with the 
kernel from the git branch I indicated.

-- 
					    Gilles.

