Subject: Re: Disable watchdog
References: <AM0PR07MB5572185C22361C2A197A5324B5630@AM0PR07MB5572.eurprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fa379e1a-6d55-13f4-3b99-d7e245920ce8@siemens.com>
Date: Mon, 18 Feb 2019 13:34:49 +0100
MIME-Version: 1.0
In-Reply-To: <AM0PR07MB5572185C22361C2A197A5324B5630@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 18.02.19 12:23, Giulio Moro via Xenomai wrote:
> Hi there,
> I have my kernel (4.4.113-ti-xenomai-r149 on BeagleBone BlacK) compiled with
> CONFIG_XENO_OPT_WATCHDOG=y
> CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
> 
> I would like to experience the breeze of running without watchdog, to see what the bare-metal performance of the board are, removing the overhead of context switching and thread scheduling. I know this could be harmful for Linux, but I'd like to see what happens there. Is there any way I could disable the watchdog and have a thread busy waiting on a hardware flag, without recompiling the kernel with CONFIG_XENO_OPT_WATCHDOG=0 ?
> 
> I have tried  catching SIGXCPU, and also using pthread_sigmask, e.g.:
>          sigset_t set;
>          int s;
>          sigemptyset(&set);
>          sigaddset(&set, SIGXCPU);
>          s = pthread_sigmask(SIG_BLOCK, &set, NULL);
> 
> but in both cases my thread is temporarily preempted when the watchdog triggers.
> 

There is the module parameter "watchdog_timeout" which you cannot set to 0 but 
to very large number, even during runtime:

echo 999999 > /sys/module/xenomai/parameters/watchdog_timeout

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

