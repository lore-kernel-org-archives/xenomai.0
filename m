Message-ID: <2905.69.70.101.145.1170911698.squirrel@domain.hid>
Date: Wed, 7 Feb 2007 21:14:58 -0800 (PST)
From: lobby@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] ADEOS with dcache write through enabled on ARM
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I read a suggestion Michael Neuhauser made on a web page to enable dcache
write through on arm9 processors to improve real time latency on the ARM
CPU.

I tried this on a cirrus EP9302 (ARM 920T) on a TS-7400 board and it does
improve the worst case latency dramaticaly but it causes ramdom
segmentation violations (init process on a idle machine and also user
started processes)

I was wondering if any one has heard of problems on this specific process=
or
when CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy with linux kernel 2.4.26 and ADEO=
S

The problem only happens when ADEOS patches are applied together with
CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy. Having the dcache write through enabl=
ed
without adeos patches works fine.

Please let me know if I missed something.


Thank You

Patrick Robin


