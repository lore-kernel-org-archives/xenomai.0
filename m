Subject: Re: Look up all IDDP/XDDP labels in the registry from userspace
References: <CAPMj8MtS-vAssX+P8rywMUoFfs-DeCh_2f4sZts5Jk2Dk_rOEw@mail.gmail.com>
 <CAPMj8Mv8194p8qCPRgke=w+A14d9f9mf0P6OhR2k67Tqr=JUJw@mail.gmail.com>
 <8ebae193-88ec-e4b1-d86b-642a594ac7da@siemens.com>
 <CAPMj8Mtgv3FzX9H8ZRc9jCZsp8u6RhuyjXGJkbpfK6UoneNQVA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <10c180a0-4589-556e-1b1b-5b96f2fa382b@siemens.com>
Date: Tue, 26 Jan 2021 21:00:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAPMj8Mtgv3FzX9H8ZRc9jCZsp8u6RhuyjXGJkbpfK6UoneNQVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sam Daniel <daniel.jacob.samuel@gmail.com>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: xenomai@xenomai.org

On 26.01.21 20:44, Sam Daniel wrote:
> On Tue, Jan 26, 2021 at 10:07 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 25.01.21 22:07, Sam Daniel via Xenomai wrote:
>     > On Mon, Jan 25, 2021 at 12:20 PM Sam Daniel
>     <daniel.jacob.samuel@gmail.com <mailto:daniel.jacob.samuel@gmail.com>>
>     > wrote:
>     >
>     >> Is it possible to look up from userspace code all of the
>     IDDP/XDDP labels
>     >> that exist in the registry without leaving the primary domain?
>     >>
>     >> I have tried a few different ways of reading the contents of
>     >> /proc/xenomai/registry/rtipc/iddp. The inotify API causes mode
>     switches (it
>     >> relies on select or poll), not to mention that inotify does not
>     work well
>     >> with virtual filesystems. And using the C++ filesystem library to
>     read the
>     >> contents of the directory also causes mode switches (filesystem
>     >> interactions).
>     >>
>     >> Is there a real-time API function that I can use to query these
>     labels?
>     >>
>     >
>     > C++ filesystem library is causing mode switches because of an mmap
>     deep in
>     > its call stack, not because of "filesystem interactions" like I
>     initially
>     > thought.
>     >
> 
>     What is the use case you need label listing from RT context for?
> 
>     Jan
> 
>     -- 
>     Siemens AG, T RDA IOT
>     Corporate Competence Center Embedded Linux
> 
> 
> My use case is an IDDP-based pub/sub messaging system for real-time threads.
> 
> Threads publish and subscribe to a channel ("xyz"). Any number of
> threads can publish to any channel. And any number of threads can
> subscribe to any channel (and each one should receive every message
> published to that channel).
> 
> Subscribers bind labeled IDDP sockets for each channel using labels like
> so: <channel name>-<thread name>. If three threads subscribe to channel
> "xyz" then I would expect /proc/xenomai/registry/rtipc/iddp to show:
> xyz-threadA -> 0
> xyz-threadB -> 1
> xyz-threadC -> 2
> 
> For the pub/sub implementation to work, when thread X calls
> publish("xyz", &message) the publish method would need to multicast the
> message to all three of the IDDP sockets above.
> 
> I would like to look up all labels in the registry from within the
> publish method to check if any subscribers have gone away or if any new
> subscribers have appeared and then adjust the multicast of the message
> accordingly.

RTIPC is not designed for such use cases - no multicast support as you
may have noticed already. Polling for labels to appear or disappear
would be a poor man's workaround. Still, you could make it "work": poll
with a non-RT thread for registry changes, update a lock-protected list
of subscribers, and use that list from the publish method in RT context.

That reminds of that simple (but rather domain specific) IPC driver we
once had, Sebastian. ;)

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

