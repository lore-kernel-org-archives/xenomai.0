Message-ID: <528CDA6B.3040006@xenomai.org>
Date: Wed, 20 Nov 2013 16:51:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
 <528CCE14.2040505@xenomai.org>
 <9D6EB0D5-6C76-4B1B-A007-B889A42CEBE2@mah.priv.at>
In-Reply-To: <9D6EB0D5-6C76-4B1B-A007-B889A42CEBE2@mah.priv.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] integrate event signaled by RT thread into non-RT
 event loops (poll, select, eventfd..)?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/20/2013 04:31 PM, Michael Haberler wrote:
> Gilles,
>
> Am 20.11.2013 um 15:58 schrieb Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org>:
>
>> On 11/20/2013 03:33 PM, Michael Haberler wrote:
>>> I'm looking for a simple method to post an event from an RT
>>> thread so a userland non-RT thread can wait for, and pick it up
>>> via a file descriptor
> ..
>>> if it's possible from a kernel RT context, it's a plus
>>
>> You may use XDDP IPC for that, see:
>> http://www.xenomai.org/documentation/xenomai-2.6/html/api/xddp-echo_8c-example.html
>>
>>
>>
-- 
>> Gilles.
>
>
> well thank you, that fits the bill exactly!
>
> in case I would want to use the same method with kernel RT as long as
> that lives, I take from the below post I would have to use the native
> rt_pipe API to talk to the userland counterpart (the latter unchanged
> I assume)?
>
> http://www.mail-archive.com/xenomai-help@gna.org/msg11181.html

You should be able to use the RTDM API in kernel-space. Provided that 
you use the "rt_dev" prefix.

-- 
					    Gilles.

