From: Kronander Klas <klas.kronander@epfl.ch>
Date: Wed, 4 Jul 2012 10:59:32 +0000
Message-ID: <D1DC5191D5CF3A45A867CD95644B92392162E0C5@REXMF.intranet.epfl.ch>
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>, 
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
	<4FEC3FF0.1050307@grandegger.com>,	<4FEC4245.9090804@grandegger.com>
	<D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>
	<4FEC46B5.7060700@grandegger.com> <4FEC5381.9040804@epfl.ch>
	<4FEC570A.8040406@grandegger.com> <4FEC5BD9.4060105@grandegger.com>
	<4FEC819D.2080804@epfl.ch> <4FEC8259.2090300@xenomai.org>
	<4FEC8A85.4050506@epfl.ch>,<4FEC8AFB.5070002@xenomai.org>
In-Reply-To: <4FEC8AFB.5070002@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=
=0A=
I still have the same issues, with identical results with either of the fou=
r different kernel versions and corresponding adeos patches I have tried. =
=0A=
=0A=
After having booted into the kernel and installed the user-space xenomai li=
braries, none of the tests in /usr/xenomai/bin works. If i configure with -=
-enable-dlopen-skins i get the following result from ./usr/xenomai/bin/cloc=
ktest:=0A=
=3D=3D Tested clock: 0 (CLOCK_REALTIME)=0A=
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]=0A=
--- -------------------- ---------------- ---------- --------------=0A=
  0                  0.0            0.000          0            0.0=0A=
  1                  0.0            0.000          0            0.0=0A=
  2                  0.0            0.000          0            0.0=0A=
  3                  0.0            0.000          0            0.0=0A=
=0A=
If run the xenomai ./configure script without any arguments and then build =
and install, I get the following message when running ./usr/xenomai/bin/clo=
cktest:=0A=
Xenomai Posix skin init: pthread_setschedparam: Function not implemented=0A=
=0A=
As before, looking in the syslog it appears that Xenomai is up and running:=
=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.089906] I-pipe: Domain Xenomai r=
egistered.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.089995] Xenomai: hal/i386 starte=
d.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.090031] Xenomai: scheduling clas=
s idle registered.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.090032] Xenomai: scheduling clas=
s rt registered.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.090874] Xenomai: real-time nucle=
us v2.6.0 (Movin' On) loaded.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.091059] Xenomai: starting native=
 API services.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.091061] Xenomai: starting POSIX =
services.=0A=
Jul  4 12:33:45 wam-desktop kernel: [    2.091085] Xenomai: starting RTDM s=
ervices.=0A=
=0A=
=0A=
Thanks in advance for any ideas or suggestions on finding the issue,=0A=
Klas=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: 28 June 2012 18:48=0A=
To: Kronander Klas=0A=
Cc: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem=0A=
=0A=
On 06/28/2012 06:47 PM, Klas Kronander wrote:=0A=
> On 2012-06-28 18:12, Gilles Chanteperdrix wrote:=0A=
>> On 06/28/2012 06:09 PM, Klas Kronander wrote:=0A=
>>>=0A=
>>> On 2012-06-28 15:27, Wolfgang Grandegger wrote:=0A=
>>>> On 06/28/2012 03:07 PM, Wolfgang Grandegger wrote:=0A=
>>>>> On 06/28/2012 02:52 PM, Klas Kronander wrote:=0A=
>>>>>> Hi,=0A=
>>>>>>=0A=
>>>>>> ok did that. The return value from rt_dev_socket is -14. I could not=
=0A=
>>>>>> find the definition of EPROTONOSUPPORT anywhere, so I don't know if =
this=0A=
>>>>>> was the expected value?=0A=
>>>>> ~$ errno 14=0A=
>>>>> #define   EFAULT          14      /* Bad address */=0A=
>>>>>=0A=
>>>>> Hm, strange. I have to look that up.=0A=
>>>> To better understand what you are doing... are you using a Xenomai=0A=
>>>> enabled kernel? Does the latency test work?=0A=
>>>>=0A=
>>>> Wolfgang.=0A=
>>> Yes, I am using a Xenomai enabled kernel. None of the tests seem to wor=
k=0A=
>>> though.=0A=
>>>=0A=
>>> clocktest just gives me zeros. latency does not show anything. I have=
=0A=
>>> tried to recompile the kernel, still the same result. How find out=0A=
>>> what's wrong? I followed the guidlines on the xenomai website for the=
=0A=
>>> kernel configuration.=0A=
>> http://www.xenomai.org/index.php/Configuring_x86_kernels#Does_Xenomai_wo=
rk.3F=0A=
>>=0A=
>=0A=
> In the syslog it seems as xenomai was initialized properly. The mesages=
=0A=
> correspond to those on the faq. I also looked through the=0A=
> troubleshooting file, nothing there seems to help my case. I will try to=
=0A=
> redo everything again with a different kernel version to see if that=0A=
> helps. Any other ideas?=0A=
=0A=
If you are using gcc 4.6.1, please pass CFLAGS=3D-fno-omit-frame-pointer=0A=
on the configure script command line.=0A=
=0A=
--=0A=
                                            Gilles.=0A=

