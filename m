From: Andreas Glatz <andreasglatz@domain.hid>
Content-Type: multipart/mixed; boundary="=-WWIfs0ENVB49lo/QVzA7"
Date: Wed, 18 Mar 2009 12:31:35 -0400
Message-Id: <1237393895.5495.7.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-core] Kernel crash in xnheap_test_and_free (native/heap.c)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--=-WWIfs0ENVB49lo/QVzA7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I got a kernel crash because inside xnheap_test_and_free a 
invalid pointer contained in variable 'nextpage' is dereferenced:

<snip>
free_pages:
  /* Mark the released pages as free in the extent's page map. */
  for (pagecont = 0; pagecont < npages; pagecont++)
       extent->pagemap[pagenum + pagecont].type = XNHEAP_PFREE;

  /* Return the sub-list to the free page list, keeping
     an increasing address order to favor coalescence. */

  for (nextpage = extent->freelist, lastpage = NULL;
       nextpage != NULL && nextpage < (caddr_t) block;
       lastpage = nextpage, 
////////////////////////
/* PROBLEM IS HERE => */  nextpage = *((caddr_t *) nextpage))
////////////////////////
  ; /* Loop */
</snip>


This error occurs when running the test application on our 
PowerPC target as well as when running it on the x86 host 
with the newest version of Xenomai (2.4.7).

Target setup:
- Xenomai 2.4.4
- Linux 2.6.26
- PowerPC

Host setup:
- Xenomai 2.4.7
- Linux 2.6.26
- i686

You should be able to confirm my problem with 'rtpipetest', a 
small application of which the source code is attached to this 
Email.

I got the kernel crash after the following sequence of commands (and
the kernel doesn't crash if I DON'T do the 'echo f> /dev/rtp0'): 

rr10:~# ./rtpipetest &
[1] 2568
rr10:~# Info: rt_pipe_stream is full (ret=0)
cat /dev/rtp0
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
^C
rr10:~# echo f> /dev/rtp0
rr10:~# kill -s SIGINT 2568
rr10:~# 


This is the error report from our target. The error report
on the host also tells me that the kernel crashed in 
'xnheap_test_and_free'...

