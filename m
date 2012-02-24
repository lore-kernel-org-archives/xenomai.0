Message-ID: <4F4793D3.8010506@domain.hid>
Date: Fri, 24 Feb 2012 14:42:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAH=ipMCyu7Ja2ZvV+vmCYSQsaHOjVjr7xMsyHKjyi2aXiczJSA@mail.gmail.com>
In-Reply-To: <CAH=ipMCyu7Ja2ZvV+vmCYSQsaHOjVjr7xMsyHKjyi2aXiczJSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help: rtdm library linkage error xenomai 2.6.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: teoman cengiz <teoman.ondin@domain.hid>
Cc: xenomai@xenomai.org

On 02/24/2012 02:01 PM, teoman cengiz wrote:
> Hello,
> 
>        My application uses rtdm library but I get weird linkage errors when
> I try to compile the source code. Also I try to compile Xenomai  rtdm
> examples, I get the same error.
> 
>       I use Xenomai 2.6.0, my gcc version is gcc (Ubuntu/Linaro
> 4.6.1-9ubuntu3) 4.6.1.
>       Kernel:  2.6.38.8-xenomai-2.6
> 
>   Error Message:
> 
>   /usr/xenomai/lib/librtdm.so: undefined reference to `xeno_bind_skin_opt'
>  collect2: ld returned 1 exit status
> 
>  What is my fault? Can you help me?

You probably do not use xeno-config to obtain the compilation and link
flags, and you should.

-- 
					    Gilles.

