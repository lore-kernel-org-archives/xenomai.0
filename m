Message-ID: <500F0BC1.1030002@xenomai.org>
Date: Tue, 24 Jul 2012 22:55:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <500808DC.1050800@barrett.com> <50080CB0.8030400@siemens.com>
	<500F0137.2020202@xenomai.org> <500F060D.7000806@barrett.com>
In-Reply-To: <500F060D.7000806@barrett.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 x86 Boot Hanging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kyle Maroney <km@barrett.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/24/2012 10:31 PM, Kyle Maroney wrote:

> On 07/24/2012 04:10 PM, Gilles Chanteperdrix wrote:
>> On 07/19/2012 03:33 PM, Jan Kiszka wrote:
>>
>>> On 2012-07-19 15:17, Kyle Maroney wrote:
>>>> Congratulations on the recent release of Xenomai 2.6.1. We are excited
>>>> about the recent move to the ipipe core series and 3.x kernel patches
>>>> becoming available for the x86 architecture.
>>>>
>>>> I have been able to successfully patch the vanilla kernel (3.2.19) with
>>>> a slightly modified ipipe-core-3.2.21-x86-1 patch, and tested that
>>>> working with a generic configuration. I also successfully patched
>>>> vanilla + ubuntu diff + adeos, and tested this working as well.
>>>>
>>>> My problem is when I apply the xenomai configuration options after
>>>> running the prepare kernel script.  The kernel compiles successfully
>>>> with no problems, however upon reboot I am met with the boot hanging at
>>>> the purple boot screen of Ubuntu (no images).
>>>>
>>>> I have experimented with many config options for the past few days, and
>>>> come to you for guidance. Please find attached my .config file.
>>>>
>>> There are obviously several issues remaining in the new x86 3.2 patch. I
>>> just recently ran into some of them as well while updating RTnet.
>>
>> Any chance for a patch? I am currently running 3.4 on x86, so, it would
>> be nice to merge any fix you made.
>>
> Still no luck creating a configuration allowing me to boot on x86 w/ 
> Precise. If anyone else has been successful on x86 we would love to see 
> patches.


For the screen not to remain black, remove the "quiet" on the kernel
command line in the bootloader configuration.

You can try earlyprintk, if the failure happens early.

Also, in the kernel, try disabling any feature you do not use, such as
profiling, tracing, kgdb, perf system, syscall auditing, as much as
possible.

-- 
                                                                Gilles.

