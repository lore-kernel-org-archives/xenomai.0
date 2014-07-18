Message-ID: <53C9176A.7090306@xenomai.org>
Date: Fri, 18 Jul 2014 14:47:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <freemail.20140718142302.86957.2@fmxmldata03.freemail.hu>
In-Reply-To: <freemail.20140718142302.86957.2@fmxmldata03.freemail.hu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Memory paging trouble
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>, xenomai@xenomai.org

On 07/18/2014 02:23 PM, Paal Tamas wrote:
> 
> 
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> írta:
>> On 07/18/2014 11:10 AM, Paal Tamas wrote:
>>>
>>>
>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> írta:
>>>> On 07/16/2014 02:42 PM, Paal Tamas wrote:
>>>>> I keep on trying:
>>>>>
>>>>> Gilles,
>>>>>
>>>>> Hopefully this time it will be better.
>>>>>
>>>>> Besides, you can find the test app sourcecode at the end.
>>>>>
>>>>> I am using Xeno 2.6.3 together with a 3.0.15 Linux kernel on an i.MX6 ARM hardware.
>>>>
>>>> Do you have the same issue with a recent patch, like the one for 3.8 or
>>>> for 3.10?
>>>>
>>>> -- 
>>>>                                                                Gilles.
>>>
>>> Do you mean to patch the 3.015 Linux kernel using a xenomai patch for the 3.8 or 3.10 versions? No I did not try it.
>>
>> No, I mean patching Linux 3.8 or Linux 3.10 with the corresponding patch.
>>
>>
>> -- 
>>                                                                Gilles.
>>
> Unfortunately the latest BSP for my board (VAR-SOM-MX6) is for kernel 3.0.35. 
> It was a nightmare to add xenomai support to it.  I had to start with 3.0.15 (since there was no direct Adeos and Xeno path for the 3.0.35).... I don't want to start the whole procedure from the beginning again...
> Is there any other way to start with?

The point is, you do not need the whole BSP to run your program. So, if
you can boot a recent kernel with only support for serial console, that
would be enough to run your test and see if you have any issues.

> 
> Thanks,
> Tamas
> 


-- 
                                                                Gilles.

