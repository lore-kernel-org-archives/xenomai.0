Message-ID: <542A97C7.8000701@xenomai.org>
Date: Tue, 30 Sep 2014 13:45:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABVE6k1dDnGUBQSRCDCAcgbnY-eFP422WCwTzZWQPKiD997E-w@mail.gmail.com>
 <2193EAD1-45DF-4E12-8FFD-34AC726315E9@mah.priv.at>
 <CABVE6k1OG+SyDBJuUzJfS8sXi3PO8E2VuHcF6HF126A7j-yLYg@mail.gmail.com>
In-Reply-To: <CABVE6k1OG+SyDBJuUzJfS8sXi3PO8E2VuHcF6HF126A7j-yLYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai: binding failed: Operation not permitted.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SGFzcmV0IFNhcsSxeWVy?= <hsrtsryr@gmail.com>, Michael Haberler <mail17@mah.priv.at>
Cc: Xenomai <Xenomai@xenomai.org>

On 09/30/2014 11:47 AM, Hasret Sarıyer wrote:
> 2014-09-30 10:10 GMT+03:00 Michael Haberler <mail17@mah.priv.at>:
> 
>>
>> http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#binding_failed_Operation_not_permitted
>>
>> -m
>> Am 30.09.2014 um 00:34 schrieb Hasret Sarıyer <hsrtsryr@gmail.com>:
>>
>>> I installed xenomai using this guide
>>> <http://xenomai.org/2014/06/building-debian-packages/>. And there are
>> some
>>> examples under xenomai2.6/examples/rtdm/driver-api folder. I
>>> copied /driver-api folder to desktop. I executed tut02-skeleton-app file,
>>> the output was *Xenomai: binding failed: Operation not permitted.*
>>
>>
> I try to use rtdm modules. Which command should be executed on terminal?
> For nucleus, it is xeno_nucleus.xenomai_gid=<gid>.

This is not a command to be executed on terminal, this is an option to
add to the kernel command line.

Also, first things first, could you try and run the "latency" test as
root, to see if everything is working, or if you still have the missing
/dev/rtheap issue?

-- 
                                                                Gilles.

