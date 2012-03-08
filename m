MIME-Version: 1.0
Date: Thu, 8 Mar 2012 15:30:47 +0100
Message-ID: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: multipart/mixed; boundary=f46d0444e9a349a8f304babc1ff2
Subject: [Xenomai-core] xenomai-forge: round-robin scheduling in pSOS skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

--f46d0444e9a349a8f304babc1ff2
Content-Type: text/plain; charset=ISO-8859-1

Hello

I'm are using the xenomai-forge pSOS skin (Mercury).
My application is running on a P4040 (Freescale PPC with 4 cores).
Some code snippets are put in this mail but the complete testcode is
also attached.

I have a test task that just consumes the CPU:

int run_test = 1;
static void perform_work(u_long counter,u_long b,u_long c,u_long d)
{
  int i;
  while (run_test) {
    for (i=0;i<100000;i++);
    (*(unsigned long*)counter)++;
  }
  while (1) tm_wkafter(1000);
}

If I create 2 instances of this task with the T_SLICE option set:

    t_create("WORK",10,0,0,0,&tid);
    t_start(tid,T_TSLICE, perform_work, args);


I see that only 1 task is consuming CPU.

# taskset 1 ./roundrobin.exe &
#    0"000.543| [main] SCHED_RT priorities => [1 .. 99]
   0"000.656| [main] SCHED_RT.99 reserved for IRQ emulation
   0"000.692| [main] SCHED_RT.98 reserved for scheduler-lock emulation
0 -> 6602
1 -> 0

If I adapt the code so that I call in my init the threadobj_start_rr
function, I see that the load is equally distributed over the 2
threads:

# taskset 1 ./roundrobin.exe &
#    0"000.557| [main] SCHED_RT priorities => [1 .. 99]
   0"000.672| [main] SCHED_RT.99 reserved for IRQ emulation
   0"000.708| [main] SCHED_RT.98 reserved for scheduler-lock emulation
0 -> 3290
1 -> 3291

Here are the questions:
- why is the threadobj_start_rr function not called from the context
of the init of the psos layer.
- why is the roundrobin implemented in this way? If the tasks would be
mapped on the SCHED_RR instead of the SCHED_FF the Linux scheduler
would take care of this.
On the other hand, once the threadobj_start_rr function is called from
my init, and I create the tasks in T_NOTSLICE mode, the time-slicing
is still done.

Thanks.

---
Ronny

--f46d0444e9a349a8f304babc1ff2
Content-Type: text/x-csrc; charset=US-ASCII; name="roundrobin.c"
Content-Disposition: attachment; filename="roundrobin.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzjvwvbo0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CiNpbmNsdWRlIDxwc29zL3Bzb3MuaD4KCmludCBydW5fdGVzdCA9IDE7CnN0YXRpYyB2
b2lkIHBlcmZvcm1fd29yayh1X2xvbmcgY291bnRlcix1X2xvbmcgYix1X2xvbmcgYyx1X2xvbmcg
ZCkKewogIGludCBpOwogIHdoaWxlIChydW5fdGVzdCkgewogICAgZm9yIChpPTA7aTwxMDAwMDA7
aSsrKTsKICAgICgqKHVuc2lnbmVkIGxvbmcqKWNvdW50ZXIpKys7CiAgfQogIHdoaWxlICgxKSB0
bV93a2FmdGVyKDEwMDApOwp9CgpzdGF0aWMgdW5zaWduZWQgbG9uZyBjb3VudGVyWzJdOwoKc3Rh
dGljIHZvaWQgdGVzdCgpCnsKICB1X2xvbmcgdGlkLGFyZ3NbNF0gPSB7MCwwLDAsMH07CiAgaW50
IGk7CgogIGZvciAoaT0wO2k8MjtpKyspIHsKICAgIGFyZ3NbMF0gPSAodV9sb25nKSYoY291bnRl
cltpXSk7CiAgICB0X2NyZWF0ZSgiV09SSyIsMTAsMCwwLDAsJnRpZCk7CiAgICB0X3N0YXJ0KHRp
ZCxUX1RTTElDRSwgcGVyZm9ybV93b3JrLCBhcmdzKTsKICB9CiAgdG1fd2thZnRlcigxMDAwMCk7
CiAgcnVuX3Rlc3QgPSAwOwoKICBmb3IgKGk9MDtpPDI7aSsrKSB7CiAgICBwcmludGYoIiVpIC0+
ICVsdVxuIixpLGNvdW50ZXJbaV0pOwogIH0KICB3aGlsZSAoMSkgdG1fd2thZnRlcigxMDAwKTsK
fQoKaW50IG1haW4oaW50IGFyZ2MsY2hhciAqYXJndltdLCBjaGFyKiplbnZwKQp7CiAgdV9sb25n
IG9sZHByaW87CiAgc3RydWN0IHRpbWVzcGVjIHF1YW50dW07CgogIG1sb2NrYWxsKE1DTF9DVVJS
RU5UIHwgTUNMX0ZVVFVSRSk7CiAgY29wcGVycGxhdGVfaW5pdChhcmdjLGFyZ3YpOwoKICBxdWFu
dHVtLnR2X3NlYyA9IDA7CiAgcXVhbnR1bS50dl9uc2VjID0gNSAqIDEwMDAgKiAxMDAwOyAvLyB1
c2UgNW1zCiAgdGhyZWFkb2JqX3N0YXJ0X3JyKCZxdWFudHVtKTsKICB0X3NldHByaSgwLDUwLCZv
bGRwcmlvKTsKICB0ZXN0KCk7CiAgcmV0dXJuIDA7Cn0KCg==
--f46d0444e9a349a8f304babc1ff2--

