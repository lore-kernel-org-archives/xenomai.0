From: Marco Barletta <barlettamarco8@gmail.com>
Subject: Help for the first boot
Message-ID: <e4105a9e-3b90-85c9-1def-5007d682f584@gmail.com>
Date: Thu, 15 Apr 2021 20:01:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone, I've just managed to boot up Xenomai on Manjaro Linux 
5.4.105 with Cobalt 3.1 and there are some things I can't understand.
First of all: the guide to installation says I have to find a message in 
the log kernel saying Cobalt vx.y Enabled , i got "Cobalt v3.1 [DEBUG]", 
does this mean Cobalt is enabled?
I have doubt since as the guide says I run the latency test, and I have 
average latencies <1, but when I try to do something like starting 
firefox ( that should be non-real-time) the worst latency goes up from 
around 20 us to >100 us. Is that a normal behaviour?
Moreover when I try to autotune the clock I get this

"
irq gravity... 0 ns
kernel gravity... ./autotune: tuning failed (kernel): Resource 
temporarily unavailable

"

What can this be related?

Thanks for helping.
Tell me if i should send something of my config.


