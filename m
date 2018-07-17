MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Tue, 17 Jul 2018 18:29:35 +0530
Message-ID: <CAFUnMkm=ZaZ5qY1Vbg=WVvt16x+rxfmttCA0mdWVi8wC2K3Duw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_e1000e is not getting loaded : e1000e: rteth0 NIC Link
 is Up 100 Mbps Full Duplex, Flow Control: None
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am starting rtnet and using dmesg I get this output

e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
[ 2141.574339] rt_e1000e: 10/100 speed: disabling TSO

rt_e1000e is not getting loaded in rteth0

e1000e: rteth0 NIC Link is Up 100 Mbps, e1000e is only getting loaded
instead of rt_e1000e

I don=E2=80=99t find any difference in eth0 and rteth0,

I am using SOEM ethercat protocol for controlling servo drive and *EL5101*
| Incremental *encoder* interface

can you help to to get load the rt_e1000e.

Thank you
Ashok
