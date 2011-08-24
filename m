Message-ID: <4E54EAE4.2060705@domain.hid>
Date: Wed, 24 Aug 2011 14:13:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>
In-Reply-To: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Hanging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 08/24/2011 12:51 PM, suresh reddy wrote:
> Dear all,
> 
> Iam trying to communicate two process using message . In one process i
> called a dummy function (doing nothing except printing something for 2000
> times) .
> 
> Iam trying to calculate the time elapsed for this process to process
> communication .
> 
> 1. The program working fine if i print or execute something for once  like
> rt_printf("xenomai"); But if i used
> 
> for (i=0; i<2000; i++)
> 
> {
> 
> rt_printf("xenomai");
> 
> }
> 
> if i used like this the execution stops after printing for some 100 times or
> so on my Pandaboard.  Please find the attached program.

Are you sure you are not simply filling rt_printf buffer and never
leaving primary mode?

-- 
					    Gilles.

