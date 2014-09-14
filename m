Message-ID: <54150B08.5070603@xenomai.org>
Date: Sun, 14 Sep 2014 05:27:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B89CCBE86D4F62448EE4F6367C6D3C891DACCB0F@USMLVA0EM24MSX.ww017.siemens.net>
 <53E14B37.2040202@xenomai.org>
 <1410537098.19920.YahooMailNeo@web142606.mail.bf1.yahoo.com>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD9615@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD962F@USMLVA0EM24MSX.ww017.siemens.net>
 <54135D7D.30104@xenomai.org> <20140914024450.GK17690@csclub.uwaterloo.ca>
In-Reply-To: <20140914024450.GK17690@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question regarding rt_sem_p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/14/2014 04:44 AM, Lennart Sorensen wrote:
> On Fri, Sep 12, 2014 at 10:54:21PM +0200, Gilles Chanteperdrix wrote:
>> On 09/12/2014 10:52 PM, PRADHAN, MAKARAND (RC-CA) wrote:
>>> Small correction:
>>>
>>> The ipipe patch that we are using is derived from ipipe-3.12.0 branch.
>>
>> This means a patch that has not even been tested. It just fixes merge
>> conflicts, and has been compile checked, it has not run on real
>> hardware. The one which has been tested on real hardware is the I-pipe
>> patch for 3.14.0 or 3.14.17.
> 
> Well 3.12 did pass the xenomai testsuite.
> 
> Unfortunately TI isn't quite done moving their patches to the 3.14
> branch yet, so we are still stuck at 3.12 (And the 3.8 branch was way
> too unstable to use for anything at all even before considering xenomai).
> Problem with new chips is that they aren't merged into the official
> kernel yet, so jumping to a new kernel version isn't trivial.
> 
> I will be checking if the 3.14 branch has enough to boot on Monday
> (A lot of stuff was merged in yesterday so it might be getting close now).
> 
I am almost sure I fixed an issue with user-space getting -EINTR with
gdb. I simply did not want to look for the commit if you still have the
issue with 3.14. If 3.14 does not boot, it looks like I will have to
search the commit anyway.

-- 
                                                                Gilles.

