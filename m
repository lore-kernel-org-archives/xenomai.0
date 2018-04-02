References: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
 <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d5181033-d020-34bb-8b1b-8a261c885f75@xenomai.org>
Date: Mon, 2 Apr 2018 17:25:35 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, rodrigo.amaducci@uam.es
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/02/2018 04:54 PM, Greg Gallagher wrote:
> I believe you want to look at xddp for communication between RT and
> non RT threads:
> 
> http://xenomai.org/documentation/xenomai-3/html/xeno3prm/xddp-echo_8c-example.html
> 
> I don't have much experience with using message queues for RT to
> non-RT communications but I believe using a message queue with a RT
> and non-RT thread is expected to cause mode switches.

Correct, the Cobalt-enabled nrt thread (i.E. prio=0) would have to
switch temporarily to primary mode for reading/writing, then back to
secondary upon return from syscall. This is expensive when done
frequently. XDDP is the right option for rt <-> nrt chat between threads.

-- 
Philippe.

