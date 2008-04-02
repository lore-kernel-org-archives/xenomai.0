Message-ID: <47F3CD1D.1040907@domain.hid>
Date: Wed, 02 Apr 2008 14:14:53 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid> <47F17B32.7070505@domain.hid>	
	<18417.52630.8850.939898@domain.hid>	
	<47F23E9E.7060801@domain.hid>	
	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>	
	<47F258AD.3000103@domain.hid>	
	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>	
	<47F2A7CC.4050301@domain.hid>	
	<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>	
	<47F3A00E.1020700@domain.hid>
	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>
In-Reply-To: <2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>


Hmm, I checked again and did not find a mistake in the experiment 
(neither using the old binary nor old sources). I'm doing a clean build 
from scratch again, so that we can be absolutely sure. I can then run 
memtest on the machine...

Tomas

Gilles Chanteperdrix wrote:
> On Wed, Apr 2, 2008 at 5:02 PM, Tomas Kalibera <kalibera@domain.hid> wrote:
>   
>>  OK, no change with this patch compared to the previous situation. The
>> system boots, but hangs without a stacktrace when I run my Xenomai task.
>> SysRq is blocked, now even SysRq-kill did not work, only SysRq-boot did.
>>     
>
> Are you sure you did not keep the stuff in highmem_32.c ?
>
>
>   


