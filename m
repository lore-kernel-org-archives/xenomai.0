Message-ID: <530F2118.2050002@marel.com>
Date: Thu, 27 Feb 2014 11:27:20 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
References: <52FBA4D5.3010606@marel.com> <52FCA810.2080604@marel.com>
 <530C8967.2050900@marel.com> <530CBD81.1090703@xenomai.org>
In-Reply-To: <530CBD81.1090703@xenomai.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] resource leak and kernel panic with pSOS q_vcreate on
 arm (BeagleBone Black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org


On 25/02/14 15:57, Philippe Gerum wrote:
> On 02/25/2014 01:15 PM, Marcel van Mierlo wrote:
>> Hi,
>>
>> I posted this information a few weeks back but got no response...does
>> anyone have insight on this...I've been digging into the queue
>> management code in Xenomai but I'm not getting very far...any help on
>> this would be appreciated as I am not sure what to try next.
>>
>
> Broken auto-cleanup code at work. Please pull the fixes from 
> git://git.xenomai.org/xenomai-2.6.git:
>
> http://git.xenomai.org/xenomai-2.6.git/commit/?id=5704dd0c118c5c85c22f703ea937551c88e0ef44 
>
> to
> http://git.xenomai.org/xenomai-2.6.git/commit/?id=4081e1b032329bf0cc9442f466233d5fc1083fc5 
>
>

This appears to have fixed the problem for both my test and development 
applications.

Many thanks,
Marcel.


