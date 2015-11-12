References: <55E7F013.10101@free.fr>
 <20151104003032.GB24848@hermes.click-hack.org>
 <20151108112627.GL1798@hermes.click-hack.org> <56444BB1.2040408@free.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <564461ED.9060700@xenomai.org>
Date: Thu, 12 Nov 2015 10:54:53 +0100
MIME-Version: 1.0
In-Reply-To: <56444BB1.2040408@free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] intel turbo boost
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_ANCELOT?= <sancelot@free.fr>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/12/2015 09:20 AM, St=E9phane ANCELOT wrote:
> On 08/11/2015 12:26, Gilles Chanteperdrix wrote:
>> On Wed, Nov 04, 2015 at 01:30:32AM +0100, Gilles Chanteperdrix wrote:
>>> On Thu, Sep 03, 2015 at 09:00:36AM +0200, St=E9phane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> Do you think I can use the Intel integrated turbo boost mode, without
>>>> problems.
>>>>
>>>> I have this nice processor :
>>>> http://ark.intel.com/fr/products/76308/Intel-Core-i5-4300U-Processor-3=
M-Cache-up-to-2_90-GHz
>>>>
>>> Just experimented this, the turbo mode is a problem for applications
>>> which rely on a precise relation between the actual count of cpu
>>> cycles of a busy loop and the time. The sched_quota falls under that
>>> category and simply does not work reliably when turbo mode is
>>> enabled. Fortunately, it is possible to turn off turbo mode. For
>>> that, in the kernel configuration
>>> - enable CPU_FREQ
>>> - choose performance mode by default
>>> - enable intel pstate driver
>>> - echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
>>>
>>> Other than that, turbo mode does not seem to break the latency,
>>> which would mean that the tsc frequency does not change with turbo
>>> mode.
>> Turbo mode also breaks the autotune feature. So, on a machine with
>> turbo mode, autotune should be triggered after writing to the /proc
>> file.
>>
> Hi,
> You can disable turbo mode, in bios cpu settings . Writting to the
> no_turbo file is not permitted, but equals 1.
> How do you trig autotune ?

http://www.xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html

The calibration obtained might be conservative in some cases, autotune
is aimed at suggesting sane and efficient values. You can still refine
the results via the /proc/xenomai/clock/coreclk interface if need be.

--=20
Philippe.

