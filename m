Message-ID: <52CD0994.9050303@xenomai.org>
Date: Wed, 08 Jan 2014 09:17:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <45f0b39a.14947.1436fa4b0b8.Coremail.ericvic@163.com>
In-Reply-To: <45f0b39a.14947.1436fa4b0b8.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] x86 with xenomai patch
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

On 01/08/2014 03:18 AM, 嵌入式工程师 wrote:
> I use kernal-3.4.6 and kernal-3.8.13 with xenomai-2.6.3 x86 patches .
> (...)
> Kernel has been compiled. But when I use xenomai source package
> generates real-time testing tools to test.The latency tools works
> well with no load. But when I start the opengl tools gfxgears the
> real-time will be very bad  with kernal mode priority  99  100us。 I
> do not kenow where I have been wrong.

If you are using the graphic chip integrated into Intel processors, 
this has only be fixed recently in the kernel (it works on 3.10, but 
not on older kernel). If you want to stay with 3.4, see:

http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_the_latency_test_shows_high_latencies

-- 
                                                                Gilles.

