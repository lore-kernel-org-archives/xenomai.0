Message-ID: <B213B204A377E148A31BC71DE4955C97029AF292@domain.hid>
From: Neugebauer Manfred <manfred.neugebauer@domain.hid>
Date: Thu, 2 Sep 2004 10:10:12 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: [Adeos-main] sysenter / sysexit with Adeos
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

I'm using the Adeos nanokernel (2.6.8.1-i386-r6) within a project to
implement a specific realtime environment embedded within Linux. I
recognized the following problem within the routines for the kernel entry
calls which we also use for our special code:

For every call to the Linux kernel (x86 architecture using Int 0x80) Adeos
provides a hook within entry.s to call a subroutine within a higher priority
domain. When this subroutine returns a nonzero value, the "standard" code
sequence in entry.s is stopped and the code returns immediately. 

This works also when you use the kernel entry via sysenter() which is much
faster. However, when the subroutine of the higher priority domain wants to
skip the "standard" code sequence during its return, Adeos uses a normal
"iret" to leave the kernel. The "standard" procedure would be to use
sysexit(). As a result returning back to the user code costs much more time
with Adeos than within Linux.

I wonder whether there are reasons for this different behavior or whether it
was simply forgotten. I modified the code in this way that Adeos also uses
sysexit() and did not recognize any problems so far but a performance gain.

Manfred




