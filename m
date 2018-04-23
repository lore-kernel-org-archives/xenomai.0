Date: Mon, 23 Apr 2018 19:32:00 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180423193200.795ee88b@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <e0cc88bf-1fd8-1c01-513b-b7444b323da7@siemens.com>
References: <e0cc88bf-1fd8-1c01-513b-b7444b323da7@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] dlopen test in current stable fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Fri, 6 Apr 2018 19:07:47 +0200
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> Henning,
> 
> should dlopen work with stable-3.0.x? The test case is merged, but it
> fails for me.
> 
> ../../../lib/boilerplate/setup.c:686: __register_setup_call: Assertion
> `!main_init_done' failed.

This is because you have debugging enabled when running the tests,
thanks for the report.

Looking into that i found several issues with the testcase, will send
patches soon.

Henning
 
> (at this chance I noticed that redirecting smokey outputs on the
> command line does not work as well - different story).
> 
> Jan
> 


