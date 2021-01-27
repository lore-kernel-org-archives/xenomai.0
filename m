References: <CAPMj8MtS-vAssX+P8rywMUoFfs-DeCh_2f4sZts5Jk2Dk_rOEw@mail.gmail.com>
 <CAPMj8Mv8194p8qCPRgke=w+A14d9f9mf0P6OhR2k67Tqr=JUJw@mail.gmail.com>
 <8ebae193-88ec-e4b1-d86b-642a594ac7da@siemens.com>
 <CAPMj8Mtgv3FzX9H8ZRc9jCZsp8u6RhuyjXGJkbpfK6UoneNQVA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Look up all IDDP/XDDP labels in the registry from userspace
In-reply-to: <CAPMj8Mtgv3FzX9H8ZRc9jCZsp8u6RhuyjXGJkbpfK6UoneNQVA@mail.gmail.com>
Date: Wed, 27 Jan 2021 07:24:24 +0100
Message-ID: <87ft2m3njb.fsf@xenomai.org>
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
To: Sam Daniel <daniel.jacob.samuel@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Sam Daniel via Xenomai <xenomai@xenomai.org> writes:

> On Tue, Jan 26, 2021 at 10:07 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
>> On 25.01.21 22:07, Sam Daniel via Xenomai wrote:
>> > On Mon, Jan 25, 2021 at 12:20 PM Sam Daniel <
>> daniel.jacob.samuel@gmail.com>
>> > wrote:
>> >
>> >> Is it possible to look up from userspace code all of the IDDP/XDDP
>> labels
>> >> that exist in the registry without leaving the primary domain?
>> >>
>> >> I have tried a few different ways of reading the contents of
>> >> /proc/xenomai/registry/rtipc/iddp. The inotify API causes mode switches
>> (it
>> >> relies on select or poll), not to mention that inotify does not work
>> well
>> >> with virtual filesystems. And using the C++ filesystem library to read
>> the
>> >> contents of the directory also causes mode switches (filesystem
>> >> interactions).
>> >>
>> >> Is there a real-time API function that I can use to query these labels?
>> >>
>> >
>> > C++ filesystem library is causing mode switches because of an mmap deep
>> in
>> > its call stack, not because of "filesystem interactions" like I initially
>> > thought.
>> >
>>
>> What is the use case you need label listing from RT context for?
>>
>> Jan
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>>
>
> My use case is an IDDP-based pub/sub messaging system for real-time threads.
>
> Threads publish and subscribe to a channel ("xyz"). Any number of threads
> can publish to any channel. And any number of threads can subscribe to any
> channel (and each one should receive every message published to that
> channel).
>
> Subscribers bind labeled IDDP sockets for each channel using labels like
> so: <channel name>-<thread name>. If three threads subscribe to channel
> "xyz" then I would expect /proc/xenomai/registry/rtipc/iddp to show:
> xyz-threadA -> 0
> xyz-threadB -> 1
> xyz-threadC -> 2
>
> For the pub/sub implementation to work, when thread X calls publish("xyz",
> &message) the publish method would need to multicast the message to all
> three of the IDDP sockets above.
>

This is pretty much what the Observable feature does in the EVL core
which we are going to use for Xenomai 4:
https://evlproject.org/core/user-api/observable/

Adding this feature natively to the existing RTIPC driver may be a
better option than emulating it over IDDP.

-- 
Philippe.

