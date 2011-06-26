Message-ID: <4E06A4B7.2050906@domain.hid>
Date: Sat, 25 Jun 2011 20:17:11 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
References: <BANLkTim0Maz-yjXtG90j-=RtLCesRE=hCg@domain.hid>
	<4E04C614.6000101@domain.hid>
In-Reply-To: <4E04C614.6000101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] more questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I have kernel 2.6.35.9 patched with xenomai for arm(beagleboard xm).

#1. rt_dev_ioctl as replacement for ioctl. My test program compiles, 
runs but does not perform as it should. If I change rt_dev_ioctl back to 
ioctl, everything works fine. What might I be missing?

#2. rtnet. I wrote a test snippet of code to test the ethernet part. 
Prepended the appropriate functions with rt_dev_ and same results as in #1.

I assume that if something wasn't in the library I would get compiler 
errors and if the code running on the beagleboard  was bad, I would get 
run time errors. I have seen neither.

Are there any books or more learning materials out there for me to 
study? Any and all feedback appreciated.

David

