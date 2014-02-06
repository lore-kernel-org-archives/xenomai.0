Message-ID: <52F3DBDB.4060805@xenomai.org>
Date: Thu, 06 Feb 2014 20:00:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
In-Reply-To: <52F3C5DD.8010208@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 02/06/2014 06:26 PM, Philippe Gerum wrote:
>> Every 2.0s: cat /proc/xenomai/stat                      Sat Jan  1
>> 00:09:03 2000
>>
>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>     0  0      0          186436     0     00500080   94.2  ROOT/0
>>     0  2882   16         427        0     00300380    0.0  MAIN
>>     0  2883   0          54128      0     00300184    1.0 onemsscheduler
>>     0  2884   0          542        0     00300184    0.0  FREE
>>     0  2885   0          1499       0     00300184    0.0  flsh
>>     0  2886   0          1          0     00300182    0.0  EWRN
>>     0  2887   0          45158      0     00300186    0.8  EEDT
>>     0  2888   0          53921      0     00300184    1.4  RESP
>>     0  2889   1          1          0     00300380    0.0  SERV
>>     0  2890   0          10784      0     00300184    0.4  CMND
>>     0  2891   2          1370       0     00300186    0.1  SERP
>>     0  2896   0          53080      0     00300184    0.8  SERO
>>     0  2899   0          536        0     00300186    0.0  CANP
>>     0  2900   0          1          0     00300182    0.0  CANG
>>     0  2901   0          1          0     00300182    0.0  CANE
>>     0  2902   0          315        0     00300182    0.0  CANT
>>     0  2903   1          1          0     00300380    0.0  CNMN
>>     0  2904   236        628        0     00300184    0.0  CIOW
>>     0  0      0          699350     0     00000000    1.0  IRQ83: [timer]
>>
>>
>> So questions are:
>>
>> - Why does the %CPU under xenomai/stat not reflect whats reported by top
>
> Because top reports the CPU consumed when Linux is active, which
> excludes Xenomai activity.
>
>> (where is the 40% going)?
>
> Good question.

I think we have a known issue: the registers passed to Linux timer tick 
are the ones of the last timer tick, which may very well happen to 
always hit the same task. Could this be the cause?

Is the MAIN task the one which does the tm_wkafter ?

Is the hardware timer of the beaglebone black shared with Linux (like 
omap4) or do linux and xenomai have different timers (like omap3)?

Could you arm the T_WARNSW bit to see if the MAIN task experiences mode 
switches?

-- 
					    Gilles.

