Message-ID: <51854E48.9010609@xenomai.org>
Date: Sat, 04 May 2013 20:07:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
	<5184483E.1050305@xenomai.org>
	<8A7AED52-BB19-44B2-B1FE-B1E7FBE84915@mah.priv.at>
	<51850F84.6090204@xenomai.org>
	<C24A4431-BF7F-46A6-B6B7-D90DFA27444A@mah.priv.at>
In-Reply-To: <C24A4431-BF7F-46A6-B6B7-D90DFA27444A@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.8.10 beaglebone failure: any clues I missed?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/04/2013 04:30 PM, Michael Haberler wrote:

> 
> Am 04.05.2013 um 15:39 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> 
>> On 05/04/2013 08:04 AM, Michael Haberler wrote:
>>
>>> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>>> (modprobe xeno_native?)
>>
>>
>> See:
>> http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_xenomai_native_skin_or_config_xeno_opt_pervasive_disabled
> 
> I went through that before posting,  and found no clue hinting to the above, see below;
> 
> on my first attempt, I managed to start from branch am33x-v3.2 instead from tag 3.8.10-bone15, so failure was obvious but thats fixed
> 
> is there a requirement the patch files need to reside in xenomai-2.6/arch/arm/patches/* before doing scripts/prepare-kernel.sh ?
> 
> still dead sure it's a 'duh' build goof


One possible reason would be that something changed in 3.8.10, for
instance in the system calls handling. But to know that, you would have
to answer the questions I asked you, which you seem not willing to do.

-- 
                                                                Gilles.

