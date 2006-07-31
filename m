MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17614.7196.329385.212915@domain.hid>
Date: Mon, 31 Jul 2006 17:05:00 +0200
Subject: Re: [Xenomai-help] configuration scripts doesn't work
In-Reply-To: <e325d110607310723r18eec657vf1e9bd6d7fdde2a5@domain.hid>
References: <e325d110607310304pac72cf3pad25cec643be0edf@domain.hid>
	<17613.60695.176599.493100@domain.hid>
	<e325d110607310723r18eec657vf1e9bd6d7fdde2a5@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > Hi Gilles,
 > 
 > The error message i get when try to run the latency test program..
 > warming up...
 > latency: failed to set periodic, code -110
 > 
 > The message you got initially told you that a discrepancy between the
 > CPU selected at kernel level and the user-support has been detected.
 > To fix this, you need to select a x86 CPU supporting a timestamp
 > counter when configuring your kernel, since by default, the configure
 > script assumes --enable-x86-tsc.
 > 
 > 
 > May i know what does it mean by "x86 CPU supporting a timestamp
 > counter when configuring your kernel"?

When configuring your kernel, in the menu "Processor type and features",
select a CPU that supports the rdtsc instruction. That is, "pentium
classic" or anything better. In order to know if you have selected a CPU
that supports the rdtsc instruction, look for CONFIG_X86_TSC in the
.config file.
Alternatively, if the CPU you use really does not support the rdtsc
instruction, when you configure xenomai, pass the --disable-x86-tsc
flag.

-- 


					    Gilles Chanteperdrix.

