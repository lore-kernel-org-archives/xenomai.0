Date: Mon, 12 Mar 2007 13:23:50 +0000 (GMT)
From: somshekar kadam <som_kadam@domain.hid>
In-Reply-To: <45E403F9.5060803@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <403615.11286.qm@domain.hid>
Subject: [Xenomai-core] Xenomai on MIPS intial boot
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>


Hi All, 

   I have implelented Xenomai for MIPS , as due to
some legal issues with project completion, I can
submit for Open source. I hope this is understood. 

Initial code is put for mips architecture related. 
There are two issues right now I am facing, throw some
light on this. 

Issue 1 

1) Implementing Xnpod_start_thread, for Mips involves
xnarch_init_thread, I checked other architectures,
what I get it only a stack initilaisation for the new
tthread, correct me if I am wrong, I am not able to
fix other thread_info parametters for this function
only. I have booted the Xenomai without thead creation
able to see Xenomai registered as domain and starting
API services. I am testing the invoking of Syscalls
happening proper, yet to be done to prove services are
working fine. Does anybody have any pointer on this
xnarch_init_thread.

Issue2 

To check the APIS services are implemented , I trying
to create the /usr/xenomai libe for application by
compiling Xenomai by configuring 
./configure --target=mips --host=i386 --enable-shared
CC=mips_fp_be-gcc 
configured properly after this command
then I say make command

it is giving me  "impossible constraint asm"
to create alarm lib for xenomai. 

I made chaanges to support MIPS in configure.in, also
in the config.status to create
include/asm-mips/Makefile, and
iclude/asm-mips/bits/Makefile. 
These file are created and compile it still impossibel
constarint asm error persists.

I even disabled the optimization -O2 option , no
change, I am lost please give any pointers on this. 
is not the proper arch getting the one is it GCC
related bug, I need to check 

Yes I know its long mail. 

Thanks And Regards
Neelu


		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/

