Message-ID: <243955.44519.qm@domain.hid>
Date: Tue, 17 May 2011 13:25:57 -0700 (PDT)
From: A User <t02446@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] xenomai x86 linux config file checker
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

I see that there is advice for setting up a Xenomai Linux config in
various places:

http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_kernel
http://www.xenomai.org/index.php/Configuring_x86_kernels

I think it is messy to check the options, so I wrote a shell script
"xeno_x86_check_config" to make it easier.  I wrote it for x86, it may be useful to make it more general.  It checks the options that
I think are important, and lists them.  I may have some of the choices
wrong, but experts can correct them or modify the script as
requirements change.  You may find it useful to add this script to the
Xenomai package.

-Andy

<<<<<
#! /bin/sh

# check Linux kernel config file for x86 Xenomai conditions
# xeno_x86_check_config
# Copyright 2011 Andy Tannenbaum

if [ -z "$1"  -o ! -f "$1" ]; then
      echo usage: xeno_x86_check_config configfile
      exit 1
fi

# find iff set

echo cpu type:

for i in \
\
CONFIG_M386 \
CONFIG_M486 \
CONFIG_M586 \
CONFIG_M586TSC \
CONFIG_M586MMX \
CONFIG_M686 \
CONFIG_MPENTIUMII \
CONFIG_MPENTIUMIII \
CONFIG_MPENTIUMM \
CONFIG_MPENTIUM4 \
CONFIG_MK6 \
CONFIG_MK7 \
CONFIG_MK8 \
CONFIG_MCRUSOE \
CONFIG_MEFFICEON \
CONFIG_MWINCHIPC6 \
CONFIG_MWINCHIP3D \
CONFIG_MGEODEGX1 \
CONFIG_MGEODE_LX \
CONFIG_MCYRIXIII \
CONFIG_MVIAC3_2 \
CONFIG_MVIAC7 \
CONFIG_MPSC \
CONFIG_MCORE2 \
CONFIG_MATOM \
CONFIG_GENERIC_CPU \
CONFIG_X86_GENERIC \
CONFIG_X86_CPU \

do

grep -w ${i}=y $1

done
echo

# find whether set

echo want these set if possible:

for i in \
\
CONFIG_XENO_HW_SMI_WORKAROUND \
CONFIG_XENO_OPT_PERVASIVE \

do

grep -w $i $1 || echo $i not found in $1

done
echo

# find whether set

echo want these not set:

for i in \
\
CONFIG_CPU_FREQ \
CONFIG_APM \
CONFIG_ACPI_PROCESSOR \
CONFIG_PCI_MSI \
CONFIG_INTEL_IDLE \

do

grep -w $i $1 || echo $i not found in $1

done
echo

# find whether set

echo want these not set if pre-Pentium:

for i in \
\
CONFIG_INPUT_PCSPKR \
CONFIG_X86_TSC \

do

grep -w $i $1 || echo $i not found in $1

done
echo

# find whether set

echo want IPIPE, and either set X86_LOCAL_APIC or not set HPET_TIMER:

for i in \
\
CONFIG_X86_LOCAL_APIC \
CONFIG_HPET_TIMER \
CONFIG_IPIPE \

do

grep -w $i $1 || echo $i not found in $1

done
echo

echo Xenomai options:
grep CONFIG_XENO $1
echo

echo Preempt options:
grep PREEMPT $1
>>>>>

