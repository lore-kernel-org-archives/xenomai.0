References: <DB5PR0401MB1813333E8ACE184B87CFD047FE610@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <978e8199-bc2e-2241-1321-6d94b9c611e4@xenomai.org>
 <DB5PR0401MB18133712C3E024CD9B8CD907FE600@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <057c11d6-1b14-f6a1-f8a3-ddb17e24fc58@xenomai.org>
 <DB5PR0401MB1813914291F050C338CECB00FE790@DB5PR0401MB1813.eurprd04.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f0c553f1-694f-2c46-2225-7adf0f7f2eb3@xenomai.org>
Date: Thu, 12 Jan 2017 13:03:57 +0100
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1813914291F050C338CECB00FE790@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm64 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerry Huang <jerry.huang@nxp.com>, Jorge Ramirez <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/12/2017 11:24 AM, Jerry Huang wrote:
> 
> 
>> -----Original Message-----
>> From: Jorge Ramirez [mailto:jro@xenomai.org]
>> Sent: Thursday, January 05, 2017 7:09 PM
>> To: Jerry Huang <jerry.huang@nxp.com>; xenomai@xenomai.org
>> Subject: Re: [Xenomai] arm64 support
>>
>> On 01/05/2017 11:39 AM, Jerry Huang wrote:
>>> Thanks a lot.
>>> I sent the request t subscribe this mail list, I don't know if the approval is
>> needed for this request.
>>> >From the below links, they are about the 96boards.
>>> I found one boards DragonBoard410c is based on ARM Contxt-A53, but I
>> didn't find if it is  running ARM32 or ARM64.
>>> Could you please point out where can I find these information?
>>>
>>> Best Regards
>>> Jerry Huang
>>
>> yes, both boards (HiKey and dragon410c) run in 64 bit mode.
>> We also demoed Android 64bit running Xenomai on the HiKey back at ELC-A
>> 2016 to control motors.
>>
>> I think I wrote a simple post entry in the 96boards forum [1] about it.
>>
>> please remember to not top-post when writing to the mailing list.
>>
>> [1] http://www.96boards.org/forums/
> I got the Ipipe patch "ipipe-core-4.1.18-arm64-6.patch" from xenomai website and ported it to Linux-4.1.35 with a little modification (for kernel/trace/ring_buffer.c file).
> But when I boot the Linux, I got the kernel panic as below shows, which was caused by function "irqs_disabled", who can give more comment how to fix it?
> 

All arm64 patches present in the DL area are broken, some critical
changes are missing due to a bug in some obscure code extraction script
for this architecture, do not use them.

Please pull the code from the I-pipe git tree instead (branch ipipe-4.1.y).

-- 
Philippe.

