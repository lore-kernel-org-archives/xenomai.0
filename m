Message-ID: <5018FC50.80207@xenomai.org>
Date: Wed, 01 Aug 2012 11:52:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <208C6975C932E94F86239FEA59CCA632068318D3@AUSMXMBX02.mrws.biz>	<50128EE5.3090904@xenomai.org>	<208C6975C932E94F86239FEA59CCA63206831B5C@AUSMXMBX02.mrws.biz>
	<5018F130.40301@xenomai.org> <5018F534.6000503@xenomai.org>
In-Reply-To: <5018F534.6000503@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH, Xenomai 2.5.6]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 08/01/2012 11:21 AM, Gilles Chanteperdrix wrote:
> On 08/01/2012 11:04 AM, Philippe Gerum wrote:
>> On 08/01/2012 08:58 AM, dietmar.schindler@manroland-web.com wrote:
>>>> -----Original Message-----
>>>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>>>> Sent: Friday, July 27, 2012 2:52 PM
>>>> To: Schindler, Dietmar RAEK1 MRA
>>>> Cc: xenomai@xenomai.org
>>>> Subject: Re: [Xenomai] [PATCH, Xenomai 2.5.6]
>>>>
>>>> On 07/27/2012 02:45 PM, dietmar.schindler@manroland-web.com wrote:
>>>>> These are patches for two files in ksrc/nucleus of Xenomai 2.5.6 to cure
>>>> an incompatibility with Linux 2.4; if they are bad in form, please let me
>>>> know.
>>>>>
>>>>
>>>> You should backport this patch from the 2.6 tree instead:
>>>> e3c13f0685c2edf2a2ce30cd239b3f
>>>
>>> I'm sorry, I can't figure out how to locate this patch.
>>
>>   From this tree:
>> git://git.xenomai.org/xenomai-2.6.git
>>
>>    However, I found the attached message where you pointed to another
>> patch, just for Xenomai 2.5.6, so I'll use that one, and let's forget my
>> surplus duplication of work.
>
> I wonder if the 2.5 git does not already contain the fix:
>
> http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=c208eda73e263207fe32a01e35931e82e4a18321
>

Yes, but non released, since this is on top of 2.5.6. It is part of the 
set of pending commits I mentioned lately, that should lead to 2.5.7, 
because we close that branch for good.

-- 
Philippe.

