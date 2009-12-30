MIME-Version: 1.0
In-Reply-To: <1262165780.19080.431.camel@domain.hid>
References: <b88603c30912290148v7c67f028vce0a432c352ee41f@domain.hid>
	<1262081910.19080.363.camel@domain.hid>
	<1262083807.19080.378.camel@domain.hid>
	<b88603c30912290816y575f5dd2qaa4f6452c1ae36d5@domain.hid>
	<1262165780.19080.431.camel@domain.hid>
Date: Wed, 30 Dec 2009 14:24:54 +0100
Message-ID: <b88603c30912300524w6c3fc006u2af367e53707f4d5@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: multipart/mixed; boundary=0014852d36cd67c48c047bf210f5
Subject: Re: [Xenomai-help] Long latency exactly every hour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0014852d36cd67c48c047bf210f5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2009 at 10:36 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Tue, 2009-12-29 at 17:16 +0100, Henri Roosen wrote:
>> Thanks Philippe for your quick response!
>>
>> I instrumented the code like below. I only see the first trace entry
>> (0x11) in the log. If I interpret that correctly, the
>> i8042_read_status() which is actually only an inb(0x64); stalls the
>> system when fetching the data!? Could you comment on that. Is there
>> maybe another explanation?
>
> You could double-check this by moving that particular invocation of
> i8042_read_status() to a non-static, one-liner routine, and check
> whether you see the 400 us lag charged to it.
>

I tried to switch off the i8042 kernel driver using the kernel
menuconfig, but it wouldn't let me that easily.. so I added a "return
IRQ_HANDLED;" statement at the beginning of the i8042_interrupt
routine, just for a quick test. The system has been running over-night
without any long latencies now (< 80us with tracing enabled).

This sounds to me that something in the system design around the i8042
implementation causes the delay. Strange is that I can use a connected
keyboard without generating any delay. The delay only occured one time
exactly every hour (was 100% reproducable). Maybe the way it is wired
up in the system is a problem. If I read the internal chip block
diagram correctly the i8042 might even be implemented in an on-chip
8051.. I will try and get more details from our vendor.

>>
>> The i8042 is implemented in the Vortex86DX chip which is a system on
>> chip. If this conclusion is correct I might try and contact someone at
>> Vortex to find out if they can confirm this behaviour.
>>
>
> Quite frankly, I don't have a definite answer.
>
> Some observations though:
>
> - first of all, this "noise" is periodic, in the 300-500 us range, which
> is a common symptom of USB-related SMI interrupts on other platforms.
>
> - However, the issue seems to trigger when PS/2 I/O are performed, via
> the i8042 chip. I have no answer to this either, but maybe you could try
> disabling the kernel support for the AT keyboard and PS/2 mouse,
> including the i8042 driver, only relying on the serial 8250 console, for
> the purpose of testing whether this does make a difference or not.
>

It makes all the difference :-), see previous comment. Finding a
proper way to disable the i8042 kernel driver now... Our product does
not need any PS/2 I/O.

> - Unfortunately, looking at the specs of DMP's Vortex86DX, I don't see
> any ACPI capabilities. So enabling ACPI for mitigating any SMI issue
> does not seem to be an option.
>
> - looking at the spec again, I see a display chip mentioned in the block
> diagram, present on the Vortex86DX SoC. However, VGA support seems to be
> available only with the upcoming MX SoC. It would be interesting to know
> whether you do have some display hardware on that SoC, eventually.
>

The Vortex86DX does not have display hardware on-chip. I agree the
block diagram is not very clear, but the display block is painted
outside of the dashed red line. The internal-block-diagram of the DX
SoC does not show it, which is correct.

> It would be useful to know from your vendor whether this SoC implements
> some hardware emulation via SMM, in which case SMI would have a good
> reason to be present.
>

Good question. I will forward that question to our vendor. However, I
disabled the SMM/SMI manually by configuring the SMM registers of the
chip (port 0xfff0-0xfffa), so I would not expect any SMM/SMI.

> Also, could you send your full kernel boot log, with Xenomai SMI source
> detection enabled in your configuration? This would help determining
> which chipset our SMI work-around code actually detects.
>

Please find the bootlog attached. I enabled the SMI workaround, but
see nothing about it in the bootlog.

Thanks for your support!
Henri.

