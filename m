Message-ID: <BLU437-SMTP3567D7D9516D88AF50AA67F0130@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Wed, 11 Nov 2015 07:40:03 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Latency test on RP2 vs Odroid-C1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I finally was able to run the latency test on RPI2.

the results are showing: lat best of 7.705 and worst 16.605
with an average of 9.129

Is there  anybody that ran the same test on Odroid C1 board?
I would like to know how does it compare.

This test was run right after the login prompt (no graphics, no Ethernet 
activity, no manually started apps/services other than the systemd ones).

Also ran the xenomai autotune right before.

Is there a database of boards with their test results?

Thanks,
-Mathieu

