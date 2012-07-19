Message-ID: <50085231.9050303@siemens.com>
Date: Thu, 19 Jul 2012 20:30:09 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <500808DC.1050800@barrett.com> <50080CB0.8030400@siemens.com>
	<50083ED5.1010007@barrett.com>
In-Reply-To: <50083ED5.1010007@barrett.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 2012-07-19 19:07, Kyle Maroney wrote:
> On 07/19/2012 09:33 AM, Jan Kiszka wrote:
>> On 2012-07-19 15:17, Kyle Maroney wrote:
>>> Congratulations on the recent release of Xenomai 2.6.1. We are excited
>>> about the recent move to the ipipe core series and 3.x kernel patches
>>> becoming available for the x86 architecture.
>>>
>>> I have been able to successfully patch the vanilla kernel (3.2.19) with
>>> a slightly modified ipipe-core-3.2.21-x86-1 patch, and tested that
>>> working with a generic configuration. I also successfully patched
>>> vanilla + ubuntu diff + adeos, and tested this working as well.
>>>
>>> My problem is when I apply the xenomai configuration options after
>>> running the prepare kernel script.  The kernel compiles successfully
>>> with no problems, however upon reboot I am met with the boot hanging at
>>> the purple boot screen of Ubuntu (no images).
>>>
>>> I have experimented with many config options for the past few days, and
>>> come to you for guidance. Please find attached my .config file.
>>>
>> There are obviously several issues remaining in the new x86 3.2 patch. I
>> just recently ran into some of them as well while updating RTnet.
>> Probably (hopefully) they are just related to debugging infrastructure.
>> Hope we can look into this over the next weeks. For now, disable
>> tracing, disable KGDB (which was also unsupported before BTW) and retry.
>> Ah, and I only tried 64 bit so far.
>>
>> Jan
>>
> 
> Thank you for your advice. I understand (and enjoy) the implications of 
> working with such a new patch.
> 
> Regarding disabling of the stated configuration options (tracing and 
> KGDB), I am having a problem that may be quickly answered.
> 
> As you can see in the attached images, sparse irq numbering and kernel 
> debugging are locked 'enabled'. How did this happen? How can I disable 
> these options safely?

If you open their help, you will see the dependency chain. However, none
of them should cause troubles to you, I have them on as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux



