Message-ID: <53F12A7C.90509@ebus.com>
Date: Sun, 17 Aug 2014 15:19:40 -0700
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe patches for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

I'm in the midst of upgrading the software stack for an embedded 
controller based on a WinSystems PPM-LX800 (was previously Xeno 2.6.1 
and Linux 3.2). I see there are I-pipe patches out for 3.10.32 and 3.14, 
as well as the 3.8.13 included with Xenomai 2.6.3. This is going in a 
road vehicle and so the priority is on stability over the security 
offered by the newer Linux (it should only rarely be connected to a 
network and never to the Internet.) What's your impression of the 
stability of the newer versions vs. 3.8?

Thanks,
     Doug Brunner

