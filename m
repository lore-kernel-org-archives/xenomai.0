Message-ID: <55E45EE2.1090307@free.fr>
Date: Mon, 31 Aug 2015 16:04:18 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_e1000e driver issues
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

I am checking timing issues of realtime rtnet frames in my application.
Timing to send a frame is  convenient.
but I have some issues with the time to receive the frames.

Although the RxDelays are cleared, the frame is received almost 175us 
later than it should in comparison with a rt8169 driver (v2.6 version) 
and the same application.

Any idea where to look at first ?
Regards,
Steph




