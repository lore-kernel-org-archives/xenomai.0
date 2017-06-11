References: <DB6PR0701MB2456A3DFDDAD4683EA2786D8B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b7dc2010-e046-6482-c510-830abd1814fd@xenomai.org>
Date: Sun, 11 Jun 2017 17:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456A3DFDDAD4683EA2786D8B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Difference bewteen demo/altency and bin/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/11/2017 05:02 AM, Giulio Moro wrote:
> As I understand it, bin/latency is based on the posix API and demo/altency is based on the Alchemy API. On the BeagleBone black, the former always returns results which are about 10us better than the latter.
> 
> Is there any other difference between the two tests? Why do I get different performance? Is the Posix API more performant than the Alchemy one?

With Xenomai 3, all non-POSIX APIs are built over the POSIX one, on top
of the copperplate library which provides the RTOS abstractions and
building blocks they need, i.e.

libcobalt(posix) <- libcopperplate <- lib{alchemy, psos, vxworks}

So, a pure POSIX app only needs libcobalt, while non-POSIX APIs need
libcopperplate to mediate between them and the Cobalt core in kernel space.

This additional indirection allows building richer APIs than POSIX,
converting proprietary RTOS "window-dressings" to POSIX seamlessly, and
making the dual-kernel / native Linux issue transparent, but it also
induces the overhead you are observing. This indirection did not exist
with Xenomai 2, where each API had its own set of system calls directly
interfaced to the kernel (at the expense of significant maintenance issues).

Generally speaking, although Alchemy will be maintained in Xenomai 3, I
would recommend to go for the POSIX API for new developments, unless one
wants to port legacy VxWorks/pSOS code of course.

The reasoning behind is that building a dedicated service library which
provides richer abstractions directly on top of POSIX - such as the
RT_EVENT logic - makes more sense than implementing a full-fledged API
for this.

-- 
Philippe.

