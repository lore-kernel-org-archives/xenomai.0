Message-ID: <509AC47B.2090002@xenomai.org>
Date: Wed, 07 Nov 2012 21:28:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>	<509AB38E.1060802@grandegger.com>	<39DEC9F1-236E-481A-A685-E3EFE883BCFA@mah.priv.at>	<509ABA2F.3070507@xenomai.org>
	<79291449-2780-432F-AD58-BED661299EC6@mah.priv.at>
In-Reply-To: <79291449-2780-432F-AD58-BED661299EC6@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM API: no CPU binding,
	FPU setting for tasks available?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 11/07/2012 09:17 PM, Michael Haberler wrote:

> 
> Am 07.11.2012 um 20:44 schrieb Gilles Chanteperdrix:
> 
>>>> On 11/07/2012 08:06 PM, Michael Haberler wrote:
>>>>> As suggested, I adapted the LinuxCNC kernel support from native
> ...
> 
>> In xenomai 3.0, FPU in kernel-space will not be supported. But it is
> 
> that I wasnt aware of, and it is quite a showstopper for me - I wish I had known before and saved the time. It puts in question any plans to release the kernel mode port of LinuxCNC altogether.
> 
> You _do_ want to add that fact to the Xenomai Roadmap _badly_.


Well, it has been discussed several times on this mailing list.

> 
> what would be a realistic 'useful remaing life expectancy' for Xenomai 2.x? 1,2,3 years? 


There is no plan to abandon 2.x, only at some point (probably around the
time when the first xenomai 3.0 release will happen) only upgrades to
new kernel versions will happen, new functionalities will not be developed.

-- 
                                                                Gilles.

