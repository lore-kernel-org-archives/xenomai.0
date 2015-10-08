References: <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
 <56161232.50803@xenomai.org> <20151008144340.GE21923@csclub.uwaterloo.ca>
 <5616838F.7030507@xenomai.org> <20151008151744.GG21923@csclub.uwaterloo.ca>
 <56168EB5.10104@xenomai.org> <20151008154735.GG8324@hermes.click-hack.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5616A918.6030607@xenomai.org>
Date: Thu, 8 Oct 2015 19:34:16 +0200
MIME-Version: 1.0
In-Reply-To: <20151008154735.GG8324@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
	2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/08/2015 05:47 PM, Gilles Chanteperdrix wrote:
> On Thu, Oct 08, 2015 at 05:41:41PM +0200, Philippe Gerum wrote:
>> On 10/08/2015 05:17 PM, Lennart Sorensen wrote:
>>> On Thu, Oct 08, 2015 at 04:54:07PM +0200, Philippe Gerum wrote:
>>>> I could not find one that would not look weird. That logic is deeply
>>>> buried in kernel space, and introducing a dynamic dependency on whether
>>>> e.g. the PCI layer has to be traversed for carrying out such ops would
>>>> be rather confusing for the end user, especially when porting the
>>>> application code over different SoCs.
>>>
>>> Yep, that sounds ugly.
>>>
>>>> Likely, yes. The relevant handlers dealing with the interrupt controller
>>>> of the QUICC Engine do not tread on problematic code, so this should be
>>>> ok for this platform.
>>>
>>> Then I have the icky situation that we want the same kernel source to
>>> run on arm.  I wonder if the am572x would care.  I guess I could #ifdef
>>> it for powerpc only and leave the new way on arm.
>>>
>>
>> No guarantee, I only had a quick look at this, but AFAICS:
>>
>> - the irqchip from the PCA953X gpio extender module does not seem to
>> have any requirement for running over a regular kernel context
>>
>> - the main GIC IRQ controller is fine, since the fast ack code we use
>> over the head domain is shared with the IRQ enabling/disabling support.
>>
>> So this should be ok (famous last words).
> 
> The GIC has some board/SOC specific callbacks, so, you have to check
> these callbacks too, to be sure that the code does not use some
> linux services.
> 

On the dra7xx Lennart is working on, this is not an issue. The pipeline
is traversing them (or maybe none of them actually) in primary mode happily.

-- 
Philippe.

