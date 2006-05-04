Message-ID: <44597738.3060204@domain.hid>
Date: Wed, 03 May 2006 23:38:32 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Which kernel features to enable/disable?
References: <44589A3E.3020802@domain.hid>
In-Reply-To: <44589A3E.3020802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

Sean McGranaghan wrote:
> Hello all,
>
> I am configuring a new PC for Xenomai 2.1 with a 2.6.16 kernel. In the 
> past I have always used a vanilla kernel in the default configuration. 
> I was wondering what features are recommended to enable or disable in 
> the default kernel configuration? For example I know to enable the SMI 
> workaround if the chipset supports it.
>
> What about SMP?
> Kernel pre-emption?
> Power management ACPI/APM/frequency scaling?
>

for more on config options to avoid, see

http://svn.gna.org/viewcvs/xenomai/trunk/TROUBLESHOOTING?rev=957&view=markup



