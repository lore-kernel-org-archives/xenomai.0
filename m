Date: Fri, 9 Feb 2018 15:14:20 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180209151420.6277cde8@mmd1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] calling xenomai_init multiple times ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

we have been seeing several issues with calling xenomai_init multiple
times for the same skin. Once it was a segfault and another time was an
issue related to the registry.
I want to come up with patches for both cases, but i would like to
understand how it is supposed to work.

My guess is that all the stuff in boilerplate/setup.c is not
thread-safe and should not be called more than once. And we have
multiple dlopen() calls from multiple threads, so might end up calling
things multiple times and at the same time.

So what are the assumptions on, threading and amount of calls to the
init functions?

Henning

