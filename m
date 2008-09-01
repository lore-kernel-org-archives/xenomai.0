Message-ID: <48BBECD6.8020008@domain.hid>
Date: Mon, 01 Sep 2008 15:23:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270809010608m4b9bf58ej9e63f2784e61bae4@domain.hid>
In-Reply-To: <2b490f270809010608m4b9bf58ej9e63f2784e61bae4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compile and run problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> Hi,
> 
> I'm having trouble compiling a code fragment. After running the makefile, I
> try to run the program wich then gives the the following error?
> 
> dehann:/home/dehann/workspace/rtPP_AD# make
> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -L/usr/xenomai/lib -lpthread -lnative main.o -o main -lm
> dehann:/home/dehann/workspace/rtPP_AD# ./main
> ./main: error while loading shared libraries: libnative.so.1: cannot open
> shared object file: No such file or directory
> 
> the libnative.so.1 file is in the /usr/xenomai/ directory. Thanks in
> advance!

There are several ways out:
- use ld -rpath option (see ld manual);
- use the LD_LIBRARY_PATH environment variable;
- add /usr/xenomai to /etc/ld.so.conf and re-run ldconfig.

-- 
                                                 Gilles.

