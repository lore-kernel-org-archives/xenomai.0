Date: Tue, 03 Apr 2018 12:21:23 +0200
Message-ID: <20180403122123.Horde.D2Qo7ce4c1LHdQcBYRZNBmd@webmail.uam.es>
From: rodrigo.amaducci@uam.es
References: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
 <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
 <d5181033-d020-34bb-8b1b-8a261c885f75@xenomai.org>
In-Reply-To: <d5181033-d020-34bb-8b1b-8a261c885f75@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, greg@embeddedgreg.com
Cc: xenomai@xenomai.org

Thank you Greg and Philippe for the quick response.

I wasn't aware of the existence of XDDP, and it is exactly what I  
need. Problem is that when I run even the xddp-echo.c example from  
http://xenomai.org/documentation/xenomai-3/html/xeno3prm/xddp-echo_8c-example.html I get this error "socket: Address family not supported by  
protocol".

 From what I can read in the documentation  
(https://linux.die.net/man/2/socket) I guess it is related to the use  
of the domain AF_RTIPC, but I don't really know what is going on.

It compiles without errors or warnings using the following Makefile:

target = xddp-echo
skin = posix
CC := $(shell /usr/xenomai/bin/xeno-config --cc)
CFLAGS := $(shell /usr/xenomai/bin/xeno-config --skin=$(skin) --cflags)
LDFLAGS := $(shell /usr/xenomai/bin/xeno-config --skin=$(skin) --ldflags)
$(target): $(target).c
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
clean:
	@rm $(target)

Best regards,

Rodrigo


Quoting Philippe Gerum <rpm@xenomai.org>:

> On 04/02/2018 04:54 PM, Greg Gallagher wrote:
>> I believe you want to look at xddp for communication between RT and
>> non RT threads:
>>
>> http://xenomai.org/documentation/xenomai-3/html/xeno3prm/xddp-echo_8c-example.html
>>
>> I don't have much experience with using message queues for RT to
>> non-RT communications but I believe using a message queue with a RT
>> and non-RT thread is expected to cause mode switches.
>
> Correct, the Cobalt-enabled nrt thread (i.E. prio=0) would have to
> switch temporarily to primary mode for reading/writing, then back to
> secondary upon return from syscall. This is expensive when done
> frequently. XDDP is the right option for rt <-> nrt chat between threads.
>
> --
> Philippe.




