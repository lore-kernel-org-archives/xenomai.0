Date: Mon, 15 Mar 2004 05:53:43 -0300
From: Vitor Angelo <vitor@domain.hid>
Subject: Re:  [Adeos-main] 260 uSec latency and no idea why
Message-ID: <20040315085343.GA3821@domain.hid>
Reply-To: Vitor Angelo <vitor@domain.hid>
References: <200403110326.33694.roloff@domain.hid> <200403120422.44317.roloff@domain.hid> <40520537.2030701@domain.hid> <200403130000.34021.roloff@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <200403130000.34021.roloff@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Dirk,

# Any updates on INTEL 82801EB I/O Controller Hub (ICH5)
# 
# Dirk

could you please test the attached code? You should do a

echo enable > /proc/smi/global

and a

echo disable > /proc/smi/global

to test if the "global SMI bit" changes anything for you.

The other entries under /proc/smi are not important, unless you want to
test changes in BIOS or ACPI, doing a "cat /proc/smi/...". The "global
SMI bit" should override everything.

Regards,

Vitor.


--zhXaljGHf11kAtnf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="smi.tar.bz2"
Content-Transfer-Encoding: base64

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
UJDFZ/w7

--zhXaljGHf11kAtnf--

