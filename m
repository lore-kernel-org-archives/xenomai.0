Message-ID: <497F436E.3080907@domain.hid>
Date: Tue, 27 Jan 2009 17:25:02 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <57e813c90901270847o6907862areb78f7713e8255e6@domain.hid>
	<57e813c90901270918g1b74cd6ev7698e0717647c0d9@domain.hid>
In-Reply-To: <57e813c90901270918g1b74cd6ev7698e0717647c0d9@domain.hid>
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
> Running the test suite on the ARM board results on the message:
> 
>  error while loading shared libraries: librt.so.1: cannot open shared object
> file: No such file or directory
> 
> I cannot find librt.so in any directory of the compiled kernel or the user
> space. Am I missing something?

It is part of the glibc, so should be installed by whatever you use to
generate your root file system. If you do not compile glibc, you will
find it in the toolchain directories.

-- 
                                                 Gilles.

