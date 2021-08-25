From: Neeraj Agrawal <Neeraj.Agrawal@Renishaw.com>
Subject: CPU core reservation and Latency setting via config
Date: Wed, 25 Aug 2021 08:16:26 +0000
Message-ID: <VI1PR0402MB355162B4233519B0D3D0D451FEC69@VI1PR0402MB3551.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Hello,
Seeking advice on two separate issues. One of them may be just the document=
ation.

Setup is:
                Building via buildroot
                [Xenomai] Cobalt v3.0.10 is running over qemu with 2 CPUs.
                Linux version 4.14.111.
                bootargs: isolcpus=3D1 processor.max_cstate=3D0 intel_idle.=
max_cstate=3D0 nosoftlockup=3D0 rcu_nocbs=3D1 irqaffinity=3D0 tsc=3Dreliabl=
e .....

Issue 1\ Latency setting:
Referring to https://xenomai.org/documentation/xenomai-3/html/man1/autotune=
/index.html
-enabling CONFIG_XENO_OPT_AUTOTUNE does create entry as '/dev/rtdm/autotune=
' in target.
-setting XENO_OPT_TIMING_SCHEDLAT does NOT reflect in '/proc/xenomai/clock/=
coreclk'
-enabling BR2_PACKAGE_XENOMAI_ANALOGY does build autotune application, but =
running it on target also does NOT reflect XENO_OPT_TIMING_SCHEDLAT setting=
 in '/proc/xenomai/clock/coreclk'

Is my expectation correct that statically defined gravity values should ref=
lect in coreclk?
-If so, how could it be achieved?
-If not, then how to verify if the values are set/used correctly?


Issue 2\ CPU cores distribution:
If bootargs have both ("isolcpus=3D1 maxcpus=3D1"), ie:
                isolcpus=3D1 maxcpus=3D1 processor.max_cstate=3D0 intel_idl=
e.max_cstate=3D0 nosoftlockup=3D0 rcu_nocbs=3D1 irqaffinity=3D0 tsc=3Drelia=
ble .....
Then i get a boot time crash. [Could not collect the log, but crash indicat=
e somewhere in i-pipe]
Idea behind this is to force Linux to use 1st CPU, there by leaving 2nd CPU=
 dedicated for Xenomai. Either of the entry alone works (but not together).
[Also tried xenomai.supported_cpus=3D0x02 without success].

Any advice whether it is feasible to boot Xenomai with both these bootargs =
on my setup?
If so, where i could look into for bootup crash?


Regards
Neeraj

---------------------------------------------------------------------------=
------------------------------------------------------------
This email and any attachments are confidential and are for the use of the
addressee only. If you are not the addressee, you must not use or disclose =
the
contents to any other person. Please immediately notify the sender and
delete the email. Statements and opinions expressed here may not
represent those of the company. Email correspondence is monitored by
the company. This information may be subject to export control
regulation. You are obliged to comply with such regulations.
Our data privacy notice<http://www.renishaw.com/privacy> sets out how any p=
ersonal data that we collect about you will be handled.

Renishaw plc (company number 1106260), Renishaw UK Sales Limited (company n=
umber 1418812),
and Wotton Travel Limited (company number 01973158) are companies registere=
d in England
and Wales with a registered office at New Mills, Wotton-under-Edge, Glouces=
tershire, GL12 8JR, United Kingdom.
Renishaw Neuro Solutions Limited (company number 10375761) is a company reg=
istered in England and Wales
with a registered office at Charfield Road, Wotton-under-Edge, Gloucestersh=
ire, GL12 8SP, United Kingdom.
Telephone +44 1453 524524
---------------------------------------------------------------------------=
------------------------------------------------------------
