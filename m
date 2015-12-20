Date: Sun, 20 Dec 2015 16:07:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151220150713.GB25662@hermes.click-hack.org>
References: <mailman.3.1450263601.11243.xenomai@xenomai.org>
 <mailman.3.1450263601.11243.xenomai.{4ac8acb6-338d-4c9e-8bb4-e7df718e2fe0}.0@xenomai.org>
 <20151216064242.GC1786@hermes.click-hack.org>
 <5673B86F.6080205@gmail.com>
 <CAG6c7CaSBQrr+WHWNQfCcpfJ=0L5co8F=NQZqeyN=2TP=YEUbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG6c7CaSBQrr+WHWNQfCcpfJ=0L5co8F=NQZqeyN=2TP=YEUbQ@mail.gmail.com>
Subject: Re: [Xenomai] patch for RPI2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ilyasse toumi <toumi.ily@gmail.com>
Cc: Joe Lee <joelee271828@gmail.com>, xenomai@xenomai.org

On Fri, Dec 18, 2015 at 01:41:50PM +0100, ilyasse toumi wrote:
> Hi there
> 
> I used the same kernel (rpi-3.18.y) but this time with Xenomai 3.0.1. the
> patch seems to be OK. After building it i used it with Raspbian root file
> system.
> I launched the latency test in both x86 and RPI2. x86 response time is of
> the order of several microseconds, but RPI2 response time is of the order
> of a few ten microseconds.
> 
> To summarize, the problem was with Xenomai 2 ( I didn't use git version )
> and also SOC should be enabled. Now I am planning to port Xenomai on Orange
> Pi, It should not be very hard since they have the  same CPU

I think you did not understand my answer correctly. I never said
that the problem was with Xenomai 2. The problem is that Xenomai
2.6.4 is too old for Linux 3.18. Please do not spread false rumors.

-- 
					    Gilles.
https://click-hack.org

