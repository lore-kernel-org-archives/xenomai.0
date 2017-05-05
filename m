From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <4dde2217-0520-3b4d-7aa3-2393a0e2c88c@sigmatek.at>
Date: Fri, 5 May 2017 13:37:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] =?utf-8?q?Gatekeeper_taking_1ms_instead_of_13=C2=B5s?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

Hi,

I use the following configuration imx6dl with Kernel 3.10.53 and Xenomai 
2.6.4.

I have a periodic workflow with a timebase of 1ms.
The timebase creates a Xenomai task (timer_task) with priority 99.
In the normal case I have an idle time of 666µs before
the timer_task starts the new period.

In the failed case the last Linux Task switching to Gatekeeper 24µs
before the timer_task starts the new period.
Now I see that the Gatekeeper runs 1004µs and then the normal
workflow starts.

First of all is it possible that the timer_task (prio 99) interrupts the 
Gatekeeper (prio 99) ?

Is there an option that the interruption of the Gatekepper is the reason for
long runtime of the Gatekeeper in error case ?

Because of the short difference (24µs) between start of Gatekeeper and
start of timer_task can be the scheduler be part of the problem ?

Here a short overview of the normal workflow
Xenomai prio 80    53µs
Xenomai prio 30    24µs
Xenomai prio 29    19µs
Xenomai prio 1         1µs
Linux task                40µs
Gatekeeper              71µs
Linux task                77µs
Gatekeeper              13µs
idle                        666µs
-------------------------------------
Sum                        954µs

Kind regards
Wolfgang



