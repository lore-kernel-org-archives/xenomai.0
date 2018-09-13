From: Philippe Gerum <rpm@xenomai.org>
References: <0cb43191-7b16-2e4b-cb49-807b26d3b45b@rambler.ru>
Message-ID: <3cbfd2a4-e656-9b81-f5de-f71d1cec2ca5@xenomai.org>
Date: Thu, 13 Sep 2018 18:30:38 +0200
MIME-Version: 1.0
In-Reply-To: <0cb43191-7b16-2e4b-cb49-807b26d3b45b@rambler.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  kernel BUG
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: leo <feedcom@rambler.ru>, Xenomai@xenomai.org

On 09/03/2018 04:27 PM, leo wrote:
> 
> Good day!
> 
> I'm learning Xenomai technology by reading the documentation.
> The first small step is to try to push the ipipe-arm64 4.14.4 core
> upstream.
> Philippe's idea to consistently apply a set of patches is very good and
> I almost got it.

The learning curve may be shorter with the Dovetail interface [1], which
is a much better co-kernel integration layer, I believe. This is still
(not-so-early) work in progress and we don't support as many SoCs and
architectures the I-pipe supports yet [2] though.

However, documentation about porting Dovetail [3] is continuously
updated, and it runs the latest 4.19-rc3 kernel unlike the I-pipe. Many
basic concepts of Dovetail have been inherited from the I-pipe, so
people familiar with the latter should find their way easily in the former.

Bonus point: since Dovetail is all about deeply integrating a co-kernel
interface logic into the regular kernel machinery, it would certainly be
a better candidate for upstreaming than the I-pipe is.

Btw, Dovetail has not been ported to any Allwinner SoC yet, including
the H5. The co-kernel interface for arm64 is not complete yet, but the
interrupt pipeline core is there and works pretty well already, so this
may be an interesting challenge to port it to an Orange PI PC target, as
a first step.

> In both cases, /usr/xenomai/cyclictest shows:
> 99.98% of results is in the range of 0 - 50 milliseconds.
> 0.02% is in the range of 51-150 milliseconds.
>

Something looks wrong. Xenomai over the I-pipe on an Allwinner H5 SoC
should be in the 50-70 us range, worst-case. Anything falling into the
millisecond range is definitely a pathological case.

[1] git://lab.xenomai.org/linux-dovetail.git
[2] https://dovetail.xenomai.org/status/
[3] https://dovetail.xenomai.org/

-- 
Philippe.

