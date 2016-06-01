References: <574D9B03.8080706@sigmatek.at>
 <20160531141646.GG5951@hermes.click-hack.org>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <574EE886.2020907@sigmatek.at>
Date: Wed, 1 Jun 2016 15:52:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160531141646.GG5951@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
> On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wrote:
>> Dear all,
>>
>> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to
>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system
>> is now up and running and works stable. Unfortunately we see a
>> difference in the performance. Our old combination (XENOMAI 2.6.2.1 +
>> Linux 3.0.43) was slightly faster.
>>
>> At the moment it looks like that XENOMAI 2.6.4 calls
>> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old
>> system.  Every call of xnpod_schedule_handler interrupts our main
>> XENOMAI task with priority = 95.
>>
>> I have compared the configuration of both XENOMAI versions but did not
>> found any difference. I checked the source code (new commits) but did
>> also not find a solution.
> Have you tried Xenomai 2.6.4 with Linux 3.0.43 ? In order to see
> whether it comes from the kernel update or the Xenomai udpate?
I've tried Linux 3.0.43 with Xenomai 2.6.4 an there is no difference to 
Xenomai 2.6.2.1
Looks like there is an other reason than Xenomai.


