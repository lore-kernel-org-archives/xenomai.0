From: Nihar Unadkat <Nihar@deltatau.com>
Subject: RE: Xenomai IRQ move frpm cpu0 to cpu1
Date: Fri, 18 Jan 2019 00:24:56 +0000
Message-ID: <DM5PR11MB19476886419C6FF55B87B32DD19C0@DM5PR11MB1947.namprd11.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello

I need some help.

I want to move my IRQ27 which is a phase interrupt that is on cpu0 to cpu1.=
 Please see below
I used the following command to see the info below.
$ cat /proc/xenomai/irq

IRQ         CPU0            CPU1        CPU2        CPU3
17:       96300          133398       19460       15531                  [t=
imer]
27:      267379           0                   0           0                =
              UBUS_Phase
28:           0                 0                   0           0          =
                    UBUS_Servo
29:           0                0                    0           0          =
                    UBUS_Capture
1033:        0                0                    0           0           =
                   [sync]
1034:        1                1                    1           0           =
                   [timer-ipi]
1035:        3            65233              4           3                 =
             [reschedule]
1036:        0               0                     0           0           =
                    [virtual]
1040:        62             64                  0           0              =
                [virtual]

How can I move my IRQ27 from cpu0 to cpu1 using xenomai functions.  Could y=
ou please given me an example or advise me as to how to do so.

I was able to do the above move for IRQ27 from cpu0 to cpu1 in Linux, but I=
 cannot do it in xenomai.

Any help would greatly be appreciated

Thank you.
[NiharUnadkatSignature]
Nihar Unadkat
Senior Firmware Engineer
Direct: 818-444-5206
nihar@deltatau.com<mailto:nihar@deltatau.com>

OMRON DELTA TAU
21314 Lassen Street, Chatsworth, CA 91311
deltatau.com<https://www.youtube.com/user/DeltaTauDataSystems> <https://www=
.youtube.com/user/DeltaTauDataSystems>
youtube.com/DeltaTauDataSystems<https://www.youtube.com/user/DeltaTauDataSy=
stems>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.png
Type: image/png
Size: 28011 bytes
Desc: image001.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20190118/28214caf/at=
tachment.png>
