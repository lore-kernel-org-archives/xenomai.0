Message-ID: <548EFDC9.9070008@nta-inc.net>
Date: Mon, 15 Dec 2014 09:27:05 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <548B67E3.1090309@nta-inc.net>
 <20141213010358.GD11058@hermes.click-hack.org>
 <20141213021223.GA24110@csclub.uwaterloo.ca>
 <20141213051151.GE11058@hermes.click-hack.org>
In-Reply-To: <20141213051151.GE11058@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Add cards parameter to rt_e1000e module?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 12/12/2014 11:11 PM, Gilles Chanteperdrix wrote:
> On Fri, Dec 12, 2014 at 09:12:23PM -0500, Lennart Sorensen wrote:
>> On Sat, Dec 13, 2014 at 02:03:58AM +0100, Gilles Chanteperdrix wrote:
>>> I understand the need for the "cards" parameter, but...
>>> Is not there another way to solve this issue ? I do not know,
>>> something in /proc or /sys to tell Linux to not load this driver for
>>> that card? I suppose if we tell Linux to not use its driver for some
>>> cards, then later loading the rtnet driver will be used for these
>>> cards? Adding the cards parameter means that the rtnet drivers
>>> diverge from mainline drivers, and so imply a maintenance cost. On
>>> the other hand, maybe that is a cheaper one than trying and solving
>>> the issue globally.

I think the "cards" parameter is a pretty crude solution, too.  As you mentioned, this seems like a more general problem that Linux would already have a solution for, but my search for another solution turned up empty.

>> Certainly a well behaved driver would not touch a device already handled
>> by a linux driver.  It should be possible to just issue an unbind request
>> to the linux driver for the desired device and then a bind request to
>> the rtnet driver to take over that device.

Thanks for sharing this information.  It sounds like that might work.

> The problem with the
> bind/unbind solution is that the driver that will get all the cards
> first depends on the drivers initialization order. With the "cards"
> parameter, you do not have this issue.

Maybe one could create a script that would attempt to unbind both the rt and non-rt drivers (or check to see which one is bound and then unbind it), and then make the desired "bind" calls.  It would be better if the incorrect binding were not made in the first place, however.  I think the ideal solution would be to have a file that contains device/driver pairs that would keep the kernel from passing the specified devices to any other drivers.  I wonder how hard that would be to implement.

For what it's worth, I have these same issues with 16550 serial port drivers.  The 8250.nr_uarts parameter is helpful, but doesn't cover all use cases.

-Jeff


