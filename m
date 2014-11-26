MIME-Version: 1.0
In-Reply-To: <20141126124928.GB5826@sisyphus.hd.free.fr>
References: <CAKJ14NeCDLLd_0_ksJWVw6+qPgBAjU8rWjPcyH9QGCDxXYoeQg@mail.gmail.com>
 <20141126124928.GB5826@sisyphus.hd.free.fr>
Date: Wed, 26 Nov 2014 13:42:56 +0000
Message-ID: <CAKJ14NcjekyGuH_fe1ZD2tG-pVoY-GwOHD4FDpK2VCGiPiaWXQ@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai 2.6.4 on i.MX6 Quad
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,

On Wed, Nov 26, 2014 at 12:49 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, Nov 26, 2014 at 12:38:37PM +0000, Andreas Glatz wrote:
>> However, starting switchtest and latency separately on the console
>> doesn't produce this error. Do you have any clues what is wrong there?
>
> Just read the messages, it is written, write on black:
>> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
>
> This issue is documented in the troubleshooting guide.
>

Sorry, this was too obvious :)

I increased CONFIG_XENO_OPT_SYS_HEAPSZ to 1M and now it works.

Thanks.

A.

------
Load script terminated, terminating checked scripts
---|-----------|-----------|-----------|--------|------|------------------------
         -
RTS|     -0.152|      8.636|     35.277|       0|     0|    00:01:44/00:01:44
RTD|           0|       11180|     1264149
RTD|           1|       12008|     1289543
RTD|           2|       11726|     1297612
RTD|           3|       11178|     1224265
RTT|  00:01:45
RTH|---------cpu|ctx switches|-------total
RTD|           0|         485|       95703
RTD|           1|         276|       95356
RTD|           2|         149|       95367
RTD|           3|         117|       94440

