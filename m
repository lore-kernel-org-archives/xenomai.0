Message-ID: <52555C61.9000002@nta-inc.net>
Date: Wed, 09 Oct 2013 08:38:41 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <52505D40.7070600@xenomai.org> <52543701.7050203@nta-inc.net>
	<1066e955e4a2a71d812f72689fe7d4f0.squirrel@127.0.0.1>
In-Reply-To: <1066e955e4a2a71d812f72689fe7d4f0.squirrel@127.0.0.1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 10/09/2013 05:04 AM, Gilles Chanteperdrix wrote:
>
> Jeff Webb wrote:
>> On 10/05/2013 01:41 PM, Gilles Chanteperdrix wrote:
>>> at last, here comes Xenomai 2.6.3, available at the usual address:
>>> http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2
>>>
>>> In addition to core bug fixes and improvements, it has the following
>>> more visible changes:
>>> - upgrade to support I-pipe patches to Linux 3.8, and Linux 3.10
>>> (not included);
>>> - contributed I-pipe patches for BeagleBone, Raspberry Pi and Zynq;
>>
>> Thanks to all of you for your hard work in putting together this latest
>> release.  I have an issue when trying to build a Xenomai-enabled kernel
>> for the Zynq platform, however.  I get a few failed hunks when applying
>> the included ipipe-core-3.8.13-arm-3.patch.  This patch seems to work
>> fine:
>> http://download.gna.org/adeos/patches/v3.x/arm/ipipe-core-3.8-arm-1.patch.
>
> Yes, the patches author changed company and so no longer had access to
> the hardware to update the patches. So, I kept the first set of patches
> he sent, hoping that it would help anyone who wants to work on Zynq.

Oh, I see.  Yes, thanks for including the zynq patches in the distribution.  I have built Xenomai and loaded it onto a ZedBoard I have at work.  I'm hoping we will be able to use this platform for some real-time work, but I'm not certain at this point.  If so, I will look into updating the patches.

Thanks again,

-Jeff

  


