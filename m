Date: Sun, 28 Feb 2021 19:26:45 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: High latency when over stress
Message-ID: <SN6PR08MB5661F9CC518F4FDBA2B20066939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I'm doing a comparison of interrupt handling on Xenomai using a 
raspberry pi 3-b in 2 situations:
1- No stress
2- Running stress-ng on terminal: $ nice -19 stress-ng -c 4 --metrics 
--timeout 120s&

What I do is to create a periodic task (priority 50) that runs every 
500us activating gpio22 for 250us and save the activating time. Another 
task, with priority 99 is meant to catch the interrupts in a while loop 
and save the time as well for computing the time differences later. 
This is done 100000 times and in the end I do some verifications.

On situation 1 (no stress) I get:
Min: 11823ns
Max: 17761ns
Standard deviation: 258.96ns
Mean: 13103.17ns

On situation 2 (with cpu stress)  I get:
Min: 12239ns
Max: 721302ns
Standard deviation: 32976.01ns
Mean: 29112.24ns

I would not say the higher mean is actually a problem (could be), but 
the standard deviation is much higher and I don't think this is the 
desired result for Xenomai.
Is the first result fine?
What could be causing this?
Any addition information just ask me.

Thank you,
Gabriel Dinse

