Message-ID: <44113E39.1010902@domain.hid>
Date: Fri, 10 Mar 2006 09:52:09 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] user mode vs. kernel module
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

So far I've had my application implemented entirely as a kernel module 
with some user mode helper programs. I've had in mind changing to user 
mode but never felt compelled enough.

Now, having a new requirement to implement, I think it's the moment to 
give it a try, and I'm porting it. I have a couple of questions:

1- How significative, in real world terms, is the overhead involved in 
operaing in user mode?. As far as I know all operations are executed via 
"pods" which involve one or more system calls and context switches. I'm 
using a Geode board right now but there are plans to move to a more 
low-end platform (486).

2- ioperm. This is a true headache. I've spent countless hours debugging 
this and banging my head agaist the wall. I'm not 100% sure of what's 
going on here, but it looks like the ioperm call must be issued from 
primary mode if you are doing the I/O from primary mode. Something like 
this would segfault:

ioperm(0x443, 0x01, 1);
rt_mutex_lock(...)
outb(0x01, 0x443)

While this works fine:

rt_mutex_lock(...)
ioperm(0x443, 0x01, 1);
outb(0x01, 0x443);

While leads me to think that the rt_mutex_lock puts the task in primary 
mode and then both ioperm and outb are executed in the same mode so 
everything works.

Is this right?. If so, I find this extremely inconvenient...

Nacho.





