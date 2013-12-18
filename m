Message-ID: <52B231AD.2010604@alaxarxa.net>
Date: Thu, 19 Dec 2013 00:37:17 +0100
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xddp protocol: question of one example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm developing an application that need (as always) interchange data between a realtime part and non-realtime.

Looking on the documentation and surfing on the web I have found interesting for my app the examples of xddp protocol. Some time ago, there was an interesting mail about it [1].

There, the original author ask one thing that I would like to be sure that I understood. On the examples, the realtime thread uses the function recvfrom() to receive data from the non-rt thread.

In the mail, the original author asked about make recvfrom 
call non-blocking in xddp context, and *Philippe Gerum* answered that 
MSG_DONTWAIT should be set in flags.

So, my question is that using that flag, some code like this:


/* Read back packets echoed by the regular thread */
ret = recvfrom(s, buf, sizeof(buf), 0, NULL, 0);
if(ret <= 0)
    fail("recvfrom");

recvfrom will not be blocked, but it will return 0?

May I understood that if there's data on the sockect recvfrom will
return something and if no, it would not be blocked and return something?

Thanks in advance,

Leopold

[1] http://www.xenomai.org/pipermail/xenomai/2010-February/019364.html

-- 
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?


