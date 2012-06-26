Message-ID: <4FE9BDA9.3000209@xenomai.org>
Date: Tue, 26 Jun 2012 15:48:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <009c01cd539e$e9f81420$bde83c60$@com>
In-Reply-To: <009c01cd539e$e9f81420$bde83c60$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

On 06/26/2012 03:23 PM, George Pontis wrote:
> Running Xenomai 2.6.0 on an ARM at91sam9g45. I recently updated from Adeos
> patch adeos-ipipe-3.0.13-arm-1.18-05 to adeos-ipipe-3.0.13-arm-1.18-09. Then
> built a new kernel and gave it to the application developers for a test.
> There were other changes in the root FS and a few tweaks in the kernel, but
> none that looked (to me) like they would affect Xenomai. They report this
> new error:
> 
>> Xenomai: Switching ADC Task to secondary mode after exception #0 from 
>> user-space at 0xffff0fbc (pid 723)
> 
> And then nothing about the app works any more. What does this mean ?

It means there is a fault, when the PC is around 0xffff0fbc, that is in 
the tsc emulation kernel helper. Could you try reverting this commit ?

http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=b79850f3fbd541215d75c1352ad2a4f4d0e8583d;hp=610c6878b23c67daef286f947c59e60f7a204922

-- 
					    Gilles.

