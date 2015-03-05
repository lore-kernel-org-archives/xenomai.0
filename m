Message-ID: <54F833B5.3070408@web.de>
Date: Thu, 05 Mar 2015 11:45:09 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <649EF91064D35D40B9C93A225BF416746132AF7E@NWD2MBX7.ad.analog.com>
 <54F80D5A.5050901@web.de>
 <649EF91064D35D40B9C93A225BF416746132B064@NWD2MBX7.ad.analog.com>
In-Reply-To: <649EF91064D35D40B9C93A225BF416746132B064@NWD2MBX7.ad.analog.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] status of rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Wu, Aaron" <Aaron.Wu@analog.com>, "rtnet-developers@lists.sourceforge.net" <rtnet-developers@lists.sourceforge.net>, Xenomai <xenomai@xenomai.org>
Cc: "Zhang, Sonic" <Sonic.Zhang@analog.com>

On 2015-03-05 09:17, Wu, Aaron wrote:
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@web.de]
>> Sent: 2015年3月5日 16:02
>> To: Wu, Aaron; rtnet-developers@lists.sourceforge.net; Xenomai
>> Subject: Re: status of rtnet
>>
>> On 2015-03-05 06:51, Wu, Aaron wrote:
>>> Hello,
>>>
>>> >From http://www.rtnet.org I saw the latest release of rtnet is years ago,
>> latest kernel support is 3.2. What's the status and roadmap of this project? Any
>> plan/schedule to support the newer version of kernel and xenomai?
>>
>> Fortunately, RTnet has been "adopted" by the Xenomai project (its list is on CC).
>> So the next RTnet release will actually be the next major Xenomai release: 3.0.
>> You can already pick up the latest 3.0-rc of Xenomai to obtain a more recent
>> version than what can be found in the RTnet git.
>>
>> Jan
>>
> 
> Thanks for the good news, in the latest 3.0-rc Xenomai code I saw there is support for kernel 3.16 for ARM, I would expect Rtnet works on 3.16 kernel for ARM too.

I would assume the same about the core as well. But you will have to
check if your target system's NIC is already supported or if some driver
porting is still required.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150305/11b4cc1d/attachment.sig>
