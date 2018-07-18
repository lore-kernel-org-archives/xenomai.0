MIME-Version: 1.0
Date: Wed, 18 Jul 2018 16:00:10 +0200
From: richer <richer@isir.upmc.fr>
Message-ID: <c1b44e11327eb188cf547d3f61b3a461@mailhost.isir.upmc.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Analogy with high sample rates
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi 

I am trying to read from several DAQ devices (2 National Instruments
6034E for now, 6 analog inputs on each card) at high frequencies
(~10kHz) but my computer often locks up when I want to stop the
acquisition (by calling a4l_snd_cancel and/or a4l_close) but before
that, everything seems to be running fine. 

I made a simple test program (code below) to check what was causing this
and it seems related to the sampling period : 10kHz is a guaranteed
crash on my machine (i5 7600 on an ASUS Prime Z270K, Xenomai 3.0.7,
kernel 4.9.51), even when reading from just 1 channel on 1 card. 5kHz
seems fine. 

However, the lock-ups don't happen with a finite number of sample, ie
when using :
cmd_desc[i].stop_src = TRIG_COUNT;
cmd_desc[i].stop_arg = num_samples; 

Am I not using the API properly ? Or is this an expected behavior at
this sampling rate ? 

Thanks in advance 

-------------------------------- 

Config dump: 

based on Xenomai/cobalt v3.0.7
CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_BUILD_ARGS=" '--with-core=cobalt' '--enable-smp'
'--enable-registry' '--enable-assert'"
CONFIG_XENO_BUILD_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 5.4.0 20160609 (Ubuntu
5.4.0-6ubuntu1~16.04.10) "
CONFIG_XENO_DEFAULT_PERIOD=100000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr/xenomai"
CONFIG_XENO_RAW_CLOCK_ENABLED=1
CONFIG_XENO_REGISTRY=1
CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
CONFIG_XENO_REVISION_LEVEL=7
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=14
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_VERSION_NAME="Lingering Dawn"
CONFIG_XENO_VERSION_STRING="3.0.7"
CONFIG_XENO_X86_VSYSCALL=1
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_PSHARED is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=65536
AUTOMATIC_BOOTSTRAP=1 

Output of lspci: 

04:00.0 Unassigned class [ff00]: National Instruments PCI-6034E
04:01.0 Unassigned class [ff00]: National Instruments PCI-6034E 

The attach procedure: 

/usr/xenomai/sbin/analogy_config analogy0 analogy_ni_pcimio 4,0
/usr/xenomai/sbin/analogy_config analogy1 analogy_ni_pcimio 4,1 

My code: 

#include <stdlib.h>
#include <rtdm/analogy.h>
#include <alchemy/timer.h>

int main()
{
    int ret;

    const unsigned int num_devices = 1;
    const unsigned int num_channels = 1;
    const unsigned int num_samples = 50000;
    const unsigned int daq_period_ns = 100000;

    a4l_desc_t desc[num_devices] = {0};
    a4l_cmd_desc cmd_desc[num_devices] = {0};
    uint16_t buf[num_devices][num_samples*num_channels];
    unsigned int offsets[num_devices] = {0};
    unsigned int channels[num_devices][num_channels];

    for(unsigned int i = 0; i < num_devices; ++i) {
        char device_name[32] = {0};
        sprintf(device_name,"analogy%d",i);

        ret = a4l_open(&desc[i],device_name);
        if(ret < 0) {
            printf("a4l_open %s failed (%d).\r\n",device_name,ret);
            exit(ret);
        }

        desc[i].sbdata = malloc(desc[i].sbsize);

        ret = a4l_fill_desc(&desc[i]);
        if(ret < 0) {
            printf("a4l_fill_desc %s failed (%d).\r\n",device_name,ret);
            exit(ret);
        }

        for(unsigned int j = 0; j < num_channels; ++j) {
            channels[i][j] = PACK(j,0,AREF_GROUND);
        }

        cmd_desc[i].idx_subd = 0;
        cmd_desc[i].flags = TRIG_WAKE_EOS;
        cmd_desc[i].start_src = TRIG_NOW;
        cmd_desc[i].start_arg = 0;
        cmd_desc[i].scan_begin_src = TRIG_TIMER;
        cmd_desc[i].scan_begin_arg = daq_period_ns;
        cmd_desc[i].convert_src = TRIG_TIMER;
        cmd_desc[i].convert_arg = 4000;
        cmd_desc[i].scan_end_src = TRIG_COUNT;
        cmd_desc[i].scan_end_arg = num_channels;
        cmd_desc[i].stop_src = TRIG_NONE;
        cmd_desc[i].stop_arg = 0;
        cmd_desc[i].nb_chan = num_channels;
        cmd_desc[i].chan_descs = channels[i];

        a4l_snd_cancel(&desc[i], cmd_desc[i].idx_subd);
    }

    RTIME start = rt_timer_read();

    for(unsigned int i = 0; i < num_devices; ++i) {
        ret = a4l_snd_command(&desc[i],&cmd_desc[i]);
        if(ret < 0) {
            printf("a4l_snd_command failed on device %d
(%d).\r\n",i,ret);
            exit(ret);
        }
    }

    bool done = true;
    do {
        done = true;
        for(unsigned int i = 0; i < num_devices; ++i) {
            ret = a4l_async_read(&desc[i],
reinterpret_cast<char*>(buf[i])+offsets[i],
2*num_channels*num_samples-offsets[i], A4L_INFINITE);

            if(ret < 0) {
                printf("a4l_async_read failed (%d).\r\n",ret);
                exit(ret);
            }

            offsets[i] += ret;

            done &= (offsets[i] >= 2*num_samples*num_channels);
        }
    } while(!done);
    RTIME elapsed = rt_timer_read() - start;

    printf("Done in %.2fs. Expected time was
%.2fs.\r\n",rt_timer_ticks2ns(elapsed)/1000000000.0,num_samples*(daq_period_ns/1000000000.0));

    for(unsigned int i = 0; i < num_devices; ++i) {
        a4l_snd_cancel(&desc[i], cmd_desc[i].idx_subd);
        a4l_close(&desc[i]);

        if(desc[i].sbdata) {
            free(desc[i].sbdata);
        }
    }

    return 0;
}
