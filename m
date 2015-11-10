Message-ID: <5641A442.80201@free.fr>
Date: Tue, 10 Nov 2015 09:01:06 +0100
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] safely terminate application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have got some problems terminating my RT application, I have very 
strange behavours.
either locking application, either TERMINATE signal does not seem being 
propagated.

I am using a SIGTERM handler to call a cleanup func to delete everything.

I noticed that if I delete nothing , it seems to quit fine (altough 
there may be lot of memory leaks,etc...)

Unfortunately, I don't have the problem using a small regression test 
... my problem concerns a real life application, with rt_tasks, 
rt_pipes, mutex,rtdm driver ...

At initialisation of program I am loading an xmlfile using libxml2 api. 
I strongly suspect  this library being intrusive, since it modifiess 
some signals, is using mutexes....and may have an impact in
the way my application quits.
http://www.xmlsoft.org/threads.html

if some people have any idea on how I could deal with this problem...

Regards,
Steph



