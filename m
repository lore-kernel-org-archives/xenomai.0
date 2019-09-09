Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mlJlOiBYZW5vbWFpIGxhdGVuY3kgdGVzdCBub3Qg?=
 =?UTF-8?Q?good?=
References: <20190909101439.9449F16600E9@webmail.sinamail.sina.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4fe2fcea-a86f-1d0e-996b-62d44aa2d2ac@siemens.com>
Date: Mon, 9 Sep 2019 13:19:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190909101439.9449F16600E9@webmail.sinamail.sina.com.cn>
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

On 09.09.19 12:14, 鲁克文 wrote:
> Dear Jan Kiszka:
> 
> I re-enable ACPI_PROCESSOR in the kernel, but also the latency test seems no 
> good,attached file is the new kernel config file.
> 
> /*********************************************************************************************/
> RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|      0.072|      0.785|     19.712|       2|     0|     -0.177|    131.284
> RTD|      0.096|      2.280|     15.701|       2|     0|     -0.177|    131.284
> RTD|      0.059|      1.573|     12.868|       2|     0|     -0.177|    131.284
> RTD|      0.058|      2.512|     25.545|       2|     0|     -0.177|    131.284
> RTD|      0.286|      1.928|    153.611|       3|     0|     -0.177|    153.611
> RTD|      0.285|      2.834|     17.032|       3|     0|     -0.177|    153.611
> RTD|      0.128|      2.104|     26.467|       3|     0|     -0.177|    153.611
> RTD|      0.140|      1.105|     14.978|       3|     0|     -0.177|    153.611
> RTD|      0.163|      0.950|     12.708|       3|     0|     -0.177|    153.611
> RTD|      0.199|      1.012|     15.109|       3|     0|     -0.177|    153.611
> RTD|      0.042|      1.007|     10.511|       3|     0|     -0.177|    153.611
> RTD|      0.102|      0.763|    125.684|       4|     0|     -0.177|    153.611
> RTD|      0.138|      0.810|     12.226|       4|     0|     -0.177|    153.611
> RTD|      0.125|      1.312|     13.858|       4|     0|     -0.177|    153.611
> RTD|      0.256|      0.854|     67.039|       4|     0|     -0.177|    153.611
> RTD|      0.280|      0.841|     14.205|       4|     0|     -0.177|    153.611
> RTD|      0.099|      0.631|     76.185|       4|     0|     -0.177|    153.611
> RTD|      0.230|      0.953|     16.041|       4|     0|     -0.177|    153.611
> RTD|      0.086|      0.985|     65.416|       4|     0|     -0.177|    153.611
> RTD|      0.110|      0.856|     18.357|       4|     0|     -0.177|    153.611
> /************************************************************************************/
> 

Yeah, these numbers are still off. Likely, we see some power management effects. 
They might be triggered by Linux, and then some kernel switch can do the magic 
(check e.g. CONFIG_ACPI_PROCESSOR_CSTATE). You may also try "idle=poll" as 
kernel parameter. Or the issue is caused by the firmware (bios). Check power 
settings there. In the worst case, the behaviour is SMI induced and can't be 
disabled. Then only a different firmware can help - or a different hardware.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

