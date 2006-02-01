Message-ID: <43E006C2.50503@domain.hid>
Date: Tue, 31 Jan 2006 16:54:26 -0800
From: Nathaniel Villaume <villaume@domain.hid>
MIME-Version: 1.0
References: <200601251105.k0PB5uPK028509@domain.hid>
	<43D7CD2F.9030709@domain.hid> <43DE0955.7060608@domain.hid>
In-Reply-To: <43DE0955.7060608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Dual Xeon 2.6.13 SMP config problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

Hi all,

This email might be slightly off-topic because it's related to getting 
even a vanilla SMP kernel running (even though I can get the UP version 
to run Xenomai).

I performed two tests:

My distro is FC3 with linux-2.6.9. I'm trying to get the SMP version of 
2.6.13 running with Xenomai.

Test #1:
========
Use my distro's smp kernel (which boots) config to build the 2.6.13 
kernel. 
I ran make oldconfig, then make menuconfig, and turned off Experimental 
options.
I can't boot:  mount complains: "mount: error 6 mounting ext3"... etc.

Test #2
==========
I used the single CPU kernel config to build the adeos-patched 2.6.13 
kernel.  This boots and xeno latency runs fine. I had  a problem with 
`make devices` not making the devices, but I moved on to getting the SMP 
working.
If I switch to SMP in the kernel config, the machine doesn't boot.  
Instead, it complains: "mount: error 6 mounting ext3".
I checked that the ext3 is being compiled as a module.... I literally 
only change the SMP option.

I found some things on the internet about the ext3 error meaning that 
the driver wasn't compiled into the kernel.  I tried this, even though 
it shouldn't matter.  It doesn't work. I get more details about the 
kernel panic:
EIP is at kmem_cache_create

Looks like the trace/stack is:
mb_cache_create
init_ext3_xattr
init_ext3_fs
sys_init_module
sysenter_past_esp

"/bin/lvm exited abnormally."

I feel like I must be missing something obvious, any ideas?  Would my 
configs be of use?  I've looked through side-by-side diffs and can't see 
meaningful differences. I saw something about udev --which might explain 
my inabilty to create /dev/rtp0 with 'make devices'

I'd appreciate any pointers to what might be wrong,
-Nate