>>
>> =A0 =A0 =A0 =A0 spin_lock_irqsave(&i8042_lock, flags);
>> =A0 =A0 =A0 =A0 ipipe_trace_special(0x11, 0);
>> =A0 =A0 =A0 =A0 str =3D i8042_read_status();
>> =A0 =A0 =A0 =A0 if (unlikely(~str & I8042_STR_OBF)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipipe_trace_special(0xf1, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&i8042_lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq) dbg("Interrupt %d, without any =
data", irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 ipipe_trace_special(0x12, 0);
>> =A0 =A0 =A0 =A0 data =3D i8042_read_data();
>> =A0 =A0 =A0 =A0 ipipe_trace_special(0x13, 0);
>> =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&i8042_lock, flags);
>>
>>
>> Thanks,
>> Henri
>>
>>
>> On Tue, Dec 29, 2009 at 11:50 AM, Philippe Gerum <rpm@xenomai.org> wrote=
:
>> > On Tue, 2009-12-29 at 11:18 +0100, Philippe Gerum wrote:
>> >> On Tue, 2009-12-29 at 10:48 +0100, Henri Roosen wrote:
>> >> > Hi,
>> >> >
>> >> > I have a small board with a Vortex86DX processor, which is a x86
>> >> > compatible processor. I have a Linux Xenomai kernel 2.6.30.10 runni=
ng
>> >> > with ipipe 2.4-09 and Xenomai 2.4.10. The .config file is attached =
to
>> >> > this email.
>> >> >
>> >> > The latency test program runs fine with latencies < 40us, but exact=
ly
>> >> > every hour I get one latency which is about 450us. In our system th=
at
>> >> > is killing.
>> >> >
>> >> > I switched off all the SMI and NMI on the board so that will not ca=
use
>> >> > the latency. Also I don't see any NMI's or ERR interrupts in
>> >> > /proc/interrupts.
>> >> >
>> >> > I enabled the ipipe tracer and did a couple of runs. What I noticed=
 is
>> >> > that the long delay is happening every time at ipipe_check_context =
in
>> >> > the Linux domain (see attached trace_464.log and trace2_438.log). W=
hat
>> >> > could be blocking the next common_interrupt for so long or what is
>> >> > happening there?
>> >> >
>> >>
>> >> Actually, the bad guy is not ipipe_check_context(), but i8042_interru=
pt,
>> >> from the serio driver, one line above in the report. For some reason,=
 it
>> >> spins there for quite a while.
>> >>
>> >> If you look at the various interrupt statuses reported on that line, =
you
>> >> will see that interrupts are still enabled at hw level, but stalled o=
nly
>> >> for Linux. So what that interrupt handler does, seems to defer the ne=
xt
>> >> interrupt at PIC/device level, but nothing masks it at CPU level.
>> >
>> > Well, unless some code there fiddles with the interrupt mask internall=
y,
>> > in a way that does not get reported to the tracer, in which case what
>> > the tracer reports would be suspicious/incomplete wrt the hw interrupt
>> > status.
>> >
>> >>
>> >> A possible way to debug this is to add more tracepoints to the suspec=
ted
>> >> code. You have a special tracer call for adding manual instrumentatio=
n,
>> >> named "ipipe_trace_special()". You could use it this way, e.g.
>> >>
>> >> static irqreturn_t i8042_interrupt(int irq, void *dev_id)
>> >> {
>> >> =A0 =A0 =A0 struct i8042_port *port;
>> >> =A0 =A0 =A0 unsigned long flags;
>> >> =A0 =A0 =A0 unsigned char str, data;
>> >> =A0 =A0 =A0 unsigned int dfl;
>> >> =A0 =A0 =A0 unsigned int port_no;
>> >> =A0 =A0 =A0 int ret =3D 1;
>> >>
>> >> =A0 =A0 =A0 spin_lock_irqsave(&i8042_lock, flags);
>> >> + =A0 =A0 ipipe_trace_special(0x11, 0);
>> >> =A0 =A0 =A0 str =3D i8042_read_status();
>> >> =A0 =A0 =A0 if (unlikely(~str & I8042_STR_OBF)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&i8042_lock, flags=
);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq) dbg("Interrupt %d, without any d=
ata", irq);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ipipe_trace_special(0x12, 0);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 data =3D i8042_read_data();
>> >> + =A0 =A0 ipipe_trace_special(0x13, 0);
>> >> =A0 =A0 =A0 spin_unlock_irqrestore(&i8042_lock, flags);
>> >>
>> >> and so on, until you think you have covered enough paths to find the
>> >> culprit in the tracer log. The basic idea is to catch the high latenc=
y
>> >> between two consecutive calls of the special tracepoints, ideally clo=
se
>> >> enough from each other to allow a precise pinpointing of the faulty
>> >> code.
>> >>
>> >> See there for more:
>> >> http://www.xenomai.org/index.php/I-pipe:Tracer
>> >>
>> >> > All help for debugging and solving this problem is appreciated.
>> >> >
>> >> > Thanks,
>> >> > Henri.
>> >> > _______________________________________________
>> >> > Xenomai-help mailing list
>> >> > Xenomai-help@domain.hid
>> >> > https://mail.gna.org/listinfo/xenomai-help
>> >>
>> >>
>> >
>> >
>> > --
>> > Philippe.
>> >
>> >
>> >
>
>
> --
> Philippe.
>
>
>

--0014852d36cd67c48c047bf210f5
Content-Type: text/plain; charset=US-ASCII; name="bootlog.txt"
Content-Disposition: attachment; filename="bootlog.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3u1xuck0

TGludXggdmVyc2lvbiAyLjYuMzAuMTAgKGhlbnJpQHJ0LWRldmVsKSAoZ2NjIHZlcnNpb24gNC4z
LjMgKFVidW50dSA0LjMuMy01dWJ1bnR1NCkgKSAjMTAgV2VkIERlYyAzMCAxMjoyMzoxNSBDRVQg
MjAwOQpLRVJORUwgc3VwcG9ydGVkIGNwdXM6CiAgSW50ZWwgR2VudWluZUludGVsCiAgQU1EIEF1
dGhlbnRpY0FNRAogIE5TQyBHZW9kZSBieSBOU0MKICBDeXJpeCBDeXJpeEluc3RlYWQKICBDZW50
YXVyIENlbnRhdXJIYXVscwogIFRyYW5zbWV0YSBHZW51aW5lVE14ODYKICBUcmFuc21ldGEgVHJh
bnNtZXRhQ1BVCiAgVU1DIFVNQyBVTUMgVU1DCkNQVTogdmVuZG9yX2lkICdWb3J0ZXg4NiBTb0Mn
IHVua25vd24sIHVzaW5nIGdlbmVyaWMgaW5pdC4KQ1BVOiBZb3VyIHN5c3RlbSBtYXkgYmUgdW5z
dGFibGUuCkJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKIEJJT1MtZTgyMDogMDAwMDAw
MDAwMDAwMDAwMCAtIDAwMDAwMDAwMDAwOWZjMDAgKHVzYWJsZSkKIEJJT1MtZTgyMDogMDAwMDAw
MDAwMDA5ZmMwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQogQklPUy1lODIwOiAwMDAw
MDAwMDAwMGU0MDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAw
MDAwMDAwMDAxMDAwMDAgLSAwMDAwMDAwMDIwMDAwMDAwICh1c2FibGUpCiBCSU9TLWU4MjA6IDAw
MDAwMDAwZmYwMDAwMDAgLSAwMDAwMDAwMTAwMDAwMDAwIChyZXNlcnZlZCkKdXNpbmcgcG9sbGlu
ZyBpZGxlIHRocmVhZHMuCkRNSSBub3QgcHJlc2VudCBvciBpbnZhbGlkLgpsYXN0X3BmbiA9IDB4
MjAwMDAgbWF4X2FyY2hfcGZuID0gMHgxMDAwMDAKaW5pdF9tZW1vcnlfbWFwcGluZzogMDAwMDAw
MDAwMDAwMDAwMC0wMDAwMDAwMDIwMDAwMDAwCjUxMk1CIExPV01FTSBhdmFpbGFibGUuCiAgbWFw
cGVkIGxvdyByYW06IDAgLSAyMDAwMDAwMAogIGxvdyByYW06IDAgLSAyMDAwMDAwMAogIG5vZGUg
MCBsb3cgcmFtOiAwMDAwMDAwMCAtIDIwMDAwMDAwCiAgbm9kZSAwIGJvb3RtYXAgMDAwMDEwMDAg
LSAwMDAwNTAwMAooNiBlYXJseSByZXNlcnZhdGlvbnMpID09PiBib290bWVtIFswMDAwMDAwMDAw
IC0gMDAyMDAwMDAwMF0KICAjMCBbMDAwMDAwMDAwMCAtIDAwMDAwMDEwMDBdICAgQklPUyBkYXRh
IHBhZ2UgPT0+IFswMDAwMDAwMDAwIC0gMDAwMDAwMTAwMF0KICAjMSBbMDAwMDEwMDAwMCAtIDAw
MDA4YzE5ZThdICAgIFRFWFQgREFUQSBCU1MgPT0+IFswMDAwMTAwMDAwIC0gMDAwMDhjMTllOF0K
ICAjMiBbMDAwMDA5ZmMwMCAtIDAwMDAxMDAwMDBdICAgIEJJT1MgcmVzZXJ2ZWQgPT0+IFswMDAw
MDlmYzAwIC0gMDAwMDEwMDAwMF0KICAjMyBbMDAwMDhjMjAwMCAtIDAwMDA4YzUwMDBdICAgICAg
ICAgICAgICBCUksgPT0+IFswMDAwOGMyMDAwIC0gMDAwMDhjNTAwMF0KICAjNCBbMDAwMDAwNzAw
MCAtIDAwMDAwODQwMDBdICAgICAgICAgIFBHVEFCTEUgPT0+IFswMDAwMDA3MDAwIC0gMDAwMDA4
NDAwMF0KICAjNSBbMDAwMDAwMTAwMCAtIDAwMDAwMDUwMDBdICAgICAgICAgIEJPT1RNQVAgPT0+
IFswMDAwMDAxMDAwIC0gMDAwMDAwNTAwMF0KWm9uZSBQRk4gcmFuZ2VzOgogIERNQSAgICAgIDB4
MDAwMDAwMDAgLT4gMHgwMDAwMTAwMAogIE5vcm1hbCAgIDB4MDAwMDEwMDAgLT4gMHgwMDAyMDAw
MApNb3ZhYmxlIHpvbmUgc3RhcnQgUEZOIGZvciBlYWNoIG5vZGUKZWFybHlfbm9kZV9tYXBbMl0g
YWN0aXZlIFBGTiByYW5nZXMKICAgIDA6IDB4MDAwMDAwMDAgLT4gMHgwMDAwMDA5ZgogICAgMDog
MHgwMDAwMDEwMCAtPiAweDAwMDIwMDAwCkFsbG9jYXRpbmcgUENJIHJlc291cmNlcyBzdGFydGlu
ZyBhdCAzMDAwMDAwMCAoZ2FwOiAyMDAwMDAwMDpkZjAwMDAwMCkKQnVpbHQgMSB6b25lbGlzdHMg
aW4gWm9uZSBvcmRlciwgbW9iaWxpdHkgZ3JvdXBpbmcgb24uICBUb3RhbCBwYWdlczogMTI5OTUx
Cktlcm5lbCBjb21tYW5kIGxpbmU6IHJvb3Q9L2Rldi9oZGExIHJ3IG5vaGx0IGlkbGU9cG9sbCBj
b25zb2xlPXR0eVMxLDExNTIwMG44IHBjaT1iaW9zaXJxCkluaXRpYWxpemluZyBDUFUjMApOUl9J
UlFTOjE2ClBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAxMSwgODE5MiBieXRl
cykKRmFzdCBUU0MgY2FsaWJyYXRpb24gdXNpbmcgUElUCkRldGVjdGVkIDkzMy40MjEgTUh6IHBy
b2Nlc3Nvci4KSS1waXBlIDIuNC0wOTogcGlwZWxpbmUgZW5hYmxlZC4KQ29uc29sZTogY29sb3Vy
IGR1bW15IGRldmljZSA4MHgyNQpjb25zb2xlIFt0dHlTMV0gZW5hYmxlZApEZW50cnkgY2FjaGUg
aGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykKSW5vZGUt
Y2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykK
TWVtb3J5OiA1MTA3MDRrLzUyNDI4OGsgYXZhaWxhYmxlICgyODUxayBrZXJuZWwgY29kZSwgMTI5
NTZrIHJlc2VydmVkLCA0NTE2ayBkYXRhLCAyMTZrIGluaXQsIDBrIGhpZ2htZW0pCnZpcnR1YWwg
a2VybmVsIG1lbW9yeSBsYXlvdXQ6CiAgICBmaXhtYXAgIDogMHhmZmZlYjAwMCAtIDB4ZmZmZmYw
MDAgICAoICA4MCBrQikKICAgIHZtYWxsb2MgOiAweGUwODAwMDAwIC0gMHhmZmZlOTAwMCAgICgg
NTAzIE1CKQogICAgbG93bWVtICA6IDB4YzAwMDAwMDAgLSAweGUwMDAwMDAwICAgKCA1MTIgTUIp
CiAgICAgIC5pbml0IDogMHhjMDgzNDAwMCAtIDB4YzA4NmEwMDAgICAoIDIxNiBrQikKICAgICAg
LmRhdGEgOiAweGMwM2M4ZDgwIC0gMHhjMDgzMWRjMCAgICg0NTE2IGtCKQogICAgICAudGV4dCA6
IDB4YzAxMDAwMDAgLSAweGMwM2M4ZDgwICAgKDI4NTEga0IpCkNoZWNraW5nIGlmIHRoaXMgcHJv
Y2Vzc29yIGhvbm91cnMgdGhlIFdQIGJpdCBldmVuIGluIHN1cGVydmlzb3IgbW9kZS4uLk9rLgpD
YWxpYnJhdGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0
aW1lciBmcmVxdWVuY3kuLiAxODY2Ljg0IEJvZ29NSVBTIChscGo9MzczMzY4NCkKTW91bnQtY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIKQ1BVOiBWb3J0ZXg4NiBTb0MgMDUvMDIgc3RlcHBp
bmcgMDIKQ2hlY2tpbmcgJ2hsdCcgaW5zdHJ1Y3Rpb24uLi4gT0suCmZ0cmFjZTogY29udmVydGlu
ZyBtY291bnQgY2FsbHMgdG8gNjYgNjYgNjYgNjYgOTAKZnRyYWNlOiBhbGxvY2F0aW5nIDE0MDYx
IGVudHJpZXMgaW4gMjggcGFnZXMKbmV0X25hbWVzcGFjZTogNTIwIGJ5dGVzCk5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKUENJOiBQQ0kgQklPUyByZXZpc2lvbiAzLjAwIGVudHJ5
IGF0IDB4ZjAwMzEsIGxhc3QgYnVzPTAKUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMSBm
b3IgYmFzZSBhY2Nlc3MKYmlvOiBjcmVhdGUgc2xhYiA8YmlvLTA+IGF0IDAKU0NTSSBzdWJzeXN0
ZW0gaW5pdGlhbGl6ZWQKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1
c2Jmcwp1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGh1Ygp1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBkZXZpY2UgZHJpdmVyIHVzYgpQQ0k6IFByb2JpbmcgUENJIGhhcmR3
YXJlCnBjaSAwMDAwOjAwOjA3LjA6IGRlZmF1bHQgSVJRIHJvdXRlciBbMTdmMzo2MDMxXQpjZmc4
MDIxMTogVXNpbmcgc3RhdGljIHJlZ3VsYXRvcnkgZG9tYWluIGluZm8KY2ZnODAyMTE6IFJlZ3Vs
YXRvcnkgZG9tYWluOiBVUwogICAgICAgIChzdGFydF9mcmVxIC0gZW5kX2ZyZXEgQCBiYW5kd2lk
dGgpLCAobWF4X2FudGVubmFfZ2FpbiwgbWF4X2VpcnApCiAgICAgICAgKDI0MDIwMDAgS0h6IC0g
MjQ3MjAwMCBLSHogQCA0MDAwMCBLSHopLCAoNjAwIG1CaSwgMjcwMCBtQm0pCiAgICAgICAgKDUx
NzAwMDAgS0h6IC0gNTE5MDAwMCBLSHogQCA0MDAwMCBLSHopLCAoNjAwIG1CaSwgMjMwMCBtQm0p
CiAgICAgICAgKDUxOTAwMDAgS0h6IC0gNTIxMDAwMCBLSHogQCA0MDAwMCBLSHopLCAoNjAwIG1C
aSwgMjMwMCBtQm0pCiAgICAgICAgKDUyMTAwMDAgS0h6IC0gNTIzMDAwMCBLSHogQCA0MDAwMCBL
SHopLCAoNjAwIG1CaSwgMjMwMCBtQm0pCiAgICAgICAgKDUyMzAwMDAgS0h6IC0gNTMzMDAwMCBL
SHogQCA0MDAwMCBLSHopLCAoNjAwIG1CaSwgMjMwMCBtQm0pCiAgICAgICAgKDU3MzUwMDAgS0h6
IC0gNTgzNTAwMCBLSHogQCA0MDAwMCBLSHopLCAoNjAwIG1CaSwgMzAwMCBtQm0pCmNmZzgwMjEx
OiBDYWxsaW5nIENSREEgZm9yIGNvdW50cnk6IFVTCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBm
YW1pbHkgMgpJUCByb3V0ZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjog
NCwgNjU1MzYgYnl0ZXMpClRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2
IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQpUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDY1
NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQg
KGVzdGFibGlzaGVkIDY1NTM2IGJpbmQgNjU1MzYpClRDUCByZW5vIHJlZ2lzdGVyZWQKTkVUOiBS
ZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxCnBsYXRmb3JtIHJ0Y19jbW9zOiByZWdpc3RlcmVk
IHBsYXRmb3JtIFJUQyBkZXZpY2UgKG5vIFBOUCBkZXZpY2UgZm91bmQpCkktcGlwZTogRG9tYWlu
IFhlbm9tYWkgcmVnaXN0ZXJlZC4KWGVub21haTogaGFsL2kzODYgc3RhcnRlZC4KWGVub21haTog
cmVhbC10aW1lIG51Y2xldXMgdjIuNC4xMCAoRmxhdm9yIENyeXN0YWwgNykgbG9hZGVkLgpYZW5v
bWFpOiBzdGFydGluZyBuYXRpdmUgQVBJIHNlcnZpY2VzLgpYZW5vbWFpOiBzdGFydGluZyBQT1NJ
WCBzZXJ2aWNlcy4KWGVub21haTogc3RhcnRpbmcgUlRETSBzZXJ2aWNlcy4KSW5zdGFsbGluZyBr
bmZzZCAoY29weXJpZ2h0IChDKSAxOTk2IG9raXJAbW9uYWQuc3diLmRlKS4KbXNnbW5pIGhhcyBi
ZWVuIHNldCB0byA5OTcKYWxnOiBObyB0ZXN0IGZvciBzdGRybmcgKGtybmcpCkJsb2NrIGxheWVy
IFNDU0kgZ2VuZXJpYyAoYnNnKSBkcml2ZXIgdmVyc2lvbiAwLjQgbG9hZGVkIChtYWpvciAyNTMp
CmlvIHNjaGVkdWxlciBub29wIHJlZ2lzdGVyZWQKaW8gc2NoZWR1bGVyIGRlYWRsaW5lIHJlZ2lz
dGVyZWQgKGRlZmF1bHQpCmlzYXBucDogU2Nhbm5pbmcgZm9yIFBuUCBjYXJkcy4uLgppc2FwbnA6
IE5vIFBsdWcgJiBQbGF5IGRldmljZSBmb3VuZApTZXJpYWw6IDgyNTAvMTY1NTAgZHJpdmVyLCA4
IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVkCnNlcmlhbDgyNTA6IHR0eVMwIGF0IEkvTyAweDNm
OCAoaXJxID0gNCkgaXMgYSAxNjU1MEEKc2VyaWFsODI1MDogdHR5UzEgYXQgSS9PIDB4MmY4IChp
cnEgPSAzKSBpcyBhIDE2NTUwQQpwYXJwb3J0MDogUEMtc3R5bGUgYXQgMHgzNzggW1BDU1BQKCwu
Li4pXQpicmQ6IG1vZHVsZSBsb2FkZWQKbG9vcDogbW9kdWxlIGxvYWRlZApuYmQ6IHJlZ2lzdGVy
ZWQgZGV2aWNlIGF0IG1ham9yIDQzCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBk
cml2ZXIgdWIKVW5pZm9ybSBNdWx0aS1QbGF0Zm9ybSBFLUlERSBkcml2ZXIKcGlpeCAwMDAwOjAw
OjBjLjA6IElERSBjb250cm9sbGVyICgweDgwODY6MHgyNGRiIHJldiAweDAxKQpwaWl4IDAwMDA6
MDA6MGMuMDogbm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwgcHJvYmUgaXJxcyBsYXRlcgogICAg
aWRlMDogQk0tRE1BIGF0IDB4ZWYwMC0weGVmMDcKICAgIGlkZTE6IEJNLURNQSBhdCAweGVmMDgt
MHhlZjBmCmhkYTogU1UwMUcgUkRDIFNELUlERSBIT1NUIENPTlRST0xMRVIsIEFUQSBESVNLIGRy
aXZlCmhkYTogaG9zdCBzaWRlIDgwLXdpcmUgY2FibGUgZGV0ZWN0aW9uIGZhaWxlZCwgbGltaXRp
bmcgbWF4IHNwZWVkIHRvIFVETUEzMwpoZGE6IFVETUEvMzMgbW9kZSBzZWxlY3RlZAppZGUwIGF0
IDB4MWYwLTB4MWY3LDB4M2Y2IG9uIGlycSAxNAppZGUxIGF0IDB4MTcwLTB4MTc3LDB4Mzc2IG9u
IGlycSAxNQppZGUtZ2QgZHJpdmVyIDEuMTgKaGRhOiBtYXggcmVxdWVzdCBzaXplOiAxMjhLaUIK
aGRhOiAxOTMwMjQwIHNlY3RvcnMgKDk4OCBNQikgdy8wS2lCIENhY2hlLCBDSFM9MTkxNC8xNi82
MwogaGRhOiBoZGExIGhkYTIKaWRlLWNkIGRyaXZlciA1LjAwCkRyaXZlciAnc2QnIG5lZWRzIHVw
ZGF0aW5nIC0gcGxlYXNlIHVzZSBidXNfdHlwZSBtZXRob2RzCjw2PnI2MDQwOiBSREMgUjYwNDAg
TkFQSSBuZXQgZHJpdmVyLHZlcnNpb24gMC4yMiAoMjVNYXIyMDA5KQpQUFAgZ2VuZXJpYyBkcml2
ZXIgdmVyc2lvbiAyLjQuMgpQUFAgRGVmbGF0ZSBDb21wcmVzc2lvbiBtb2R1bGUgcmVnaXN0ZXJl
ZApQUFAgQlNEIENvbXByZXNzaW9uIG1vZHVsZSByZWdpc3RlcmVkCmVoY2lfaGNkOiBVU0IgMi4w
ICdFbmhhbmNlZCcgSG9zdCBDb250cm9sbGVyIChFSENJKSBEcml2ZXIKZWhjaV9oY2QgMDAwMDow
MDowYS4xOiBFSENJIEhvc3QgQ29udHJvbGxlcgplaGNpX2hjZCAwMDAwOjAwOjBhLjE6IG5ldyBV
U0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMQplaGNpX2hjZCAwMDAwOjAw
OjBhLjE6IGlycSA5LCBpbyBtZW0gMHhmZWZmZjgwMAplaGNpX2hjZCAwMDAwOjAwOjBhLjE6IFVT
QiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAwCnVzYiB1c2IxOiBjb25maWd1cmF0aW9uICMxIGNob3Nl
biBmcm9tIDEgY2hvaWNlCmh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kCmh1YiAxLTA6MS4wOiAy
IHBvcnRzIGRldGVjdGVkCmVoY2lfaGNkIDAwMDA6MDA6MGIuMTogRUhDSSBIb3N0IENvbnRyb2xs
ZXIKZWhjaV9oY2QgMDAwMDowMDowYi4xOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25l
ZCBidXMgbnVtYmVyIDIKZWhjaV9oY2QgMDAwMDowMDowYi4xOiBpcnEgMTEsIGlvIG1lbSAweGZl
ZmZmYzAwCmVoY2lfaGNkIDAwMDA6MDA6MGIuMTogVVNCIDIuMCBzdGFydGVkLCBFSENJIDEuMDAK
dXNiIHVzYjI6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKaHViIDItMDox
LjA6IFVTQiBodWIgZm91bmQKaHViIDItMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKb2hjaV9oY2Q6
IFVTQiAxLjEgJ09wZW4nIEhvc3QgQ29udHJvbGxlciAoT0hDSSkgRHJpdmVyCm9oY2lfaGNkIDAw
MDA6MDA6MGEuMDogT0hDSSBIb3N0IENvbnRyb2xsZXIKb2hjaV9oY2QgMDAwMDowMDowYS4wOiBu
ZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDMKb2hjaV9oY2QgMDAw
MDowMDowYS4wOiBpcnEgNSwgaW8gbWVtIDB4ZmVmZmQwMDAKdXNiIHVzYjM6IGNvbmZpZ3VyYXRp
b24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKaHViIDMtMDoxLjA6IFVTQiBodWIgZm91bmQKaHVi
IDMtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKb2hjaV9oY2QgMDAwMDowMDowYi4wOiBPSENJIEhv
c3QgQ29udHJvbGxlcgpvaGNpX2hjZCAwMDAwOjAwOjBiLjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVy
ZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgNApvaGNpX2hjZCAwMDAwOjAwOjBiLjA6IGlycSAxMCwg
aW8gbWVtIDB4ZmVmZmUwMDAKdXNiIHVzYjQ6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20g
MSBjaG9pY2UKaHViIDQtMDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDQtMDoxLjA6IDIgcG9ydHMg
ZGV0ZWN0ZWQKSW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uCnVzYmNvcmU6
IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0b3JhZ2UKVVNCIE1hc3MgU3Rv
cmFnZSBzdXBwb3J0IHJlZ2lzdGVyZWQuCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFj
ZSBkcml2ZXIgbGlidXN1YWwKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZl
ciB1bXMtZnJlZWNvbQp1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVt
cy1pc2QyMDAKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JzZXJp
YWwKVVNCIFNlcmlhbCBzdXBwb3J0IHJlZ2lzdGVyZWQgZm9yIGdlbmVyaWMKdXNiY29yZTogcmVn
aXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JzZXJpYWxfZ2VuZXJpYwp1c2JzZXJpYWw6
IFVTQiBTZXJpYWwgRHJpdmVyIGNvcmUKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNl
IGRyaXZlciBlbWkyNiAtIGZpcm13YXJlIGxvYWRlcgp1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBp
bnRlcmZhY2UgZHJpdmVyIGVtaTYyIC0gZmlybXdhcmUgbG9hZGVyClBOUDogTm8gUFMvMiBjb250
cm9sbGVyIGZvdW5kLiBQcm9iaW5nIHBvcnRzIGRpcmVjdGx5LgpzZXJpbzogaTgwNDIgS0JEIHBv
cnQgYXQgMHg2MCwweDY0IGlycSAxCnNlcmlvOiBpODA0MiBBVVggcG9ydCBhdCAweDYwLDB4NjQg
aXJxIDEyCm1pY2U6IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKdXNiY29y
ZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBwb3dlcm1hdGUKcnRjX2Ntb3MgcnRj
X2Ntb3M6IHJ0YyBjb3JlOiByZWdpc3RlcmVkIHJ0Y19jbW9zIGFzIHJ0YzAKcnRjMDogYWxhcm1z
IHVwIHRvIG9uZSBkYXksIDExNCBieXRlcyBudnJhbQpMaW51eCB2aWRlbyBjYXB0dXJlIGludGVy
ZmFjZTogdjIuMDAKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBkYWJ1
c2IKZGFidXNiOiB2MS41NDpEQUItVVNCIEludGVyZmFjZSBEcml2ZXIgZm9yIExpbnV4IChjKTE5
OTkKSVNETiBzdWJzeXN0ZW0gUmV2OiAxLjEuMi4zLzEuMS4yLjMvMS4xLjIuMi8xLjEuMi4zL25v
bmUvMS4xLjIuMgpQUFAgQlNEIENvbXByZXNzaW9uIG1vZHVsZSByZWdpc3RlcmVkCnNkaGNpOiBT
ZWN1cmUgRGlnaXRhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgpzZGhjaTogQ29w
eXJpZ2h0KGMpIFBpZXJyZSBPc3NtYW4Kcmljb2gtbW1jOiBSaWNvaCBNTUMgQ29udHJvbGxlciBk
aXNhYmxpbmcgZHJpdmVyCnJpY29oLW1tYzogQ29weXJpZ2h0KGMpIFBoaWxpcCBMYW5nZGFsZQp3
YnNkOiBXaW5ib25kIFc4M0w1MXhEIFNEL01NQyBjYXJkIGludGVyZmFjZSBkcml2ZXIKd2JzZDog
Q29weXJpZ2h0KGMpIFBpZXJyZSBPc3NtYW4KdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJm
YWNlIGRyaXZlciBoaWRkZXYKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZl
ciB1c2JoaWQKdXNiaGlkOiB2Mi42OlVTQiBISUQgY29yZSBkcml2ZXIKVENQIGN1YmljIHJlZ2lz
dGVyZWQKSW5pdGlhbGl6aW5nIFhGUk0gbmV0bGluayBzb2NrZXQKTkVUOiBSZWdpc3RlcmVkIHBy
b3RvY29sIGZhbWlseSAxNwpSUEM6IFJlZ2lzdGVyZWQgdWRwIHRyYW5zcG9ydCBtb2R1bGUuClJQ
QzogUmVnaXN0ZXJlZCB0Y3AgdHJhbnNwb3J0IG1vZHVsZS4KbGliODAyMTE6IGNvbW1vbiByb3V0
aW5lcyBmb3IgSUVFRTgwMi4xMSBkcml2ZXJzCnJ0Y19jbW9zIHJ0Y19jbW9zOiBzZXR0aW5nIHN5
c3RlbSBjbG9jayB0byAyMDA5LTEyLTMwIDEyOjI3OjQ0IFVUQyAoMTI2MjE3NjA2NCkKdXNiIDMt
MjogbmV3IGZ1bGwgc3BlZWQgVVNCIGRldmljZSB1c2luZyBvaGNpX2hjZCBhbmQgYWRkcmVzcyAy
Cmtqb3VybmFsZCBzdGFydGluZy4gIENvbW1pdCBpbnRlcnZhbCA1IHNlY29uZHMKRVhUMy1mcyB3
YXJuaW5nOiBtYXhpbWFsIG1vdW50IGNvdW50IHJlYWNoZWQsIHJ1bm5pbmcgZTJmc2NrIGlzIHJl
Y29tbWVuZGVkCkVYVDMgRlMgb24gaGRhMSwgaW50ZXJuYWwgam91cm5hbApFWFQzLWZzOiByZWNv
dmVyeSBjb21wbGV0ZS4KRVhUMy1mczogbW91bnRlZCBmaWxlc3lzdGVtIHdpdGggd3JpdGViYWNr
IGRhdGEgbW9kZS4KVkZTOiBNb3VudGVkIHJvb3QgKGV4dDMgZmlsZXN5c3RlbSkgb24gZGV2aWNl
IDM6MS4KRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMjE2ayBmcmVlZAp1c2IgMy0yOiBj
b25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlCmlucHV0OiBDLU1lZGlhIFVTQiBB
dWRpbyBEZXZpY2UgICAgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjBhLjAvdXNiMy8z
LTIvMy0yOjEuMy9pbnB1dC9pbnB1dDAKZ2VuZXJpYy11c2IgMDAwMzowRDhDOjAwMDguMDAwMTog
aW5wdXQ6IFVTQiBISUQgdjEuMDAgRGV2aWNlIFtDLU1lZGlhIFVTQiBBdWRpbyBEZXZpY2UgICBd
IG9uIHVzYi0wMDAwOjAwOjBhLjAtMi9pbnB1dDMKSU5JVDogdmVyc2lvbiAyLjg2IGJvb3RpbmcK
UGxlYXNlIHdhaXQ6IGJvb3RpbmcuLi4KUmVtb3VudGluZyByb290IGZpbGUgc3lzdGVtLi4uCnJv
b3Q6IG1vdW50OiBtb3VudGluZyByb290ZnMgb24gLyBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkKbWtub2Q6IC9kZXYvaW5pdGN0bDogRmlsZSBleGlzdHMKU2V0dGluZyB1cCBJUCBz
cG9vZmluZyBwcm90ZWN0aW9uOiBycF9maWx0ZXIuCkNvbmZpZ3VyaW5nIG5ldHdvcmsgaW50ZXJm
YWNlcy4uLiB1ZGhjcGMgKHYxLjEzLjIpIHN0YXJ0ZWQKU2VuZGluZyBkaXNjb3Zlci4uLgpTZW5k
aW5nIHNlbGVjdCBmb3IgMTAuMTAuMTE4LjEwNy4uLgpMZWFzZSBvZiAxMC4xMC4xMTguMTA3IG9i
dGFpbmVkLCBsZWFzZSB0aW1lIDE0NDAwCmRvbmUuCklOSVQ6IEVudGVyaW5nIHJ1bmxldmVsOiA1
ClN0YXJ0aW5nIERyb3BiZWFyIFNTSCBzZXJ2ZXI6IGRyb3BiZWFyLgpTdGFydGluZyBzeXNsb2dk
L2tsb2dkOiBkb25lCgp2b3J0ZXg4NmR4IGxvZ2luOgo=
--0014852d36cd67c48c047bf210f5--

