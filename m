References: <574EFA37.5030607@mitre.org>
 <20160601164530.GE14103@hermes.click-hack.org> <574F142C.7060408@mitre.org>
 <20160616132634.GA32532@hermes.click-hack.org>
From: Jeffrey Melville <jmelville@mitre.org>
Message-ID: <57644FE5.3000206@mitre.org>
Date: Fri, 17 Jun 2016 15:30:45 -0400
MIME-Version: 1.0
In-Reply-To: <20160616132634.GA32532@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SIGDEBUG_RESCNT_IMBALANCE with recursive mutex
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 6/16/2016 9:26 AM, Gilles Chanteperdrix wrote:
> On Wed, Jun 01, 2016 at 12:58:20PM -0400, Jeffrey Melville wrote:
>> On 6/1/2016 12:45 PM, Gilles Chanteperdrix wrote:
>>> On Wed, Jun 01, 2016 at 11:07:35AM -0400, Jeffrey Melville wrote:
>>>> Hi,
>>>>
>>>> Setup: Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
>>>> cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin using
>>>> the ipipe patches included with the specified git rev)
>>>>
>>>> We've noticed that SIGDEBUG_RESCNT_IMBALANCE is generated when a
>>>> (Xenomai) mutex is taken recursively by an NRT thread. The snippet at
>>>> the bottom of this message will reproduce the issue. I omitted most of
>>>> the error-checking for brevity.
>>>>
>>>> A couple previous threads have discussed slightly similar problems, but
>>>> I never saw final resolutions:
>>>> http://www.xenomai.org/pipermail/xenomai/2012-January/025278.html
>>>> http://www.xenomai.org/pipermail/xenomai/2014-October/031919.html
>>>>
>>>> As far as "why are we doing this?", the problem area occurs in a test
>>>> suite where some tests have to run as NRT threads because they don't
>>>> have to run real-time and will get killed by the watchdog if they run as
>>>> RT threads. Removing the Xenomai wrappers would also be complicated for
>>>> reasons that are outside of the scope of this email.
>>>
>>> Yeah well, this is an issue that has been known and fixed for so
>>> long that I forgot we knew it:
>>>
>>> https://git.xenomai.org/xenomai-3.git/commit/?id=79f0dd1cdc408b22afe301fa03805349a4a9f151
>>>
>>> I will try and backport this change to 2.6 in 2.6.5. The change
>>> should be easy to backport since it was made prior to most of the
>>> cleanup of mutex and condvars. In 3.x, the kernel does not handle at
>>> all the recursive mutex recursion count, this makes things much
>>> simpler, but the code very different.
>>>
>> Ok thanks. You can disregard my other email then. I'll keep an eye out
>> for the fix and we will avoid that test case for the time being.
>>
>> At some point after 2.6.5 I know we'll have to migrate to 3.x...
> 
> Hi,
> 
> I have pushed a fix for this issue:
> https://git.xenomai.org/xenomai-2.6.git/commit/?id=8047147aff9dee9529f5561ecd7afc29c48d14db
> 
> Could you test it on your side?
> 
> Regards.
> 
Gilles,

I confirmed that the isolated test case no longer causes SIGDEBUG on our
system after rebuilding with the fix. I don't have many miles on the new
build otherwise but will let you know if I see anything strange elsewhere.

Thanks for the quick turnaround with the fix.

Cheers,
Jeff

