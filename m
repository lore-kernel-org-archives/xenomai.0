Message-ID: <4B474BA5.8020202@domain.hid>
Date: Fri, 08 Jan 2010 16:13:41 +0100
From: Bernhard Pfund <bernhard@domain.hid>
MIME-Version: 1.0
References: <4B209B9C.7010309@domain.hid>	
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
In-Reply-To: <1262949018.2455.5.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Philippe Gerum wrote:
> On Fri, 2010-01-08 at 11:59 +0100, Richard Cochran wrote:
>> On Thu, Dec 10, 2009 at 07:56:28AM +0100, Bernhard Pfund wrote:
>>> I'm currently working with a fairly new ppc development board (P2020RDB) by 
>>> Freescale. The board's BSP went mainline with 2.6.32 and I'd like to deploy an 
>>> I-pipe enabled DENX kernel for testing. Now, is there an I-pipe patch for said 
>>> kernel on the release schedule anywhere soon?
>> I got ipipe-2.6.30 running the p2020ds with minimal effort. I can post
>> a diff if that might help you.
>>
>> I should have my own p2020rdb soon...
>>
>> I have noticed some unexplained freezes running xenomai programs on
>> the p2020ds in SMP mode, but I have not yet had time to look into
>> it. I hope we can work together to get SMP working reliably.
> 
> I'm working on fixing the pipeline for 2.6.32/ppc64, which includes SMP
> mode. 32bit looks ok in UP mode, but I still need to validate SMP there.
> So it would be great if you could hammer that patch over your P2020 as
> well once it's ready. ETA, early next week. I'll keep you informed about
> this.

Philippe, Richard

Due to a change of project priorities I'm currently working on a 
PPC750GX based system (which will require the same kernel and pipeline), 
but I still have the P2020RDB available, so I can (an will) test 
whatever you come up with ;)

Thanx for the ongoing efforts!

Bernhard

