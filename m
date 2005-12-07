Message-ID: <38086.128.93.12.158.1133967095.squirrel@domain.hid>
Date: Wed, 7 Dec 2005 15:51:35 +0100 (CET)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Xenomai-PPC: One problem
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

Hi everybody,

thanks to your help now the interrupt shield option compile OK :)

Unfortunately, I must to leave the Xenomai FPU option disabled.

With this option active my PowerBook "Ubuntu-Xenomai" machine go crazy after
few seconds after the launch of the the "latency" test.

Gilles suspects that there is a conflict with the Altivec FPU units inside
the G4 CPU, because ADEOS does not save the Altivec FPU-exended register.

I think that I can live and prosper without FPU support in the kernel, but I
suppose also that someone is interested in this - possibile - limitation e/o
potential bug.

Simone Mannori





