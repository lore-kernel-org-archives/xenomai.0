Message-ID: <535659BE.4000601@xenomai.org>
Date: Tue, 22 Apr 2014 13:59:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
 <53564F83.4070401@control.lth.se>
 <A973FC64-9FD8-4892-BF4B-2BBE74942BA3@mah.priv.at>
In-Reply-To: <A973FC64-9FD8-4892-BF4B-2BBE74942BA3@mah.priv.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM: Ethernet driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 04/22/2014 01:53 PM, Michael Haberler wrote:
>
> Am 22.04.2014 um 13:16 schrieb Anders Blomdell
> <anders.blomdell@control.lth.se>:
>
>> On 04/22/2014 11:45 AM, yogesh garg wrote:
>>> I want to write Ethernet (NIC) driver on Xenomai using RTDM. I
>>> don't want to use RTnet.
>> Why not?
>>
>> RTnet does not imply that you have to use the RTnet protocol, it's
>> perfectly fine to use just the Ethernet drivers as you see fit
>> (that's what I do all the time).
>>
>> By going your own way, realtime ethernet for Xenomai will be
>> fragmented, which will benefit nobody (except possibly
>> WindRiver/Microsoft/...)
>
> well there are valid reasons
>
> One we have is: since the application runs across RTAI, Xenomai and
> RT_PREEMPT a single method would be beneficial, even at the cost of
> lower performance. Not everyone is fond of networking silos.

RTnet already works with RTAI and Xenomai, the API exposed by RTnet is 
the standard socket interface and drivers in RTnet are copycats of Linux 
drivers.

So, I do not see what prevents you from using Linux drivers with Linux 
and preempt_rt and RTnet drivers with Xenomai and RTAI.

-- 
					    Gilles.

