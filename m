Message-ID: <53A4282B.6030500@xenomai.org>
Date: Fri, 20 Jun 2014 14:25:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53A3FAB0.4050100@axelsw.it> <53A4207F.9040801@xenomai.org>
 <53A426A8.8060207@axelsw.it>
In-Reply-To: <53A426A8.8060207@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel freezes in __ipipe_sync_stage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 06/20/2014 02:18 PM, Marco Tessore wrote:
> Il 20/06/2014 13:52, Gilles Chanteperdrix ha scritto:
>> On 06/20/2014 11:11 AM, Marco Tessore wrote:
>>> The kernel is version 2.6.31 for ARM architecture - specifically a
>> Do you have the same problem with a recent I-pipe patches, like one for
>> 3.8 or 3.10 kernel?
>>
> 
> One note:
> Philippe had already written an email about, full of tips on how to 
> identify the cause, and that is probably not attributable to ipipe, 
> unfortunately the email went into spam and I had not seen.
> 
> For the moment I have enough material to work with,
> if the tests, that I will do on the 3.10, were to emerge again something 
> I will inform you.

Ok, there is a very old bug in the imx tsc emulation, which used a 
physical address as virtual address. See for instance:

http://www.armadeus.com/wiki/index.php?title=Xenomai#Xenomai_kernel_space_support

-- 
                                                                Gilles.

