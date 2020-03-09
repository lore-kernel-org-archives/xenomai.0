Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <d36eca04d68b4434bde75d9cfa8c1418@RCDC-MAIL09.corp.diehl.com>
 <f7fc8190-afe3-872e-d7aa-dcabcd576a77@siemens.com>
 <ee2bea74fc5b40af8fbc9cff17c9bd78@RCDC-MAIL09.corp.diehl.com>
 <CAFLxGvyxyfU0_F+mqymZg1d+X_Rzw9=LoZQAXuF5J8skR8n2Xg@mail.gmail.com>
 <6b399d7610174bb585e2fb439d735402@RCDC-MAIL09.corp.diehl.com>
 <8f7a0986-8549-fd2c-f49b-65595f9a1d16@siemens.com>
 <77fa7cc8d0a54c03b41a8fcadd786a8f@RCDC-MAIL09.corp.diehl.com>
 <857866991.69963.1583406441558.JavaMail.zimbra@nod.at>
 <86a30c2cabca45439f0ed4c2bd6fb9fc@RCDC-MAIL09.corp.diehl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <40d1f688-eed6-3c30-edbb-698c594e070f@siemens.com>
Date: Mon, 9 Mar 2020 09:54:33 +0100
MIME-Version: 1.0
In-Reply-To: <86a30c2cabca45439f0ed4c2bd6fb9fc@RCDC-MAIL09.corp.diehl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@xenomai.org>

On 09.03.20 09:26, Carsten EHRMANN wrote:
> Hi ,
> 
> so xeno_rtipc is up now, listed in "lsmod | grep xeno"
> 
> Now I got another error from rt_pipe_create(): -22
> 
> What does this mean?
> Are these errorcodes listed somewhere?
> 

[my 'errno' script]

#!/bin/sh
ERRNO_HEADERS="/usr/include/asm-generic/errno-base.h /usr/include/asm-generic/errno.h"
if [ "$1" = "" ]; then
        ERR="[[:digit:]]+"
else
        ERR=$1
fi
grep -E "[[:space:]]$ERR[[:space:]]/" $ERRNO_HEADERS

With that information, you can check where the function may through 
EINVAL. It's not a common error, though (we may need to document reasons 
for it). Do you get further messages? Try to attach a debugger to find 
out with call in rt_pipe_create (lib/alchemy/pipe.c) returns this code.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

