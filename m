Message-ID: <498056D5.3080002@domain.hid>
Date: Wed, 28 Jan 2009 13:00:05 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <57e813c90901270847o6907862areb78f7713e8255e6@domain.hid>	
	<57e813c90901270918g1b74cd6ev7698e0717647c0d9@domain.hid>	
	<497F436E.3080907@domain.hid>
	<57e813c90901280452v6761f462kbe342c2142fd5b07@domain.hid>
In-Reply-To: <57e813c90901280452v6761f462kbe342c2142fd5b07@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] librt.so.1 missing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zara Tustra <zarawesome@domain.hid>
Cc: xenomai@xenomai.org

Zara Tustra wrote:
> So if I were to checkout glibc and compile it with the arm-unknown-linux
> toolchain (the same used to compile the rest of the kernel), the resulting
> libraries would be usable? Another person generated the root file system and
> they aren't being very helpful.

To make this work, you have to build the glibc with exactly the same
options and the same version as the one which was used when making the
toolchain. So you are probably better off taking the compiled libraries
directly in your toolchain directories.

-- 
                                                 Gilles.

