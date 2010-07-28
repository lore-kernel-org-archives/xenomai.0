Message-ID: <4C4F949F.9090200@domain.hid>
Date: Tue, 27 Jul 2010 19:23:27 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C4F7930.90408@domain.hid> <4C4F7AF8.8090500@domain.hid>
In-Reply-To: <4C4F7AF8.8090500@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------090208070004080006020409"
Subject: Re: [Xenomai-help] Xenomai xeno-test hangs on 2.6.31 on BeagleBoard,
 same works on 2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090208070004080006020409
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  On 2.6.33.......... (2.6.31 gives the same result)
root@domain.hid:~# /usr/xenomai/bin/latency
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

BUT, neither are disabled... And, xeno_nucleus is built-in to the kernel.
 From .config.........
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH_DEP=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_UNLOCKED_SWITCH=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
# CONFIG_XENO_OPT_DEBUG_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
# CONFIG_XENO_OPT_RTDM_SELECT is not set

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
# CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES is not set
CONFIG_XENO_DRIVERS_TIMERBENCH=y
# CONFIG_XENO_DRIVERS_KLATENCY is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
CONFIG_XENO_DRIVERS_SWITCHTEST=y
# CONFIG_XENO_DRIVERS_SIGTEST is not set
# CONFIG_XENO_DRIVERS_RTDMTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# ANALOGY drivers
#
# CONFIG_XENO_DRIVERS_ANALOGY is not set

#
# Real-time IPC drivers
#
# CONFIG_XENO_DRIVERS_RTIPC is not set
CONFIG_FREEZER=y

Regards,
Bob Feretich

On 7/27/2010 5:34 PM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>> xeno-test: finished
>>
>> Any idea what's causing this?
> What is causing what? From the last message, xeno-test appears to have
> finished. What happens if you run the "latency" test?
>

