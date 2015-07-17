Message-ID: <55A89B4C.7060008@siemens.com>
Date: Fri, 17 Jul 2015 08:06:04 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <20150702184232.GX13256@hermes.click-hack.org>
 <559587A0.7020005@siemens.com> <20150702185525.GY13256@hermes.click-hack.org>
 <559591E5.5060106@siemens.com> <55959E70.1020407@siemens.com>
 <20150703105149.GZ13256@hermes.click-hack.org>
 <20150703123125.GC13256@hermes.click-hack.org>
 <20150703123829.GD13256@hermes.click-hack.org> <55A7A516.7090005@siemens.com>
 <55A7FB0F.6090105@siemens.com> <20150716223406.GB16778@hermes.click-hack.org>
In-Reply-To: <20150716223406.GB16778@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Remove
 unused mode parameter from COBALT_SYSCALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-07-17 00:34, Gilles Chanteperdrix wrote:
>> To explain the variation from your approach that you will find in my
>> queue now: Letting the script generate two files in one run is very
>> unhandy when defining the Makefile rules. So I now went for a two-stage
>> generation via awk that spits out two different macros the tables
>> can use.
> 
> Looks like nonsense to me. 

That's not necessary.

> 
> foo bar: foo.awk 
> 
> works with GNU make as far as I know
> 

Sure, but foo.awk is called only with foo or bar as target, so you can't
parametrize it and have to hard-code the outputs. Moreover, if running
parallel builds, make can decide to start both target generations at the
same time because it cannot see that running only one will already
magically generate the other.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

