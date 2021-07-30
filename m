MIME-Version: 1.0
From: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>
Date: Fri, 30 Jul 2021 09:02:33 -0700
Message-ID: <CAM4LU5+rSBmK1h_4BdPq4b6iYFO8WA2BocvFYA79EY+NJ2y33Q@mail.gmail.com>
Subject: Xenomai and Linux SCHED_FIFO threads Question
Content-Type: text/plain; charset="UTF-8"
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
   We are trying to move our embedded real time application from RTOS to
Linux. So we first ported our RTOS application to a RT-Linux. In RT-Linux
we have cpu isolation and run our main realtime interrupt as a  pthread
with highest priority on the isolated core. Rest of the application on
other cores. We are observing that the execution time(Interrupt Service
Routine duration) of the realtime interrupt is longer than running on a
traditional RTOS. So we are trying to put just this real time interrupt
service routine thread into Xenomai. In the RT linux Application we have
set the scheduling policy for a number of threads to SCHED_FIFO(Including
the Realtime Interrupt Service thread). Is it possible to run just the
realtime interrupt service routine thread under Xenomai and run the other
SCHED_FIFO thread under linux? or do we lose the Linux SCHED_FIFO once we
include Xenomai?

Rajesh
