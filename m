Message-ID: <fb53d5ae99ea75ee7dfcd82b96ffba1f.squirrel@sourcetrek.com>
In-Reply-To: <79A9E4882C44D44FA53B5AB15E6198011385D4A8@ADEERL01SMS001.cznet.zeiss.org>
References: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
 <b692bb78ab6f887dfd41f71655a0a205.squirrel@sourcetrek.com>
 <44y4jq71ku.fsf@be-well.ilk.org>
 <650830a42485b39f0a0443dcb4c5c962.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
 <8f7e2c2ccbb9edd9f8c491ee09d2e096.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D4A8@ADEERL01SMS001.cznet.zeiss.org>
Date: Fri, 12 Jun 2015 15:18:11 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] init failed code -19 on Cyclone V SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Lopes, Alexandre wrote:
>> -----Ursprüngliche Nachricht-----
>> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Gesendet: Donnerstag, 11. Juni 2015 19:35
>> An: Lopes, Alexandre
>> Cc: Gilles Chanteperdrix; Lowell Gilbert; xenomai@xenomai.org
>> Betreff: Re: AW: [Xenomai] init failed code -19 on Cyclone V SoC
>>
>> The Linux mainline code refuses to start the global timer with old
>> revisions of the cortex A9 core which global timer is not exactly the
>> same
>> as with newer revisions (there is a difference in what condition
>> triggers
>> the timer interrupt which make it possible for the old revisions timer
>> to
>> not receive an interrupt if the programmed delay is too short, whereas
>> it
>> can not happen with newer versions). So, the SOCs in mainline based on
>> such old versions do not even bother to declare the global timer
>> registers
>> in the DT.
>>
>
> I see. I've noticed the DTS for the Zynq-7000 does have a node for the
> global timer. Since I believe the Cyclone V and the Zynq-7000 use
> identical
> Cortex A9 revisions, the reason might then be that Altera never pushed for
> it
> (supported by the fact that they don't use it even in their
> vendor-specific
> Kernel, like I replied to Lowell)

Show me the beginning of your kernel boot log, it should allow us to see
what revision of cortex A9 you are using, and verify whether this version
is rejected by the global timer driver. We do not need to "believe" anything
we can verify.


-- 
                    Gilles.