--------------090208070004080006020409
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <small><big>On 2.6.33.......... (2.6.31 gives the same result)</big><tt><big><br>
          root@domain.hid:~# /usr/xenomai/bin/latency   <br>
          Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
          (modprobe xeno_nucleus?)</big><br>
        <br>
      </tt><big>BUT, neither are disabled... And, xeno_nucleus is
        built-in to the kernel.<br>
        From .config.........</big><tt><br>
        CONFIG_XENOMAI=y<br>
        CONFIG_XENO_GENERIC_STACKPOOL=y<br>
        CONFIG_XENO_FASTSYNCH_DEP=y<br>
        CONFIG_XENO_FASTSYNCH=y<br>
        CONFIG_XENO_OPT_NUCLEUS=y<br>
        CONFIG_XENO_OPT_PERVASIVE=y<br>
        CONFIG_XENO_OPT_PRIOCPL=y<br>
        CONFIG_XENO_OPT_PIPELINE_HEAD=y<br>
        # CONFIG_XENO_OPT_SCHED_CLASSES is not set<br>
        CONFIG_XENO_OPT_PIPE=y<br>
        CONFIG_XENO_OPT_PIPE_NRDEV=32<br>
        CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512<br>
        CONFIG_XENO_OPT_SYS_HEAPSZ=256<br>
        CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128<br>
        CONFIG_XENO_OPT_SEM_HEAPSZ=12<br>
        CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12<br>
        CONFIG_XENO_OPT_STATS=y<br>
        # CONFIG_XENO_OPT_DEBUG is not set<br>
        # CONFIG_XENO_OPT_SHIRQ is not set<br>
        <br>
        #<br>
        # Timing<br>
        #<br>
        # CONFIG_XENO_OPT_TIMING_PERIODIC is not set<br>
        CONFIG_XENO_OPT_TIMING_VIRTICK=1000<br>
        CONFIG_XENO_OPT_TIMING_SCHEDLAT=0<br>
        <br>
        #<br>
        # Scalability<br>
        #<br>
        # CONFIG_XENO_OPT_SCALABLE_SCHED is not set<br>
        CONFIG_XENO_OPT_TIMER_LIST=y<br>
        # CONFIG_XENO_OPT_TIMER_HEAP is not set<br>
        # CONFIG_XENO_OPT_TIMER_WHEEL is not set<br>
        <br>
        #<br>
        # Machine<br>
        #<br>
        CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y<br>
        CONFIG_XENO_HW_FPU=y<br>
        CONFIG_XENO_HW_UNLOCKED_SWITCH=y<br>
        <br>
        #<br>
        # Interfaces<br>
        #<br>
        CONFIG_XENO_SKIN_NATIVE=y<br>
        CONFIG_XENO_OPT_NATIVE_PERIOD=0<br>
        CONFIG_XENO_OPT_NATIVE_PIPE=y<br>
        CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024<br>
        CONFIG_XENO_OPT_NATIVE_SEM=y<br>
        CONFIG_XENO_OPT_NATIVE_EVENT=y<br>
        CONFIG_XENO_OPT_NATIVE_MUTEX=y<br>
        CONFIG_XENO_OPT_NATIVE_COND=y<br>
        CONFIG_XENO_OPT_NATIVE_QUEUE=y<br>
        CONFIG_XENO_OPT_NATIVE_BUFFER=y<br>
        CONFIG_XENO_OPT_NATIVE_HEAP=y<br>
        CONFIG_XENO_OPT_NATIVE_ALARM=y<br>
        CONFIG_XENO_OPT_NATIVE_MPS=y<br>
        # CONFIG_XENO_OPT_NATIVE_INTR is not set<br>
        CONFIG_XENO_SKIN_POSIX=y<br>
        CONFIG_XENO_OPT_POSIX_PERIOD=0<br>
        # CONFIG_XENO_OPT_POSIX_SHM is not set<br>
        # CONFIG_XENO_OPT_POSIX_INTR is not set<br>
        # CONFIG_XENO_OPT_POSIX_SELECT is not set<br>
        # CONFIG_XENO_OPT_DEBUG_POSIX is not set<br>
        # CONFIG_XENO_SKIN_PSOS is not set<br>
        # CONFIG_XENO_SKIN_UITRON is not set<br>
        # CONFIG_XENO_SKIN_VRTX is not set<br>
        # CONFIG_XENO_SKIN_VXWORKS is not set<br>
        # CONFIG_XENO_SKIN_RTAI is not set<br>
        # CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set<br>
        CONFIG_XENO_SKIN_RTDM=y<br>
        CONFIG_XENO_OPT_RTDM_PERIOD=0<br>
        CONFIG_XENO_OPT_RTDM_FILDES=128<br>
        # CONFIG_XENO_OPT_RTDM_SELECT is not set<br>
        <br>
        #<br>
        # Drivers<br>
        #<br>
        <br>
        #<br>
        # Serial drivers<br>
        #<br>
        # CONFIG_XENO_DRIVERS_16550A is not set<br>
        <br>
        #<br>
        # Testing drivers<br>
        #<br>
        # CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES is not set<br>
        CONFIG_XENO_DRIVERS_TIMERBENCH=y<br>
        # CONFIG_XENO_DRIVERS_KLATENCY is not set<br>
        # CONFIG_XENO_DRIVERS_IRQBENCH is not set<br>
        CONFIG_XENO_DRIVERS_SWITCHTEST=y<br>
        # CONFIG_XENO_DRIVERS_SIGTEST is not set<br>
        # CONFIG_XENO_DRIVERS_RTDMTEST is not set<br>
        <br>
        #<br>
        # CAN drivers<br>
        #<br>
        # CONFIG_XENO_DRIVERS_CAN is not set<br>
        <br>
        #<br>
        # ANALOGY drivers<br>
        #<br>
        # CONFIG_XENO_DRIVERS_ANALOGY is not set<br>
        <br>
        #<br>
        # Real-time IPC drivers<br>
        #<br>
        # CONFIG_XENO_DRIVERS_RTIPC is not set<br>
        CONFIG_FREEZER=y</tt></small><br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 7/27/2010 5:34 PM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C4F7AF8.8090500@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">xeno-test: finished

Any idea what's causing this?
</pre>
      </blockquote>
      <pre wrap="">
What is causing what? From the last message, xeno-test appears to have
finished. What happens if you run the "latency" test?

</pre>
    </blockquote>
  </body>
</html>

--------------090208070004080006020409--

