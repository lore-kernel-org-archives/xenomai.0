Message-ID: <5f46bb1dba9c7e79f348fa9ef0fd13e9.squirrel@sourcetrek.com>
In-Reply-To: <79A9E4882C44D44FA53B5AB15E6198011385D4CE@ADEERL01SMS001.cznet.zeiss.org>
References: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
 <b692bb78ab6f887dfd41f71655a0a205.squirrel@sourcetrek.com>
 <44y4jq71ku.fsf@be-well.ilk.org>
 <650830a42485b39f0a0443dcb4c5c962.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
 <8f7e2c2ccbb9edd9f8c491ee09d2e096.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D4A8@ADEERL01SMS001.cznet.zeiss.org>
 <fb53d5ae99ea75ee7dfcd82b96ffba1f.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D4CE@ADEERL01SMS001.cznet.zeiss.org>
Date: Fri, 12 Jun 2015 15:58:32 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
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
>> Show me the beginning of your kernel boot log, it should allow us to
>> see
>> what revision of cortex A9 you are using, and verify whether this
>> version
>> is rejected by the global timer driver.
>
> Here's the output of /proc/cpuinfo (equally good, I guess)

Well, no, the boot log contains a 32 bits identifier printed in
hexadecimal which is easy to decode...

>
> processor       : 0
> model name      : ARMv7 Processor rev 0 (v7l)
> BogoMIPS        : 1594.16
> Features        : half thumb fastmult vfp edsp thumbee neon vfpv3 tls
> vfpd32
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x3
> CPU part        : 0xc09
> CPU revision    : 0

This seems to be extracted from the same ID, but we no longer see what
comes in what order. So, maybe your core revision is an r3p0, or maybe
not.


>
>
> We do not need to "believe"
>> anything we can verify.
>>
>
> Fair enough, but  I can't verify atm which exact revisions the Zynq-7000
> family uses, and I do know the node is upstream, so unless someone can
> tell me which revisions it uses, I have no other choice.

We do not really care what Zynq use, our concern is with the processor you
use. If indeed it is an r3p0, then the mainline arm global timer should
work with it, since it checks for revisions earlier than r2p0 and you can
submit the DT patch (not forgetting the information about irq, necessary
to use the timer) to the mainline kernel.

-- 
                    Gilles.


