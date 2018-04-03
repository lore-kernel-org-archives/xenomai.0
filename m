References: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
 <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
 <d5181033-d020-34bb-8b1b-8a261c885f75@xenomai.org>
 <20180403122123.Horde.D2Qo7ce4c1LHdQcBYRZNBmd@webmail.uam.es>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <53039d03-c118-3c20-e7cd-eefc264919d7@xenomai.org>
Date: Tue, 3 Apr 2018 12:43:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180403122123.Horde.D2Qo7ce4c1LHdQcBYRZNBmd@webmail.uam.es>
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
To: rodrigo.amaducci@uam.es, greg@embeddedgreg.com
Cc: xenomai@xenomai.org

On 04/03/2018 12:21 PM, rodrigo.amaducci@uam.es wrote:
> Thank you Greg and Philippe for the quick response.
> 
> I wasn't aware of the existence of XDDP, and it is exactly what I need.
> Problem is that when I run even the xddp-echo.c example from
> http://xenomai.org/documentation/xenomai-3/html/xeno3prm/xddp-echo_8c-example.html
> I get this error "socket: Address family not supported by protocol".
> 
> From what I can read in the documentation
> (https://linux.die.net/man/2/socket) I guess it is related to the use of
> the domain AF_RTIPC, but I don't really know what is going on.
> 
> It compiles without errors or warnings using the following Makefile:
> 

You need to enable the ipc/xddp driver (CONFIG_XENO_DRIVERS_RTIPC_XDDP)
in your kernel.

-- 
Philippe.

