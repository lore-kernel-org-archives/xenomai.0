MIME-Version: 1.0
Sender: dothemango@domain.hid
Date: Fri, 29 Apr 2011 11:24:42 +0200
Message-ID: <BANLkTi=T7CtZUhLzbU2bz4Z8Ph=N=_Bs=g@domain.hid>
From: martin mangard <martin@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] dlopen of libnative fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I installed xenomai Version 2.5.6 on a x86 machine. I use dlopen in
order to use the xenomai libraries.


    hXenomai=dlopen("/usr/lib/libxenocalls-2.5.6.so",RTLD_NOW);
    if(!hXenomai)
	{
        fprintf (stderr, "%s\n", dlerror());
        fflush(stderr);
	}


dlopen aborts with the error: "/usr/lib/libnative.so.3: undefined
symbol: xeno_current_mode_key"

I configured xenomai with the option " --enable-dlopen-skins "

What do I have to change in order be able to dlopen the libnative.so.3 library?

Martin

