Message-ID: <4AF15C82.8050804@domain.hid>
Date: Wed, 04 Nov 2009 11:50:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
	<C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
In-Reply-To: <C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] bring down the system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <pastor@domain.hid>

Stefan Schaal wrote:
> Sorry, I attached the wrong C-program in the previous posting ....  
> here is the corrected version:
> 
> Hi,
> 
>   attached is a little C program that spawns off a task which runs a  
> heavy tiny math job. Despite my 8 processor machine, taking this one  
> task to 99% CPU load slows down the entire computer, often such that  
> there is no return except for a forced restart.
> 
> I run the xenomai-head git, updated on Oct. 29 the last time, on a  
> i386 ubuntu system with kernel 2.6.29.5.
> 
> Does anybody know what is going wrong here, i.e., am I not permitted  
> to take my CPUs to the max load?

No, you can not do that. When a Xenomai task runs, Linux does not, and
for your system to work correctly, Linux should run from time to time,
so, the typical Xenomai setup is a periodic task which wakes up, does
some job, and goes back to sleep, leaving some time for linux to run.

-- 
                                          Gilles


