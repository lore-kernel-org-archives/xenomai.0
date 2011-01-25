Message-ID: <4D3E97D5.3050609@domain.hid>
Date: Tue, 25 Jan 2011 10:28:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
> Ok, I'll start a new thread with the details. I'm not so sure if this is actually
> related to Xenomai, but until now I was only able to reproduce it in conjunction with
> xenomai libs, so ...
> 
> The example is already reduced to a minimum. I'm working with a Blackfin-based
> board like BF537-STAMP, with 2010R1-RC5 blackfin-linux-dist on it and stock kernel
> as it comes with the dist (2.6.34.7-ADI-2010R1). Just Xenomai 2.5.3 was replaced
> by 2.5.5.2. Toolchain is 2010R1-RC4 taken as binary from blackfin.uclinux.org.
> 
> The code itself actually doesn't seem to matter. The problem can be reproduced with an
> example as simple as this "a.c":
> 
>> int main (void) { return 0; }
> 
> Normally, this can be started on the target via gdbserver and debugged from the host. 
> I used the gdb command script
> 
>> file a.out
>> target remote 10.0.10.9:2222
>> break main
>> cont
> 
> The target would run the example, and stop, e.g. at "Breakpoint 1, 0x00b7b626 in main ()"
> 
> These compile commands produce a working a.out:
> 
>> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lpthread a.c
> 
> or
> 
>> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lpthread_rt -lxenomai a.c
> 
> but this one that combines all -l options above doesn't:
> 
>> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lpthread_rt -lxenomai -lpthread a.c
> 
> (Adding -lrt, to complete the suggested posix-ldflags, doesn't help, so I omit
> it here for shortness)
> 
> The result on the target, when started with gdbserver and as soon as the host
> says "cont", is a NULL pointer access.  It seems to occur even before main() is
> reached.

Some Xenomai code is executed before the main function is called. What I
do not understand is why gdb does not stop at the place of the segfault?

-- 
                                                                Gilles.

