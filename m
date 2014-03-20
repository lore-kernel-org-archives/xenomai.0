MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Date: Thu, 20 Mar 2014 15:04:34 +0000
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <1395322305.1566.YahooMailNeo@web163504.mail.gq1.yahoo.com>
References: <4C58E39DE6620348B85D78E601C268AF437ABD@srv-exchang2-mi.jerviswebb.com>, 
 <201402142329.10853.paul_c@tuxcnc.org>
 <4C58E39DE6620348B85D78E601C268AF438358@srv-exchang2-mi.jerviswebb.com>
 <1392655777.26562.YahooMailNeo@web163503.mail.gq1.yahoo.com>
 <53026F63.5080403@grandegger.com>
 <1392760838.41780.YahooMailNeo@web163505.mail.gq1.yahoo.com>
 <d3241e64b0ad1946aaa3952553fe354f@grandegger.com>
 <1392847535.52577.YahooMailNeo@web163501.mail.gq1.yahoo.com>
 <3a692b55821a5a04d7b55253388edeaf@grandegger.com>
 <1395322305.1566.YahooMailNeo@web163504.mail.gq1.yahoo.com>
Message-ID: <1369ea7dd64955631e1c5ed5bf3c573f@grandegger.com>
Subject: Re: [Xenomai] CAN ISA support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Ross <mr_trekkie@yahoo.com>
Cc: xenomai@xenomai.org

On Thu, 20 Mar 2014 06:31:45 -0700 (PDT), Wayne Ross
<mr_trekkie@yahoo.com> wrote:
> On Thursday, February 20, 2014 2:47 AM Wolfgang Grandegger wrote:
>> Am Mi, 19.02.2014, 23:05 schrieb Wayne Ross:
>>> On Wednesday, February 19, 2014 3:16 AM Wolfgang Grandegger wrote:
>>>> Am Di, 18.02.2014, 23:00 schrieb Wayne Ross:
>>>>> On Monday, February 17, 2014 3:21 PM, Wolfgang Grandegger
>>>>> <wg@grandegger.com> wrote:
> ...
>>>>> dmesg shows new activity: 
> 
>>>>> rtcan0: real bitrate 250000, sampling point 87.5%
>>>>> rtcan_sja_set_bit_time: btr0=0x1 btr1=0x1c
>>>>> rtcan1: real bitrate 250000, sampling point 87.5%
>>>>> rtcan_sja_set_bit_time: btr0=0x1 btr1=0x9c
>>>>
>>>> That's strange. "btr1" should here be "0x1c" as well.
>>>>
>>> *Most* times I start after boot, BOTH report btr1=0x9c...
>>> One boot I saw the values swapped.
>>
>> That's wired == not OK! btr1 should always be "0x1c".
>>
>> Wolfgang.
>  
> Researching
> this some more, I *think* I have tracked down this behavior to an
> uninitialized variable in the file ksrc/drivers/can/rtcan_raw_dev.c,
> routine
> rtcan_cal_bit_time(): this function is called by rtcan_ioctl_dev_set(),
> passing a can_bittime pointer.  At the end of rtcan_calc_bit_time, 5
> members of that structure (bt) are filled out, not touching 1 value
(sam,
> a single bit) leaving it uninitialized.  I don't see any
> initialization of that structure in the calling routine either. 
> 
> 
> I
> see the alternate Kernel configuration of
> CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD earlier in the file always sets
> this
> value to 0.
> 
>  I
> cannot see any reason to have this value unset for the STD
> calculation. 
> 
> include/rtdm/rtcan.h describes this bit as "enable triple sampling",
which
> is probably available
> for a custom timing. 
> 
> So, I
> propose the following change:
> diff --git a/ksrc/drivers/can/rtcan_raw_dev.c
> b/ksrc/drivers/can/rtcan_raw_dev.c
> index c5fd1b6..d305bab 100644
> --- a/ksrc/drivers/can/rtcan_raw_dev.c
> +++ b/ksrc/drivers/can/rtcan_raw_dev.c
> @@ -219,6 +219,7 @@ static int rtcan_calc_bit_time(struct rtcan_device
> *dev,
>      bt->phase_seg1 = tseg1 - bt->prop_seg;
>      bt->phase_seg2 = tseg2;
>      bt->sjw = 1;
> +    bt->sam = 0;
>      bt->brp = best_brp;
>  
>      /* real bit-rate */
> 
>

Acked-by: Wolfgang Grandegger <wg@grandegger.com>
 
> With this change I have confirmed rtcanconfig *always* yields the *same*
> result for btr1 (0x1c):
> rtcan0: real bitrate 250000, sampling point 87.5%
> rtcan_sja_set_bit_time: btr0=0x1 btr1=0x1c

Good catch!

Thanks,

Wolfgang.


