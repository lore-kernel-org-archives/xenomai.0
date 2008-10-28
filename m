Message-Id: <939CEF84-66F5-4B05-A491-74091D527EC4@domain.hid>
From: Alphan Ulusoy <alphan@domain.hid>
Content-Type: multipart/signed; boundary=Apple-Mail-26--52143971; micalg=sha1;
	protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Tue, 28 Oct 2008 19:41:15 +0200
Subject: [Xenomai-help] sock_sendmsg() causes crash
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


--Apple-Mail-26--52143971
Content-Type: text/plain;
	charset=WINDOWS-1252;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Hi all,

I' am trying to send small UDP datagrams in a real-time system. I =20
can't get a satisfactory performance when I send these packets from a =20=

userspace Xenomai task using sendto() call.

That's why I tried to code a small kernel module to make some =20
measurements. However; whenever
	=95 A xenomai task
	=95 An alarm function
	=95 A thread created with kthread_run() form a xenomai task
that includes the sock_sendmsg() call runs, system crashes. However, =20
if a write a regular kernel module, the it works just fine...

Below you can find the code and the crash dump.

Does anyone have any suggestions? Is there any other way that I can =20
send a UDP packet from a kernel Xenomai task?


Best regards,

alphan

------- Code ---------

#include "misc_kernel.h"
#include "ncs_const.h"
#include "xenomai.h"
//TODO: Remove unnecessary includes
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kthread.h>

#include <linux/errno.h>
#include <linux/types.h>

#include <linux/netdevice.h>
#include <linux/ip.h>
#include <linux/in.h>

#include <linux/delay.h>

#define TASK_PRIO   		99              			 =
/* Highest RT priority */
#define TASK_MODE 		T_CPU(0)       	 	/* Bound to CPU =
#0 */
#define TASK_STKSZ  		32000           			=
/* Stack size (in bytes) *=09
#define ALARM_PERIOD 		1000000000
#define INADDR_SEND 		(unsigned long int)0xC0A80204	=
//192.168.2.4 in hex
#define CONNECT_PORT 	6355


MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("Kernel UDP Transmission Latency & Jitter Test =20
Module");

static RT_ALARM aid;
static RT_TASK tid;
static startMarkFrame currentStartMark;
static struct socket* sock_send;
static struct sockaddr_in addr_send;
static struct msghdr msg;
static struct iovec iov;
static mm_segment_t oldfs;

static void coordTask(void *cookie) {

	printk("\n");
	iov.iov_base =3D &currentStartMark;
	iov.iov_len =3D sizeof(currentStartMark);
=09
	msg.msg_flags =3D 0;
	msg.msg_name =3D &addr_send;
	msg.msg_namelen  =3D sizeof(struct sockaddr_in);
	msg.msg_control =3D NULL;
	msg.msg_controllen =3D 0;
	msg.msg_iov =3D &iov;
	msg.msg_iovlen =3D 1;
	msg.msg_control =3D NULL;
=09
	oldfs =3D get_fs();
	printk("21 ");
	set_fs(KERNEL_DS);
	printk("22 ");
	sock_sendmsg(sock_send,&msg,sizeof(currentStartMark));
	printk("23 ");
	set_fs(oldfs);
	printk("24 ");
=09
	currentStartMark.sequenceNumber++;
	printk("25 ");
}

int coordInit(void) {
=09
	int err;

	printk("\nStarting Kernel UDP Transmission Test Module...\n");

	/*								=
*/
	/* Create Socket					*/
	/*								=
*/=09
	if ((err =3D sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, =
&sock_send)) =20
< 0 )
	{
		printk("sock_create() failed with code: %d\n",err);
		goto fail;
	}
	addr_send.sin_family =3D AF_INET;
	addr_send.sin_addr.s_addr =3D htonl(INADDR_SEND);
	addr_send.sin_port =3D htons(CONNECT_PORT);
=09
	if ((err =3D sock_send->ops->connect(sock_send, (struct sockaddr =
=20
*)&addr_send, sizeof(struct sockaddr), 0) < 0 ))
	{
		printk("connect() failed with code: %d \n",err);
		goto fail;
	}
=09

	/*								=
*/
	/* Initialize variables				*/
	/*								=
*/
	currentStartMark.frameType =3D START_MARK_FRAME;
	currentStartMark.sequenceNumber =3D 0x00;

=09
	err =3D rt_task_create(&tid, "Kenrel UDP Task", TASK_STKSZ, =
TASK_PRIO, =20
TASK_MODE);
	if (err) {
		printk("rt_task_create() failed: code %d\n", err);
		goto fail;
	}
