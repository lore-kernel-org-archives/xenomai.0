Message-ID: <4F0E12FA.8030606@domain.hid>
Date: Wed, 11 Jan 2012 23:53:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+fRa6cOs0iz37X8VKFPawXLDV4cDb5=u21FgS7JSP3dSmc+FQ@mail.gmail.com>
In-Reply-To: <CA+fRa6cOs0iz37X8VKFPawXLDV4cDb5=u21FgS7JSP3dSmc+FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] troubles with library inclusion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: daniele.gottfried@domain.hid
Cc: xenomai@xenomai.org, Daniele <danielegottfried@domain.hid>

On 01/11/2012 11:49 PM, Daniele wrote:
> Hello,
> 
> We are trying to use xenomai with analogy library
> 
> [xenomai 2.6.0, kernel 2.6.38.8]
> 
> Compiling the program  we got the following error:
> 
> 
> "undefined reference to
> a4l_open<http://www.xenomai.org/documentation/trunk/html/api/group__descriptor1__lib.html#ga810401871fe8005ee0157c6910f94466>
> "
> 
> The compiler detects correctly the function prototypes but it can't found
> their complete definition.
> 
> taking care of our MakeFile we also have read this:
> 
> https://mail.gna.org/public/xenomai-help/2011-07/msg00036.html
> 
> but we noticed that our makefile already contains this instructions for our
> skin, native.
> 
> How could we get rid of this?

You need to link with the libanalogy driver, so, simply add "-lanalogy"
on the compiler command line.

-- 
                                                                Gilles.

