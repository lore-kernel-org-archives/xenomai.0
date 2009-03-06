Message-ID: <49B0F731.8040402@domain.hid>
Date: Fri, 06 Mar 2009 11:13:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200903061109.58455.Sergey.Peniaz@domain.hid>
	<49B0ECE9.1050201@domain.hid>
	<200903061210.46156.Sergey.Peniaz@domain.hid>
In-Reply-To: <200903061210.46156.Sergey.Peniaz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is such latency normal?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sergey PENIAZ <Sergey.Peniaz@domain.hid>
Cc: xenomai@xenomai.org

Sergey PENIAZ wrote:
> Thanks for you help. 
> 
>> Also, did you check SMIs?
> Do you mean this?
> 
> testpc:/usr/src/linux-2.6.26.8# cat .config | grep SMI
> # SMI workaround
> # CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
> CONFIG_XENO_HW_SMI_DETECT=y
> # CONFIG_XENO_HW_SMI_WORKAROUND is not set

I mean, did you read the TROUBLESHOOTING guide and applied what you
found there ?

-- 
                                                 Gilles.

