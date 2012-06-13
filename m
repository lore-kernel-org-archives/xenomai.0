Message-ID: <4FD8622F.2050006@grandegger.com>
Date: Wed, 13 Jun 2012 11:49:35 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org>
	<CAKKWdte3jE_kW8esz25=gYeYU_M1cmOmftgbfMs9RqyfBCr9Kw@mail.gmail.com>
	<4FCDB0FD.1080309@xenomai.org>
	<8236197CA3DA864F9EF20609D9887263B7F87D1A@rrxchngmbx01.mro.roland-man.biz>
	<4FCDC08E.9030101@xenomai.org>
	<8236197CA3DA864F9EF20609D9887263B7F88212@rrxchngmbx01.mro.roland-man.biz>
In-Reply-To: <8236197CA3DA864F9EF20609D9887263B7F88212@rrxchngmbx01.mro.roland-man.biz>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland.com
Cc: Xenomai@xenomai.org

Hi Dietmar,

On 06/13/2012 11:32 AM, dietmar.schindler@manroland.com wrote:
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Tuesday, June 05, 2012 10:17 AM
>>
>> On 06/05/2012 10:06 AM, dietmar.schindler@manroland.com wrote:
>>> A Xenomai-patched 2.6.34 kernel (ppc GNU/Linux) crashes when issuing the
>> command
>>>
>>> echo function>/sys/kernel/debug/tracing/current_tracer
>>>
>>> (sometimes displaying NIP in a function from
>> "source/kernel/trace/ring_buffer.c", sometimes with no message).
>>>
>>> Are Xenomai and ftrace incompatible?
>>>
>>
>> No, but some ftrace bits have to be made pipeline-aware. The generic
>> ones should be, but some powerpc-specific fix ups might be missing. I'm
>> not using/testing ftrace routinely when upgrading patches. Also, 2.6.34
>> is fairly old.
> =

> http://www.xenomai.org/index.php/I-pipe:Tracer#Configuration says: "Ftrac=
e's function and graph tracers themselves are still not usable over I-pipe =
kernels, latest I-pipe will prevent conflicting use."
> =

> I'm confused - I can't gather from this whether the Function Tracer might=
 work or can't possibly work.

If the iPipe-Tracer is enabled in the Kernel, you can't use Linux ftrace
via "/sys/kernel/debug/tracing" any more. I checked that for PowerPC up
to Linux 3.2.1. In contrast, the iPipe-Tracer is controlled by files in
/proc/ipipe/trace and that works. For your kernel version you need the
attached two patches, though.

Wolfgang.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adeos-ipipe-2.6.34.4-powerpc-2.10-05-tracer.patch
Type: text/x-diff
Size: 592 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120613/c8f1054=
2/attachment.patch>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adeos-ipipe-2.6.34.4-powerpc-2.10-05-tsc2us.patch
Type: text/x-diff
Size: 1279 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120613/c8f1054=
2/attachment-0001.patch>
