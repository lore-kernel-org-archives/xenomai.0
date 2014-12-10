Message-ID: <5488B2DF.2080004@nta-inc.net>
Date: Wed, 10 Dec 2014 14:53:51 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca> <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca> <5488A985.2070006@xenomai.org>
In-Reply-To: <5488A985.2070006@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 12/10/2014 02:13 PM, Philippe Gerum wrote:
> On 12/10/2014 08:44 PM, Lennart Sorensen wrote:
>> On Wed, Dec 10, 2014 at 08:45:01PM +0100, Philippe Gerum wrote:
>>> On 12/10/2014 08:19 PM, Lennart Sorensen wrote:
>>>> On Wed, Dec 10, 2014 at 08:13:50PM +0100, Gilles Chanteperdrix wrote:
>>>>> This is true in user space. Not for kernel modules, see:
>>>>> https://git.xenomai.org/ipipe.git/tree/Documentation/stable_api_nonsense.txt?h=ipipe-3.14
>>>>
>>>> I can't even figure out how to track down which call is making it
>>>> reference that symbol (for which it has zero interest of course).
>>>>
>>>> I suppose if whoever made the change in ipipe (which unfortunately the
>>>> ipipe git tree does not make easy to track down since it isn't like it
>>>> is one git tree moving from version to version) does not see the point
>>>> in reverting the change, then I will just have to keep a patch around to
>>>> do it instead and ignore the advisory on the symbol to get this to work.
>>>> I really don't want to do that, but stupid changes sometimes need stupid
>>>> fixes.
>>>>
>>>> This code does NOT use any xenomai or ipipe features.  Other code does.
>>>> ipipe should not be breaking it.
>>>>
>>>
>>> The stupid guy is me, as the main copyright holder on most of the code
>>> you have been using with Xenomai so far. So where do we go from here?
>>
>> No one said the guy was stupid.  Just the change.
>>
>> As far as I can tell, __ipipe_root_status is a number containing some
>> status.  It is not a function, it doesn't do anything by itself, so why
>> did it need to be changed to GPL only if that causes the entire kernel
>> to become GPL only (from what I have been able to tell so far)?
>>
>> I certainly think having the ipipe functions limited to GPL only seems
>> perfectly reasonable.  It is new functionality the kernel didn't have
>> before.  I don't think it should make existing kernel functions suddenly
>> be GPL only though.
>>
>> I will do a test build with the symbol changed back to see if that is
>> in fact the only thing causing issues for the external module.
>>
>
> The point is about being able to discuss issues without starting useless
> rants or flame wars.
>
> The I-pipe interface was moved to GPL_ONLY to clearly state that such
> code intimately depends on the kernel innards, has to know about them to
> function, and therefore any client code has to be GPL-compatible to
> comply with the kernel license.
>
> The only question that matters is: does __ipipe_root_status belong to
> the visible I-pipe API exposed to clients? The answer from the copyright
> holder of this particular code is "no".
>
> Ah, maybe it was a mistake then, something that was overlooked, just
> because I-pipe maintainers don't routinely have to rebuild non-GPL
> software on top the I-pipe? Yes, most likely it was.
>
> Could the code be changed to fix this, then? Yes, it sounds reasonable,
> and would not change the original intent of moving the API symbols to
> GPL_ONLY.
>
> The issue is non-ambiguous, the solution is straightforward. Let's
> relax, there is work ahead.
>

I had a similar issue in the past getting an I-pipe patched kernel to work with the proprietary nvidia driver module.  I added the following lines to my build script to get things working on Ubuntu 12.04 (x86-64) with a 3.5.7 kernel:

if [ ${FIX_SYMBOL_EXPORT} = 1 ]; then
     sed -i 's/EXPORT_PER_CPU_SYMBOL_GPL(ipipe_percpu);/EXPORT_PER_CPU_SYMBOL(ipipe_percpu);/' kernel/ipipe/core.c
     sed -i 's/EXPORT_SYMBOL_GPL(ipipe_restore_root);/EXPORT_SYMBOL(ipipe_restore_root);/' kernel/ipipe/core.c
     sed -i 's/EXPORT_SYMBOL_GPL(ipipe_root_only);/EXPORT_SYMBOL(ipipe_root_only);/' kernel/ipipe/core.c
     sed -i 's/EXPORT_SYMBOL_GPL(__ipipe_spin_unlock_debug);/EXPORT_SYMBOL(__ipipe_spin_unlock_debug);/' kernel/ipipe/core.c
fi

As one would expect, worst-case latencies with the nvidia module loaded are terrible, but this capability can be useful from a code development standpoint on machines that don't work well with the free software nouveau driver.

-Jeff



