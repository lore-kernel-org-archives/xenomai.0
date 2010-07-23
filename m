Message-ID: <4C492A81.5030201@domain.hid>
Date: Fri, 23 Jul 2010 07:37:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
	<4C47597F.1010406@domain.hid>
	<4C478313.2030606@domain.hid>
	<4C48C1BB.8080606@domain.hid> <4C48C2CE.1030706@domain.hid>
	<4C48D539.8040406@domain.hid> <4C48D5BD.6000207@domain.hid>
	<4C48E443.3040909@domain.hid>
In-Reply-To: <4C48E443.3040909@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system - correction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   I guess that I need to buy a new build server. My turn around time on 
> a new kernel is about 2 hours. (1.1 GHz Athelon 1.5 GB RAM 1-core)
> It's fine for compiling my applications and drivers. I hadn't planned on 
> building multiple kernels per day.

That is because you restart building the kernel from scratch every time.
If, on the other hand, you only re-run make in the kernel build-tree
after having changed a few files in the source tree under git control,
the kernel build system will only re-build those files which have
changed. And I guess you mean an x86 kernel, because an ARM kernel
usually has far less options than an x86 kernel and is really fast to
compile.

If you want to be able to debug Linux kernel issues, you can not keep a
turn around time of 2 hours.

-- 
					    Gilles.

