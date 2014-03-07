Message-ID: <531A239C.7070201@xenomai.org>
Date: Fri, 07 Mar 2014 20:53:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <5319F47D.3080906@xenomai.org>
 <1394221706.80932.YahooMailNeo@web163901.mail.gq1.yahoo.com>
In-Reply-To: <1394221706.80932.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] process behaviour when running xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/07/2014 08:48 PM, Huub Van Niekerk wrote:
> On Friday, March 7, 2014 5:33 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
> On 03/06/2014 10:46 AM, Huub Van Niekerk wrote:
> 
>> Hi,
>> 
>> I'm running Xenomai 2.6.3 with kernel 3.10.18 now on
>> BeagleBoard-Xm Rev. C and experience this behaviour: when I try to
>> install packages from commandline, the installation manager starts
>> quick and reads the package(s), but after that it stays dead quiet
>> like it's frozen. ps -ef shows it's just going on, no defunc or
>> anything like that. Also, when I want to watch the processes using
>> top, it starts, but nothing shows. When I want to end it, Ctl-C
>> gives no response giving me no other option than to use kill. Is
>> this a known behaviour when running Xenomai ?
> 
>> Does the access to SD-card work fine? BeagleBone users have
>> reported an issue with the OMAP SD card controller fixed in the
>> 3.12 kernel by this patch:
> 
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7472bab236bdee1173412585591329e718f4d324
>
>>  Patching the kernel with Xenomai made the bug more likely to
>> happen.
> 
> Don't know if it has anything to do with it, but quite a few write
> actions seem to end in stalling.

I guess this is what you would observe with a rootfs on SD card if the
SD card driver was at fault. In any case, this is not normal, and this
is what you should investigate.

-- 
                                                                Gilles.

