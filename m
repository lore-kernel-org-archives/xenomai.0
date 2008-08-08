Message-ID: <489CA27B.1040201@domain.hid>
Date: Fri, 08 Aug 2008 21:46:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <489C96FA.7050400@domain.hid>
In-Reply-To: <489C96FA.7050400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel user-space problem running
	testsuite
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

Michael Galea wrote:
> I'm just starting with xenomai and am having troubles getting xenomai 
> user space to talk to my kernel.
> 
> I build the kernel and user-space xenomai code and try to run `latency` 
> from the test suite and get
> mpc8360mds:# /usr/local/xenomai/bin/latency
> Xenomai: incompatible feature set
> (required="fastsem", present="nofastsem", missing="fastsem").
> 
> 
> I have built xenomai from svn into my 2.6.26 powerpc kernel and it looks 
>   good on the next boot, i.e. `dmesg |grep xeno -i` returns:
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> 
> The user-space builds and installs over NFS just fine:
> 
> ./configure --host=ppc-unknown-linux-gnu --prefix=/usr/local/xenomai \
>    CC=ppc_6xx-gcc CXX=ppc_6xx-g++ LD=ppc_6xx-ld
> make
> make DESTDIR=/opt/ppcrootmds/ install
> 
> 
> I can't see any fastsem options in the kernel.  Does anyone have any 
> advice?

The trunk/ contains bleeding edge code. The powerpc port there is currently in a
state of flux, due to the introduction of fast user-space mutexes in the Xenomai
nucleus.

Please use the latest stable version such as 2.4.4, or our maintenance branch
instead: http://svn.gna.org/viewcvs/xenomai/branches/v2.4.x/.

-- 
Philippe.

