Subject: Re: Xenomai and Linux SCHED_FIFO threads Question
References: <CAM4LU5+rSBmK1h_4BdPq4b6iYFO8WA2BocvFYA79EY+NJ2y33Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8802ca9d-7fd7-c37a-78ea-5c6eaa9bf07c@siemens.com>
Date: Fri, 30 Jul 2021 19:06:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAM4LU5+rSBmK1h_4BdPq4b6iYFO8WA2BocvFYA79EY+NJ2y33Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>, xenomai@xenomai.org

On 30.07.21 18:02, Rajesh Venkataraman via Xenomai wrote:
> Hello,
>    We are trying to move our embedded real time application from RTOS to
> Linux. So we first ported our RTOS application to a RT-Linux. In RT-Linux
> we have cpu isolation and run our main realtime interrupt as a  pthread
> with highest priority on the isolated core. Rest of the application on
> other cores. We are observing that the execution time(Interrupt Service
> Routine duration) of the realtime interrupt is longer than running on a
> traditional RTOS. So we are trying to put just this real time interrupt
> service routine thread into Xenomai. In the RT linux Application we have
> set the scheduling policy for a number of threads to SCHED_FIFO(Including
> the Realtime Interrupt Service thread). Is it possible to run just the
> realtime interrupt service routine thread under Xenomai and run the other
> SCHED_FIFO thread under linux? or do we lose the Linux SCHED_FIFO once we
> include Xenomai?
> 

Nope, you can always call __STD(pthread_create) etc. if you want to get
the normal Linux service.

But keep in mind that you will need Xenomai threads in order to
synchronize with you interrupt thread via sleeping lock (e.g.
pthread-mutexes). If you want to avoid such dependency, you will have to
use lock-less synchronization for shared data.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

