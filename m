Message-ID: <4F50E653.4010308@domain.hid>
Date: Fri, 02 Mar 2012 16:25:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACa6icBt=zxzMCUveFt+E4AUDRyxhxKiOzy8wtyrtDO9MfojNg@domain.hid>
In-Reply-To: <CACa6icBt=zxzMCUveFt+E4AUDRyxhxKiOzy8wtyrtDO9MfojNg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ABI
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Utsav Patel <utsav6888@domain.hid>
Cc: xenomai@xenomai.org

On 03/02/2012 03:56 PM, Utsav Patel wrote:
>  While running the program, I am getting this.
> 
> ceems@domain.hid$ ./hello
> Xenomai: incompatible ABI revision level
> (needed=1, current=4).
> 
> Can any one tell me what this means? What should I do?

You get this error when mixing xenomai user-space support dans
kernel-space support from different branches. For instance xenomai
kernel-space version from branch 2.5 with xenomai user-space support
from branch 2.6.

What you should do is compile xenomai kernel-space and user-space using
sources in the same branch.

Another possible explanation is that you are using gcc 4.6 on x86. And
in that case, you should add "-fno-omit-frame-pointer" to the CFLAGS you
pass to xenomai user-space configure script.

-- 
					    Gilles.

