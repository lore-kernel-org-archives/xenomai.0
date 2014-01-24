Message-ID: <52E25C7E.6040002@xenomai.org>
Date: Fri, 24 Jan 2014 13:28:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52E1D646.8050907@steinkuehler.net> <52E24D0C.4050207@xenomai.org>
 <52E25099.9070107@steinkuehler.net> <52E25A15.4080406@xenomai.org>
 <52E2544A.3060907@steinkuehler.net>
In-Reply-To: <52E2544A.3060907@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM/BeagleBone Thumb2 Kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 01/24/2014 12:53 PM, Charles Steinkuehler wrote:
> On 1/24/2014 6:18 AM, Gilles Chanteperdrix wrote:
>> On 01/24/2014 12:38 PM, Charles Steinkuehler wrote:
>>> As I understand it, the issue arises as the kernel grows larger and the
>>> distance between the branch and it's target increases.  My vmlinux for
>>> the (fixed Thumb2 version) BeagleBone kernel is currently weighing in at
>>> 13225004 bytes.
>>>
>> That is precisely the thing I do not understand: the jump goes from
>> entry-armv.S to entry-common.S which should remain close since they
>> follow each other on the link-edit command line. Since the source files
>> are assembly, the distance should more or less be the same, whatever the
>> compilation options. And if they are not close, this is where the bug
>> is, because this assembly is used for every syscall and every interrupt.
>
> Well I don't pretend to know what goes on in the kernel memory map.  Is
> there anything I can send from my kernel builds that would shed light on
> this (a linker map or something)?
>

I have no doubt that in the kernel you build, entry-arm.S and 
entry-common.S end up far from each other, which a linker map would 
show. What I am interested in is why this happens, for that, I need to 
build the kernel the same way you build it, and see what happens. You 
have given me all I need.

-- 
					    Gilles.

