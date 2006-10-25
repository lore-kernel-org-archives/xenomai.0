Message-ID: <453FF54D.5030704@domain.hid>
Date: Wed, 25 Oct 2006 18:37:49 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <450B2BE1.1050105@domain.hid>	
	<20060916042719.M57867@domain.hid>	<450F0451.8070102@domain.hid>
	<1158614598.5009.71.camel@domain.hid>
	<453FC279.8040608@domain.hid> <453FC819.9020900@domain.hid>
In-Reply-To: <453FC819.9020900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Jeff Webb wrote:
>> If I run the attached program, I get the following result:
>>
>>  [root]# ./mqtest2
>>  CPU time limit exceeded
>>
>> The kernel log contains:
>>
>>  Oct 25 14:13:03 kernel: invalid use of FPU in Xenomai context at 0x80492f6
> 
> Could you also try if this patch changes anything:
> 
> https://mail.gna.org/public/xenomai-core/2006-10/msg00069.html
> 
> (Could be the case if you happen to use some FPU-touching Linux driver.)

The patch would not apply to xenomai 2.2.4, so I checked out the svn trunk (rev 1749), and then applied this patch.  I get the same behavior.

Thanks,

-Jeff


