MIME-Version: 1.0
Date: Mon, 29 May 2006 13:24:57 -0700
From: "Nathaniel J Villaume" <villaume@domain.hid>
Message-Id: <1148934297-13365.00013.03267-smmsdV2.1.4@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] shm_open undefined
Reply-To: Nathaniel.J.Villaume@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi, 

I'm trying to create a shared memory region using posix i/f. 
I hijacked the example on the opengroup webpage. My problem is
that when I try to link, there is no shm_open symbol defined in
the libraries xeno has built. (although there is a
__wrap_shm_open in libpthread_rt.a) Which library do I link against?

I believe I have the default xeno configuration in the kernel
.config:
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
CONFIG_XENO_SKIN_VXWORKS=y

Thanks, 

Nate



