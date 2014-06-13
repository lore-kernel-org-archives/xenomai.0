Message-ID: <539AC5E5.6050503@xenomai.org>
Date: Fri, 13 Jun 2014 11:35:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMbo_3DjWPb2xt27WAR6MF6bLHf-QZM-n-VduNTugx34cQ0LPg@mail.gmail.com>
 <536DF390.9000604@xenomai.org> <536E1962.30008@xenomai.org>
 <CAMbo_3Av1qCUpXk1osvwczvu5OtCzyge3wxSgsfbOZcYq786uw@mail.gmail.com>
 <536F796F.7070007@xenomai.org> <539182C0.5090405@control.lth.se>
In-Reply-To: <539182C0.5090405@control.lth.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on v3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>, Brian Morel <brianmorel99@gmail.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 06/06/2014 10:58 AM, Anders Blomdell wrote:
> 
> 
> On 2014-05-11 15:21, Gilles Chanteperdrix wrote:
>> On 05/11/2014 02:07 AM, Brian Morel wrote:
>>> I cloned the ipipe.git repository & checked out ipipe-3.14 .  I tried
>>> running the genpatches.sh script, but it appears that tag v3.14 doesn't
>>> exist in the repository.  I tried the same process for 3.8 & it worked
>>> fine.  I assume this is because the stable tree isn't there, but my git foo
>>> isn't good, so I don't know how to add it.  Any advice would be great.
>>
>> Note that you can work directly with the ipipe git instead of generating
>> patches, simply run prepare-kernel.sh from the ipipe git,
>> prepare-kernel.sh will detect that the kernel already contains the ipipe
>> bits and will not try and apply an I-pipe patch. This makes testing
>> changes to the I-pipe kernel a lot easier.
>>
>>
> Is this a reasonable patch if one (still) wants to use genpatches.sh?
> 
> diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
> index 489ae6c..fe9eb0e3 100755
> --- a/scripts/ipipe/genpatches.sh
> +++ b/scripts/ipipe/genpatches.sh
> @@ -62,6 +62,8 @@ BEGIN {
>      driver_arch["clk/mxs/clk-imx28.c"]="arm"
>      driver_arch["clocksource/arm_arch_timer.c"]="arm"
>      driver_arch["clocksource/mxs_timer.c"]="arm"
> +    driver_arch["dma/edma.c"]="arm"
> +    driver_arch["gpio/gpio-davinci.c"]="arm"
>      driver_arch["gpio/gpio-mxc.c"]="arm"
>      driver_arch["gpio/gpio-mxs.c"]="arm"
> 

Yes, merged, thanks.

-- 
                                                                Gilles.

