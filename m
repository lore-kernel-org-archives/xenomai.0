Message-ID: <50E5DECA.6060505@xenomai.org>
Date: Thu, 03 Jan 2013 20:40:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3a62cd359d1baaa923985e5438f7b75a.squirrel@www.nta-inc.net>
	<50E2C4C6.60306@xenomai.org> <50E461E2.10502@nta-inc.net>
In-Reply-To: <50E461E2.10502@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM serial issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 01/02/2013 05:35 PM, Jeff Webb wrote:

> On 01/01/2013 05:13 AM, Gilles Chanteperdrix wrote:
>> On 01/01/2013 05:09 AM, jeff.webb@nta-inc.net wrote:
>> 
>>> When I try to open an RTDM serial device under
>>> Xenomai-2.6.2/Linux 3.4.6 (Ubuntu 12.04), the call appears to
>>> succeed, but I get the following output in /var/log/kern.log:
>>> 
>>> [...]
>>> 
>> 
>> This is a known issue, for a proposed fix, see: 
>> http://www.xenomai.org/pipermail/xenomai/2012-October/026566.html
>> 
>> Whether we are merging this patch is still not sure.
> 
> Are there performance issues if the patch is not applied, or does the
> patch essentially just remove the worrisome log messages?  From the
> commit message, it sounds like the latter.



I am just expecting some unforeseen changes such as deadlocks. Also, it
may be simpler to simply skip the warning when compiling with
CONFIG_IPIPE_LEGACY.

>>> Thanks for all the fine work in putting together this latest
>>> release.
>> 
>> 
>> I am wondering whether you are ironical, a new release should
>> happen shortly to fix all the issues which were forgotten.
> 
> No, I'm being sincere.  In hindsight, I can see how you might have
> taken my comment the wrong way, so I apologize for not being more
> clear.  I do think you all have put a lot of fine work into this
> latest release, despite the issues that may have worked their way
> into it.  I realize that sometimes making a release is the only way
> to get code thoroughly tested, so I think what has transpired is is
> pretty reasonable, in my view.  I do want to express my thanks for
> the work you and others do to keep Xenomai moving forward.  I don't
> take it for granted.


Sorry for the misunderstanding, you are welcome, happy new year to you too.


-- 
                                                                Gilles.

