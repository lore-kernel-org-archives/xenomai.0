References: <trinity-1ef46b53-74c5-4379-96b4-54a2dac80070-1538499509655@3c-app-webde-bap30>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <06bcfcbc-7e5d-126e-274c-fcdd32c6aa54@siemens.com>
Date: Tue, 2 Oct 2018 19:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <trinity-1ef46b53-74c5-4379-96b4-54a2dac80070-1538499509655@3c-app-webde-bap30>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_pipe_write Latencies at alchemy skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sascha-Carsten Wedler <FXMaveric@web.de>, xenomai@xenomai.org

On 02.10.18 18:58, Sascha-Carsten Wedler wrote:
>     Hello,
> 
>     i'm using xenomai 3.0.2 on a SMP Kernel and have running a periodic
>     alchemy xenomai task at 10kHz.
>     This task sends data to a non xenomai (linux) task running in an other
>     process using rt_pipe_write and will be read out by a file read
>     operation.
>     I sends every 50x per sec about 25K to the linux process.
>     About every 500ms it occurs, that the call of the rt_pipe_write command
>     takes upto 100x more time, than it normaly does.
>     I've  measured this using rt_timer_read before and after the call.
>     I can't find out why this happend.
>     The size of the pipe buffer has no influence to this and will be read
>     out from linux side fast engough.
>     Can there be any dependencies to the "read process" at linux side?
>     Are there any circumstances which can affect this issue?
> 
>     Hope you can help me with a hint.

Without looking at the details already, a generally recommend pattern to analyze 
such effects is as follows:

- run ftrace (trace-cmd) in flight-recorder mode (enable tracing, but do
   not record to disk), activating primarily all cobalt events and maybe
   also Linux scheduling and signal events
- in your application, stop that trace when you detect a high latency
   (you can write to /sys/kernel/tracing/ e.g.)
- extract the trace log and analyze the activity right before that peak

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