=09
=09
	rt_task_start(&tid,&coordTask,NULL);
=09

fail:

	return err;
=09
}

void coordCleanup(void) {
	//rt_alarm_delete(&aid);
	rt_task_delete(&tid);
	printk("\nKernel UDP module removed!\n");
}

module_init(coordInit);
module_exit(coordCleanup);


-------- Stack trace ----------

[  454.999957] Starting Kernel UDP Transmission Test Module...
[  455.021232] 1 2 3 4 5 6 <3>BUG: Unhandled exception over domain =20
Xenomai at 0xc0145cfe - switching to ROOT
[  455.021484] Pid: 3643, comm: insmod Not tainted 2.6.26.5 #9
[  455.021558]  [<c0112351>] __ipipe_handle_exception+0x1b1/0x1c0
[  455.021644]  [<c0145cfe>] __ipipe_restore_root+0x1e/0x30
[  455.021724]  [<c03a7633>] error_code+0x6f/0x7c
[  455.021803]  [<c0326c96>] __alloc_skb+0x36/0x120
[  455.021881]  [<c0145cfe>] __ipipe_restore_root+0x1e/0x30
[  455.021960]  [<c0182795>] kmem_cache_alloc+0x55/0xd0
[  455.022001]  [<c0326c96>] __alloc_skb+0x36/0x120
[  455.022001]  [<c0322c08>] sock_alloc_send_skb+0x168/0x1b0
[  455.022001]  [<c0348611>] ip_append_data+0x711/0x970
[  455.022001]  [<c0349540>] ip_generic_getfrag+0x0/0xb0
[  455.022001]  [<c0364730>] udp_sendmsg+0x2f0/0x660
[  455.022001]  [<c036ab37>] inet_sendmsg+0x37/0x70
[  455.022001]  [<c032062e>] sock_sendmsg+0xbe/0xf0
[  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
[  455.022001]  [<c012ef50>] autoremove_wake_function+0x0/0x50
[  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
[  455.022001]  [<c014bc35>] xnpod_suspend_thread+0x1f5/0x200
[  455.022001]  [<c027e184>] vscnprintf+0x14/0x20
[  455.022001]  [<c011cc04>] printk+0xc4/0xe0
[  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
[  455.022001]  [<f890b238>] coordTask+0xb8/0x104 [deneme2]
[  455.022001]  [<c014c162>] xnarch_thread_redirect+0x32/0x50
[  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
[  455.022001]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[  455.022001] ------------[ cut here ]------------
[  455.022001] kernel BUG at kernel/ipipe/core.c:323!
[  455.022001] invalid opcode: 0000 [#1] PREEMPT
[  455.022001] Modules linked in: deneme2(+) arc4 ecb crypto_blkcipher =20=

cryptomgr crypto_algapi [last unloaded: deneme2]
[  455.022001]
[  455.022001] Pid: 3643, comm: insmod Not tainted (2.6.26.5 #9)
[  455.022001] EIP: 0060:[<c0145cfe>] EFLAGS: 00010202 CPU: 0
[  455.022001] EIP is at __ipipe_restore_root+0x1e/0x30
[  455.022001] EAX: 00000000 EBX: f74586c0 ECX: c0326c96 EDX: c0491b9c
[  455.022001] ESI: 00000000 EDI: c0491b20 EBP: 000000c0 ESP: f7d37870
[  455.022001]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[  455.022001] Process insmod (pid: 3643, ti=3Df7d36000 task=3Df7f2aa20 =20=

task.ti=3Df7512000)<0>
[  455.022001] I-pipe domain Linux
[  455.022001] Stack: c0182795 00000000 00000000 000004d0 00000200 =20
00000000 0000003d 000004d0
[  455.022001]        c0491b20 c0326c96 00000000 f7c3ea00 7fffffff =20
0000000a 000004d0 c0322c08
[  455.022001]        ffffffff 0000003d 00000000 00000000 f74fa700 =20
00000000 00000000 f74fa700
[  455.022001] Call Trace:
[  455.022001]  [<c0182795>] kmem_cache_alloc+0x55/0xd0
[  455.022001]  [<c0326c96>] __alloc_skb+0x36/0x120
[  455.022001]  [<c0322c08>] sock_alloc_send_skb+0x168/0x1b0
[  455.022001]  [<c0348611>] ip_append_data+0x711/0x970
[  455.022001]  [<c0349540>] ip_generic_getfrag+0x0/0xb0
[  455.022001]  [<c0364730>] udp_sendmsg+0x2f0/0x660
[  455.022001]  [<c036ab37>] inet_sendmsg+0x37/0x70
[  455.022001]  [<c032062e>] sock_sendmsg+0xbe/0xf0
[  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
[  455.022001]  [<c012ef50>] autoremove_wake_function+0x0/0x50
[  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
[  455.022001]  [<c014bc35>] xnpod_suspend_thread+0x1f5/0x200
[  455.022001]  [<c027e184>] vscnprintf+0x14/0x20
[  455.022001]  [<c011cc04>] printk+0xc4/0xe0
[  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
[  455.022001]  [<f890b238>] coordTask+0xb8/0x104 [deneme2]
[  455.022001]  [<c014c162>] xnarch_thread_redirect+0x32/0x50
[  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
[  455.022001]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[  455.022001] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 81 3d 20 =20
e8 45 c0 c0 0a 55 c0 75 12 85 c0 74 09 0f ba 2d c0 d4 45 c0 00 c3 e9 =20
a2 ff ff ff <0f> 0b eb fe 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 89 =20=

c1 8b
[  455.022001] EIP: [<c0145cfe>] __ipipe_restore_root+0x1e/0x30 SS:ESP =20=

0068:f7d37870
[  455.022001] ---[ end trace 415d3c300348194e ]---=

--Apple-Mail-26--52143971
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMzCCAuww
ggJVoAMCAQICEFlbEbpcrtRwEgeTD6b7/UYwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDkxMDE4MjkxMFoXDTA5MDkxMDE4Mjkx
MFowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZYWxw
aGFuQHN1LnNhYmFuY2l1bml2LmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKju
oEccePvK+1FqYYzkT3ZagQMkK86SRcJIznx9wqt7mIE6oYI/SjcjURCvuaoU4l0zG3dhC5Jlgg1A
u5xtAQCxd/mrvyRm6fM+AMs+qvyZjVBLqAnHT/HxHTV3Ju5BE4U2G6Dj+x18WuRy/YSj4fihhdAI
AcsPuJri8Dfvusecef7Xam6gcl0kkRexmEDiiMSb3SEziOdjQqAZEArTRMYZYGFANsMJvXzNN76I
qyAkaAcr8IuUoXt0RYwwn2DhUcBTrg1SfIqYdTrWi7TmCVpudfND6hHlz8+RogQi7ohbMbwKFwKa
3gXhcRnc1dABGNnyXDJR1nCWKMHq1KE72DUCAwEAAaM2MDQwJAYDVR0RBB0wG4EZYWxwaGFuQHN1
LnNhYmFuY2l1bml2LmVkdTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBACe45E4PvEZO
ZjwogK3R7lVPLQ4bfNF1hpUDfK0Kgba6jbDlIRSmx0Cz3xgMdC2SGpf3aCu+7PJQa4u0NA2QAlEs
AMI9QFNtu0HhyXKtdR3a7sHRCR4XiczLQUHS4S9LRKueHGvWaVx6jQICMH9lJBlW62gnd2TgOcWP
TGxJWK9YMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTAT
BgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUg
Q29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIG
A1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25h
bC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUA
A4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7
n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAw
QwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJl
ZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRl
TGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aUnX9M
Ibj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowg
T2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAxAwggMMAgEBMHYw
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBZWxG6XK7UcBIHkw+m
+/1GMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTA4MTAyODE3NDExNVowIwYJKoZIhvcNAQkEMRYEFOw07G59RVR+XSvr0KMOX1480EunMIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQCJVNvUbt/7DHszfpaq66ZbWtSZDrG1i9SF3IbLep6cacb3Tj5oUjhu4voDsp8EOnjTxwTz
0RwOvG2TyANush6iSNNQu8K0/aqHrqeoAehsqJpAgVNADTQtuFcNrsKr8q0QNBXrRbztqeaa/7nB
Ds0F6LOSgz8pHsav7S9GbU+gBFkEHB/kOmY9LWbhY161KfXIn4eTE4Afod7Vzv9EzNjTCyt/bTca
L5CA2pbOACPliNG/Ot9aDnTH6NIydHwCizCtAdkiTsRAvshb+6OMaunZdTYArtPOF0h5zssu26J0
1PHkvIXK6bVucyjuQBWCCkYCA2nG0NYkhTXZ18CyARAoAAAAAAAA

--Apple-Mail-26--52143971--

