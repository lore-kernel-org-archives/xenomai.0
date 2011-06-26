Message-ID: <4E074D6D.8070606@domain.hid>
Date: Sun, 26 Jun 2011 17:17:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTim0Maz-yjXtG90j-=RtLCesRE=hCg@domain.hid>	<4E04C614.6000101@domain.hid>
	<4E06A4B7.2050906@domain.hid>
In-Reply-To: <4E06A4B7.2050906@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] more questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Wiebe <dwiebe2@domain.hid>
Cc: xenomai@xenomai.org

On 06/26/2011 05:17 AM, David Wiebe wrote:
> Hello,
> 
> I have kernel 2.6.35.9 patched with xenomai for arm(beagleboard xm).
> 
> #1. rt_dev_ioctl as replacement for ioctl. My test program compiles, 
> runs but does not perform as it should. If I change rt_dev_ioctl back to 
> ioctl, everything works fine. What might I be missing?

Hi,

We do not know
- which ioctl you are trying to use
- which driver you have written/loaded to implement this ioctl
- what you mean by "my program does not perform as it should", what is
the return value of this rt_dev_ioctl which is supposed to work?

> 
> #2. rtnet. I wrote a test snippet of code to test the ethernet part. 
> Prepended the appropriate functions with rt_dev_ and same results as in #1.
> 
> I assume that if something wasn't in the library I would get compiler 
> errors and if the code running on the beagleboard  was bad, I would get 
> run time errors. I have seen neither.

Again, what driver are you trying to use? What happens when you try and
configure it?

> 
> Are there any books or more learning materials out there for me to 
> study? Any and all feedback appreciated.

I would suggest starting with "Linux device drivers", it would give you
an idea of how things are divided between drivers and applications.
xenomai follows the same division. Then you can read the documents
listed here:
http://www.xenomai.org/index.php/Included_documentation_summary
and here:
http://www.xenomai.org/index.php/Publications

To have a better idea on how to work with xenomai.
> 
> David
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
                                                                Gilles.

