Message-ID: <520E5DEC.5040701@xenomai.org>
Date: Fri, 16 Aug 2013 19:14:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOE4DFXejcAkoFN=HOrMRg6qH=+K1EZGqzoTzTmdnnySk4u_Gw@mail.gmail.com>
In-Reply-To: <CAOE4DFXejcAkoFN=HOrMRg6qH=+K1EZGqzoTzTmdnnySk4u_Gw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai for wandboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohammadreza Babaee <mrezababaee@gmail.com>
Cc: xenomai@xenomai.org

Le 16/08/2013 17:12, Mohammadreza Babaee a écrit :
> Hello Colleagues,
> 
> I got a wandboard with free scale imx6q and want to have a xenomai based
> real time Linux running on. I have also a real-time Linux patches with
> xenomai that can be compiled for Imx6q Sabre lite. But I can not build
> the kernel image for wandboard. I use wandbioard_defconfig but get
> errors. Is xenomai dependednt on board?
> 
> I appreciate it for any help!

Please first try compiling the kernel without Xenomai or the I-pipe
patch. Then try:
- compiling with the I-pipe patch, but without CONFIG_IPIPE
- compiling with the I-pipe patch, with CONFIG_IPIPE enabled
- run xenomai prepare-kernel script and compile with CONFIG_XENOMAI enabled.

If the first step fails, then your problem is not with Xenomai, if
another step fails, please post here the exact error message, indicating
which version of the Linux kernel, the I-pipe patch and Xenomai you are
trying to use.

Regards.


-- 
Gilles.

