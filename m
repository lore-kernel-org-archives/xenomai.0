Message-ID: <4542341D.5080805@domain.hid>
Date: Fri, 27 Oct 2006 11:30:21 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <450B2BE1.1050105@domain.hid>		<20060916042719.M57867@domain.hid>	<450F0451.8070102@domain.hid>	<1158614598.5009.71.camel@domain.hid>	<453FC279.8040608@domain.hid>
	<453FC819.9020900@domain.hid> <453FF54D.5030704@domain.hid>
In-Reply-To: <453FF54D.5030704@domain.hid>
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

Jeff Webb wrote:
> Jan Kiszka wrote:
>> Jeff Webb wrote:
>>> If I run the attached program, I get the following result:
>>>
>>>  [root]# ./mqtest2
>>>  CPU time limit exceeded
>>>
>>> The kernel log contains:
>>>
>>>  Oct 25 14:13:03 kernel: invalid use of FPU in Xenomai context at 
>>> 0x80492f6
>>
>> Could you also try if this patch changes anything:
>>
>> https://mail.gna.org/public/xenomai-core/2006-10/msg00069.html
>>
>> (Could be the case if you happen to use some FPU-touching Linux driver.)
> 
> The patch would not apply to xenomai 2.2.4, so I checked out the svn 
> trunk (rev 1749), and then applied this patch.  I get the same behavior.

I tried my mqtest2 example with a stock xenomai 2.2.4 UP kernel (instead of SMP), and I still get the FPU error message and SIGXCPU signal.  I also went back to xenomai 2.2.1 SMP and still have the problem there.

Has anyone tried the example on some other hardware?

-Jeff

