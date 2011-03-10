Message-ID: <4D78C9A9.4030504@domain.hid>
Date: Thu, 10 Mar 2011 13:52:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikA5cMRQbXo5EomU4c4=PjsFk-_pJBLLGbNHKxe@domain.hid>
In-Reply-To: <AANLkTikA5cMRQbXo5EomU4c4=PjsFk-_pJBLLGbNHKxe@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai support for UML
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Douglas Ballman <dougballman@domain.hid>
Cc: xenomai@xenomai.org

Douglas Ballman wrote:
> Hello,

Hi,

> 
> Can Xenomai run inside a User Mode Linux kernel?

No.

> 
> If not, is it technically possible? Is it planned?

It is technically possible, you would have to do an Adeos patch for the
UML kernel. At some point, I had been working with UML, and wanted to do
so, but never did it, I do not think anyone else plans it, because we
have other solutions for simuation:
- a discrete event simulator called xeno-sim, which has unfortunately
become largely unused, so, may be hard to get running for a newcomer;
- running a normal kernel inside qemu, some people actually debug
Xenomai this way.
- if using the posix skin, you can compile your applications as simple
linux applications.

The advantage of using UML over the other solutions is that you could
develop and validate drivers, whereas you have to write some simulation
code (simulating the hardware which driver you are developing) for the
other solutions.

Regards.

-- 
					    Gilles.