Unable to handle kernel paging request for data at address 0x64646464
Faulting instruction address: 0xc0054324
Oops: Kernel access of bad area, sig: 11 [#1]
RC8360 CM
Modules linked in: lm75 max6369_wdt rtc_ds1307
NIP: c0054324 LR: c006e4e4 CTR: 00000000
REGS: df13fd80 TRAP: 0300   Not tainted  (2.6.26-1-8360e)
MSR: 00001032 <ME,IR,DR>  CR: 24002488  XER: 00000000
DAR: 64646464, DSISR: 20000000
TASK = df899ce0[2568] 'main' THREAD: df13e000
GPR00: 00000000 df13fe30 df899ce0 e100e9f8 00000009 00000000 c9b26c9b
00000000 
GPR08: df052240 64646464 00000002 64646464 84004028 1001a6f0 df13ff50
c0392f80 
GPR16: c0375eac ffffffff fffeffff 00000040 00000010 c0360000 00000400
00000001 
GPR24: 00000004 0000000a 00000000 e100e9f8 c0360000 df052240 df052040
df052000 
NIP [c0054324] xnheap_test_and_free+0x2c4/0x3cc
LR [c006e4e4] rt_pipe_delete+0xf0/0x158
Call Trace:
[df13fe30] [c005dbb8] xntimer_start_aperiodic+0x2dc/0x2e4 (unreliable)
[df13fe70] [c006e4e4] rt_pipe_delete+0xf0/0x158
[df13fe90] [c0068d00] __rt_pipe_delete+0x74/0xac
[df13feb0] [c0060c00] hisyscall_event+0x1cc/0x2c4
[df13fee0] [c0051a38] __ipipe_dispatch_event+0x110/0x21c
[df13ff30] [c0009694] __ipipe_syscall_root+0x40/0xe8
[df13ff40] [c0010f44] DoSyscall+0x20/0x5c
--- Exception: c01 at 0xff7ecdc
    LR = 0xff7ecb4
Instruction dump:
5529103a 7d3f4a14 98090004 4200ffe8 813f0010 2f890000 419e0040 7f89f040 
41bc000c 48000034 40980018 7d2b4b78 <81290000> 2f890000 7f09f040
409effec 
---[ end trace 90e6f47d0e66c1c4 ]---

--=-WWIfs0ENVB49lo/QVzA7
Content-Disposition: attachment; filename=rtpipetest.c
Content-Type: text/x-csrc; name=rtpipetest.c; charset=UTF-8
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHJ0ZGsuaD4NCiNpbmNsdWRlIDxuYXRpdmUvcGlwZS5oPg0KI2luY2x1ZGUgPG5h
dGl2ZS90YXNrLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCiNp
bmNsdWRlIDxzeXMvbW1hbi5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxp
Yi5oPg0KDQpzdGF0aWMgUlRfVEFTSwltX3Rhc2s7DQpzdGF0aWMgUlRfUElQRQltX3BpcGU7DQoN
CiNkZWZpbmUgcmNfZXJyb3IoZm4sIHJldCkJcnRfcHJpbnRmKCJFcnJvcjogIiBmbiAiOiVzICgl
ZCkgJXNcbiIsIHN0cmVycm9yKC1yZXQpLCAtcmV0KQ0KDQppbnQgbWFpbih2b2lkKQ0Kew0KCWlu
dAkJCWVycjsNCgljb25zdCBjaGFyKglvdXRfc3RyCQk9ICJkIjsNCglpbnQJCQlvdXRfc3RyX2xl
bgk9IDE7DQoJaW50CQkJaW5fc3RyX2xlbgk9IDMyOw0KCWNoYXIJCWluX3N0cltpbl9zdHJfbGVu
XTsNCg0KCS8vIExvY2sgcGFnZXMgaW4gbWVtb3J5DQoJbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNM
X0ZVVFVSRSk7DQoNCgkvLyBJbml0IHJ0ZGsgZnJhbWV3b3JrIGZvciBydF9wcmludGYNCglydF9w
cmludF9hdXRvX2luaXQoMSk7DQoNCgkvLyBBZGQgcnQgc2hhZG93DQoJZXJyCT0gcnRfdGFza19z
aGFkb3coJm1fdGFzaywgIm1haW4iLCAyMiwgMCk7DQoJaWYoZXJyKSB7DQoJCXJjX2Vycm9yKCJy
dF90YXNrX3NoYWRvdyIsIGVycik7DQoJCXJldHVybiBlcnI7DQoJfQ0KDQoJLy8gQ3JlYXRlIHBp
cGUNCgllcnIJPSBydF9waXBlX2NyZWF0ZSgmbV9waXBlLCAicnRwMCIsIDAsIDIwNDgpOw0KCWlm
KGVycikgew0KCQlyY19lcnJvcigicnRfcGlwZV9jcmVhdGUiLCBlcnIpOw0KCQlnb3RvIGNsZWFu
dXA7DQoJfQ0KDQoJLy8gRGVsaWJlcmF0ZWx5IGZpbGwgcGlwZSB3aXRob3V0IGEgcmVhZGVyIG9u
DQoJLy8gdGhlIG90aGVyIHNpZGUuLi4NCgl3aGlsZSgxKSB7DQoJCWVycgk9IHJ0X3BpcGVfc3Ry
ZWFtKCZtX3BpcGUsIG91dF9zdHIsIG91dF9zdHJfbGVuKTsNCgkJLy8gQ2hlY2sgaWYgdGhlcmUg
d2FzIGFuIGVycm9yDQoJCWlmKGVyciA8IDApIHsNCgkJCXJjX2Vycm9yKCJydF9waXBlX3N0cmVh
bSIsIGVycik7DQoJCQlnb3RvIGNsZWFudXA7DQoJCX0NCgkJLy8gQ2hlY2sgaWYgYWxsIGJ5dGVz
IHdoZXJlIHdyaXR0ZW4gdG8gdGhlIHBpcGUNCgkJaWYoZXJyICE9IG91dF9zdHJfbGVuKSB7DQoJ
CQlydF9wcmludGYoIkluZm86IHJ0X3BpcGVfc3RyZWFtIGlzIGZ1bGwgKHJldD0lZClcbiIsIGVy
cik7DQoJCQlicmVhazsNCgkJfQ0KCX0NCg0KCS8vIFdhaXQgZm9yIHRoZSB1c2VyIHRvIGNvbm5l
Y3QgdG8gdGhlIHBpcGUgYW5kIA0KCS8vIGxvb3AgdW50aWwgd2UgYXJlIGFibGUgdG8gcmVhZCBh
IGJ5dGUNCgl3aGlsZSgxKSB7DQoJCWVycgk9IHJ0X3BpcGVfcmVhZCgmbV9waXBlLCBpbl9zdHIs
IGluX3N0cl9sZW4sIFRNX05PTkJMT0NLKTsNCgkJaWYoZXJyIDwgMCAmJiBlcnIgIT0gLUVBR0FJ
Tikgew0KCQkJcmNfZXJyb3IoInJ0X3BpcGVfcmVhZCIsIGVycik7DQoJCQlnb3RvIGNsZWFudXA7
DQoJCX0NCgkJLy8gQ2hlY2sgaWYgd2UgcmVjZWl2ZWQgc29tZXRoaW5nCQ0KCQlpZihlcnIgPiAw
KSB7DQoJCQlydF9wcmludGYoIlJlY2VpdmVkOiAlc1xuIiwgaW5fc3RyKTsNCgkJCWJyZWFrOw0K
CQl9DQoNCgkJLy8gV2FpdCAxbXMNCgkJcnRfdGFza19zbGVlcCgxMDAwMDAwKTsNCgl9DQoNCmNs
ZWFudXA6DQoJcnRfcGlwZV9kZWxldGUoJm1fcGlwZSk7DQoJcnRfdGFza19kZWxldGUoJm1fdGFz
ayk7DQoJcmV0dXJuIGVycjsNCn0NCg==


--=-WWIfs0ENVB49lo/QVzA7--

