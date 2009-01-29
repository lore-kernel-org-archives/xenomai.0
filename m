Message-ID: <4981CDB7.5090905@domain.hid>
Date: Thu, 29 Jan 2009 15:39:35 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090129152206.A82B71C066@domain.hid>
In-Reply-To: <20090129152206.A82B71C066@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] interrupt service routine issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefano.franzoni@domain.hid
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

stefano.franzoni@domain.hid wrote:
> Thanks Gilles,
> 
> with your suggestion, setting the special mode bit T_WARNSW for the
> incriminated task, we found two critical functions that caused switches to
> secondary mode.
> 
> I report them for documentation:
> 
> 1. We used mmap function used to map a file into memory. The access to the
> memory caused sometimes the switch to secondary mode.

damn, this should not happen, we use mlockall and some additional tricks
in the I-pipe patch to avoid that.

> 2. A pthread_cond_signal call used to unlock a waiting task always
> generates the switch to secondary mode.

if it is Linux's pthread_cond_signal, this is normal, if this is
Xenomai's pthread_cond_signal, then we have a problem.

> 
> We have implemented the two functions in a lower priority thread and the
> issue was solved.
> Thanks to your magic silver bullet!!
> 
> To stress my application I have found a DoHell script by Ingo Molnar
> (http://marc.info/?l=linux-kernel&m=111947618802722&w=2) but it is
> uncompleted. Can you send your DoHell script?

I am afraid it is much the same. I have ltp installed in /ltp and do:

#! /bin/sh

mount | grep -q sda1 || mount /dev/sda1 /mnt
modprobe rtc-cmos

dortc() {
    chrt -f 98 -p `pidof 'IRQ 8'`
    /bin/rtc_wakeup -f 8192 -t 100000
}

run40() {
    while true; do ./runalltests.sh -x 40; done
}

while true; do dd if=/dev/zero of=/mnt/bigfile bs=1024000 count=100; done &
while true; do killall hackbench; sleep 5; done &
while true; do /ltp/testcases/bin/hackbench 20; done &
( cd /ltp; run40; ) &
ping -l 100000 -q -s 10 -f 192.168.0.5 &
while true; do ls -lR / > /dev/null 2>&1; done &
dortc &

-- 
                                                 Gilles.

