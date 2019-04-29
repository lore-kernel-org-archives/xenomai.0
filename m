From: Lowell Gilbert <kludge@be-well.ilk.org>
Subject: Re: having problems with daemonizing
References: <44ftq4zcr9.fsf@be-well.ilk.org> <5CC38412.8030107@freyder.net>
 <e0ff187c-8247-e7ed-0ee4-b9a195a393b6@xenomai.org>
Date: Mon, 29 Apr 2019 11:05:29 -0400
In-Reply-To: <e0ff187c-8247-e7ed-0ee4-b9a195a393b6@xenomai.org> (Philippe
 Gerum via Xenomai's message of "Sun, 28 Apr 2019 17:26:39 +0200")
Message-ID: <445zqwg8cm.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum via Xenomai <xenomai@xenomai.org>

Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> On 4/27/19 12:20 AM, Steve Freyder wrote:
>> I think deamonizing in its canonical form of: fork(), let the forked
>> process take over, and then exit() in the parent, is problematic when
>> you have a wrapped main() where the wrappers already initialized the
>> sysreg mechanism but the process that was done for is now gone, and
>> the fork()'ed process has no idea it has a sysreg socket in hand.
>> 
>> Perhaps the better answer when daemonizing is to use --no-init and then
>> have the forked() process do manual xenomai_init() call?

I think that's reasonable. With the caveat that it turns xenomai_init()
into an API function.

> I don't know yet, I'll follow up on this.

