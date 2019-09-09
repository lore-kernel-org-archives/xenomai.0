Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mlJlOiDlm57lpI3vvJpSZTogWGVub21haSBsYXRl?=
 =?UTF-8?Q?ncy_test_not_good?=
References: <20190909114819.B2EC416600E9@webmail.sinamail.sina.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a03bd09-4f50-2f23-5ffc-520d2a7e3771@siemens.com>
Date: Mon, 9 Sep 2019 14:34:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190909114819.B2EC416600E9@webmail.sinamail.sina.com.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hikwlu@sina.com, xenomai <xenomai@xenomai.org>

On 09.09.19 13:48, 鲁克文 wrote:
> Dear Jan Kiszka
> 
> Thanks for your reply.
> And I add "idle=poll" to the kernel parameter, but it results no help;and I 
> enter the BIOS setup window and disable some ACPI setting,also no help.
> 
> For the latency test:(1)when system is startup, and just run latency test, the 
> latency is not very large, just about 13 micro-second;(2) when I run latency 
> test, and then start Firefox to do some web-browsing, as access website like: 
> www.sina.com.cn, the latency suddenly goes higher as hundreds of mirco-second. I 
> wonder whether this phenomenon could help us.
> 

You mean that  you have a graphic desktop running? Try without that. GPUs may 
cause hardware-related latencies as well.

> Also, for the SMI thing, could I just use msr-tools to verify that the realtime 
> system is really influenced by the SMI thing?
> 

The mainline kernel has the Hardware Latency Detector (see 
linux/Documentation/trace/hwlat_detector.rst). Try that with a vanilla kernel on 
your hardware.

Jan

> 
> --------------------------------
> 
> Best regards
> Kevin
> 
> ----- 原始邮件 -----
> 发件人：Jan Kiszka <jan.kiszka@siemens.com>
> 收件人：hikwlu@sina.com, xenomai <xenomai@xenomai.org>
> 主题：Re: 回复：Re: Xenomai latency test not good
> 日期：2019年09月09日 19点19分
> 
> 
> On 09.09.19 12:14, 鲁克文 wrote:
>  > Dear Jan Kiszka:
>  >
>  > I re-enable ACPI_PROCESSOR in the kernel, but also the latency test seems no
>  > good,attached file is the new kernel config file.
>  >
>  > 
> /*********************************************************************************************/
>  > RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
>  > RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
>  > RTD|      0.072|      0.785|     19.712|       2|     0|     -0.177|    131.284
>  > RTD|      0.096|      2.280|     15.701|       2|     0|     -0.177|    131.284
>  > RTD|      0.059|      1.573|     12.868|       2|     0|     -0.177|    131.284
>  > RTD|      0.058|      2.512|     25.545|       2|     0|     -0.177|    131.284
>  > RTD|      0.286|      1.928|    153.611|       3|     0|     -0.177|    153.611
>  > RTD|      0.285|      2.834|     17.032|       3|     0|     -0.177|    153.611
>  > RTD|      0.128|      2.104|     26.467|       3|     0|     -0.177|    153.611
>  > RTD|      0.140|      1.105|     14.978|       3|     0|     -0.177|    153.611
>  > RTD|      0.163|      0.950|     12.708|       3|     0|     -0.177|    153.611
>  > RTD|      0.199|      1.012|     15.109|       3|     0|     -0.177|    153.611
>  > RTD|      0.042|      1.007|     10.511|       3|     0|     -0.177|    153.611
>  > RTD|      0.102|      0.763|    125.684|       4|     0|     -0.177|    153.611
>  > RTD|      0.138|      0.810|     12.226|       4|     0|     -0.177|    153.611
>  > RTD|      0.125|      1.312|     13.858|       4|     0|     -0.177|    153.611
>  > RTD|      0.256|      0.854|     67.039|       4|     0|     -0.177|    153.611
>  > RTD|      0.280|      0.841|     14.205|       4|     0|     -0.177|    153.611
>  > RTD|      0.099|      0.631|     76.185|       4|     0|     -0.177|    153.611
>  > RTD|      0.230|      0.953|     16.041|       4|     0|     -0.177|    153.611
>  > RTD|      0.086|      0.985|     65.416|       4|     0|     -0.177|    153.611
>  > RTD|      0.110|      0.856|     18.357|       4|     0|     -0.177|    153.611
>  > 
> /************************************************************************************/
>  >
> Yeah, these numbers are still off. Likely, we see some power management effects.
> They might be triggered by Linux, and then some kernel switch can do the magic
> (check e.g. CONFIG_ACPI_PROCESSOR_CSTATE). You may also try "idle=poll" as
> kernel parameter. Or the issue is caused by the firmware (bios). Check power
> settings there. In the worst case, the behaviour is SMI induced and can't be
> disabled. Then only a different firmware can help - or a different hardware.
> Jan
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

