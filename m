Date: Thu, 29 Jan 2015 13:25:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150129122504.GC2698@hermes.click-hack.org>
References: <CABxGBLT7Y-xmzPYRjgq=XV6Gj0DmqWqOE9efgikWRVwqyT7cpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABxGBLT7Y-xmzPYRjgq=XV6Gj0DmqWqOE9efgikWRVwqyT7cpQ@mail.gmail.com>
Subject: Re: [Xenomai] ToD drift on i7-3740QM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Pastorino <roland@rolandpastorino.com>
Cc: xenomai@xenomai.org

On Sun, Jan 25, 2015 at 12:15:39PM +0100, Roland Pastorino wrote:
> Good morning everyone,
> 
> I would like to know if some of you could give me a hint on how to
> solve my ToD drift problem.
> This question is similar to this one ->
> http://comments.gmane.org/gmane.linux.real-time.xenomai.users/19719
> 
> Problem:
> After installing Xenomai and after the first reboot, my ToD drift was
> around 500000 us/s.
> After the second reboot, my ToD drift is around 500 us/s which I
> presume is still too high.
> I checked the troubleshooting information on Xenomai website but it didn't help.
> 
> Machine and configuration:
> - PC = Thinkpad w530
> - cpu = i7-3740QM
> - kernel configuration file is attached. I followed the Xenomai
> website for the configuration.
> - cobalt kernel of Xenomai 3
> - Linux kernel 3.16
> - ipipe-core-3.16-x86-1.patch
> - Ubuntu 14.10

Actually, the kernel configuration is not attached. But probably the
only interesting item is whether CONFIG_CPU_FREQ is missing.


-- 
					    Gilles.

