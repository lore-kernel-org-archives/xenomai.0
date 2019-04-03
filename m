Subject: Re: Xenomai kernel for BBB
References: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4a8a6ec5-cc87-19b5-3ebe-8d0d6da6027b@xenomai.org>
Date: Wed, 3 Apr 2019 19:16:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@xenomai.org

On 4/3/19 9:55 AM, Pierre FICHEUX via Xenomai wrote:
> Hi,
> 
> Xenomai kernel (-xenomai branches) is available for BBB (AM335x) from
> https://github.com/beagleboard/linux for some kernel releases (4.4, 4.9,
> 4.14). I've tried 4.9 and 4.14 but jitter is very bad with latency tool (>
> 200 µs).
> 
> According to Xenomai wiki, AM335x SoC is supported for "vendor branch",
> hope this is the same thing (?)
> 
> Dos anybody use AM335x with success? I did it a long time ago with Xenomai
> 2 and 3.8.13 kernel.
> 

CONFIG_ARM_CPUIDLE hurts badly on this platform, disabling it restores
proper latency figures.

A quick port of the latest I-pipe code ported to the bbb kernel 4.14 can
be pulled from this URL (lightly tested):
https://lab.xenomai.org/ipipe-rpm.git/log/?h=arm/4.14.110-bbb

-- 
Philippe.

