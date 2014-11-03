Message-ID: <54579D7A.2010800@bmwedler.de>
Date: Mon, 03 Nov 2014 16:21:30 +0100
From: Registrierungen <regist@bmwedler.de>
MIME-Version: 1.0
References: <54509406.4000600@bmwedler.de> <54509629.8080107@bmwedler.de>
 <54577374.9010609@bmwedler.de> <5457811D.2030502@xenomai.org>
 <5457818E.80806@xenomai.org>
In-Reply-To: <5457818E.80806@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using pipes in 3.0rc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

I tried with rc2, but now it returns with error 3 (not -3) ?


Am 03.11.2014 14:22, schrieb Philippe Gerum:
> On 11/03/2014 02:20 PM, Philippe Gerum wrote:
>> On 11/03/2014 01:22 PM, Registrierungen wrote:
>>> Sorry for the late feedback.
>>>
>>> I found the source where it goes wrong:
>>>
>>>      if (poolsize > 0) {
>>>          ret = __RT(setsockopt(sock, SOL_XDDP, XDDP_POOLSZ,
>>>                        &poolsize, sizeof(poolsize)));
>>>          if (ret)
>>>              goto fail_sockopt;
>>>      }
>>>
>>> Hope there could be found a solution for me.
>>>
>> The solution was given a few days ago:
>>
>> http://www.xenomai.org/pipermail/xenomai/2014-October/032054.html
>>
> Those patches are present in -rc2, released a couple of days ago. You
> should not bother with -rc1 anymore.
>


