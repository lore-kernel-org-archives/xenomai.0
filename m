Subject: Re: Periodic timing varies across boots
References: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
Date: Mon, 25 Feb 2019 09:09:06 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 24.02.19 07:57, C Smith via Xenomai wrote:
> I am using Xenomai 2.6.5, x86 32bit SMP kernel 3.18.20, Intel Core
> i5-4460,  and I have found a periodic timing problem on one particular type
> of motherboard.
> 
> I have a Xenomai RT periodic task which outputs a pulse to the PC parallel
> port, and this pulse is measured on a frequency counter. This has been
> working fine for years on several motherboards. I am able to adjust the
> period of my task to within +/-10nsec, according to the frequency counter.
> I can calibrate the periodic timing down to a period +/-10nsec on this
> motherboard, and I cna restart my xenomai process many times and the timing
> is fine. But if I cold-reboot the machine the measured period is wrong by
> up to  +/-300nsec. Thus I cannot get consistent periodic timing from day to
> day without recalibrating, which is unacceptable in my application.
> 
> In my kernel config, I am using the TSC: CONFIG_X86_TSC=y
> I use rt_timer_read() to determine what time it is, and my periodic task
> sleeps in a while loop, like this:
>        next += period_ns + adjust_ns;
>        rt_task_sleep_until(next);
> 
> I don't know what to test. Can you suggest anything?
> 

Can you reproduce the issue with a supported Xenomai and kernel version?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

