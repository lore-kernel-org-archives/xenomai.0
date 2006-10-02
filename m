Message-ID: <4521A42C.5010203@domain.hid>
Date: Mon, 02 Oct 2006 18:43:40 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] POSIX skin and dynamic libs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

I have a main program that dynamically loads shared library modules using dlopen().  I would like to create a shared library module that is able to spawn a Xenomai RT thread.  This seems  like it should be possible, but I get the following error when loading the module:

IOError: /usr/xenomai/lib/libpthread_rt.so.0: undefined symbol: __real_pthread_getschedparam

This seems to be related to the "-Wl,--wrap" linker flags.  Is there a way to get this to work?  I don't think recompiling the main program is an option, but I can add some code that gets executed before the dynamic library is loaded.

Thanks,

Jeff

