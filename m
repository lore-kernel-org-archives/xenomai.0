Message-ID: <489D9DAA.1050902@domain.hid>
Date: Sat, 09 Aug 2008 15:37:46 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <489C96FA.7050400@domain.hid>
In-Reply-To: <489C96FA.7050400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel user-space problem running
	testsuite
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

FYI, with the ELDK the following command already works:

   ./configure --host=ppc-linux --prefix=/usr/local/xenomai

Wolfgang.

