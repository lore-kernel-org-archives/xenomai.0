Message-ID: <52EA03D8.5080307@axelsw.it>
Date: Thu, 30 Jan 2014 08:48:40 +0100
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
References: <52E90C95.702@axelsw.it> <52E94484.3050607@xenomai.org>
In-Reply-To: <52E94484.3050607@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Please,
 can anybody help me to find where is supposed to be the handler
 function for the Xenomai syscall in the kernel tree?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Il 29/01/2014 19:12, Gilles Chanteperdrix ha scritto:
> On 01/29/2014 03:13 PM, Marco Tessore wrote:
>> Good morning,
>> I am a newbie of Xenomai, and I'm trying to patch a modified (non
>> vanilla) Linux kernel 3.11.0rc3 for ARM architecture (Freescale iMx28)
>> with Xenomai 2.6.3.
>> To achieve this goal I have modified, then applied the patch
>> ipipe-core-3.8.13-arm-3, but, probably because of my changes, something
>> seems to not work properly.
>
> Note that:
> - you may use the I-pipe kernel for 3.10 as a base for 3.11.0rc3, 
> available here:
> git://git.kernel.org/ipipe.git branch stable/ipipe-3.10.18
> - using an rc kernel is bad idea
> - how to port Xenomai on new ARM processors is documented here:
> https://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>
>
Thank you Gilles very much for your suggestions,
I think I will try the stable/ipipe-3.10.18 branch as base for my 
kernel: it may work well for me.

Best regards
Marco

