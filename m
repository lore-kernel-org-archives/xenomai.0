From: "Franz Engel" <franz_lambert_engel@yahoo.de>
Date: Fri, 21 Feb 2014 18:16:45 +0100
Message-ID: <000d01cf2f28$b2cab4a0$18601de0$@de>
MIME-Version: 1.0
Content-Language: de
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Paradox communication delay
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

I made a little benchmark of the communication performance of my system
(with Rtnet). Therefore I use an external Data Analyzer (Anritsu) and
measure the delay between each telegram. I tried to send every 4ms. Pseudo
code:

while(true):

ret=sendto(...)

sleep(4ms)

endwhile

I make this test two times. One time with a totally unstressed system. That
means I isolated the specific core, where my real-time task is working, and
there are no other running programs. The result is that the mean delay of my
communication was 0,004003518.

For the second test I stressed my system with "taskset -c 0-11 stress --cpu
12" (that means each core is working with 100%). Now I have the funny
effect, that the result of the second test is better than the first one. In
the second test I have an mean delay of 0,004000951. That means, the mean
delay of the stressed system is 2.567 micro seconds faster than the
unstressed system.

Does somebody have an idea what could be the reason for this phenomenon?

Regards,

franz

 

