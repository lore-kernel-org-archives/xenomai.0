Message-ID: <1743f3b40808290145s26f4fa4dp82abee4b8a66fcbf@domain.hid>
Date: Fri, 29 Aug 2008 10:45:34 +0200
From: "Antonio Del Cinque" <adelcinque@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3730_30085536.1219999534516"
Subject: [Xenomai-help] RTDM driver examples compile problems
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

------=_Part_3730_30085536.1219999534516
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I'm trying to port Xenomai to the new PowerPC-based MPC5121e micro from
Freescale. I'm using the toolchain included in the LTIB (Linux Target Image
Builder) envirnoment from Freescale.
I've got problems when compiling the RTDM xenomai examples. It seems that a
"-m64" option is used, which is not supported, but I cannot see how to
disable it. I'm not an expert (really a newbie!) so excuse me, maybe this is
not an issue at all. The output is:

make -C ../linux-2.6.24
SUBDIRS=/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0
modules
make[1]: Entering directory
`/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/linux-2.6.24'
  CC [M]
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/heartbeat.o
  CC [M]
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut01-skeleton-drv.o
  CC [M]
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut02-skeleton-drv.o
cc1: error: unrecognized command line option "-mno-red-zone"
cc1: error: unrecognized command line option "-mcmodel=kernel"
cc1: error: unrecognized command line option "-maccumulate-outgoing-args"
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/heartbeat.c:1:
error: -m64 not supported in this configuration
cc1: error: unrecognized command line option "-mno-red-zone"
cc1: error: unrecognized command line option "-mcmodel=kernel"
cc1: error: unrecognized command line option "-maccumulate-outgoing-args"
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut02-skeleton-drv.c:1:
error: -m64 not supported in this configuration
cc1: error: unrecognized command line option "-mno-red-zone"
cc1: error: unrecognized command line option "-mcmodel=kernel"
cc1: error: unrecognized command line option "-maccumulate-outgoing-args"
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut01-skeleton-drv.c:1:
error: -m64 not supported in this configuration
make[2]: ***
[/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/heartbeat.o]
Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: ***
[/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut02-skeleton-drv.o]
Error 1
make[2]: ***
[/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut01-skeleton-drv.o]
Error 1
make[1]: ***
[_module_/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0]
Error 2
make[1]: Leaving directory
`/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/linux-2.6.24'
make: *** [all] Error 2
error: Bad exit status from
/home/antonio/tools/ltib-mpc5121ads-20080528/tmp/rpm-tmp.55885 (%build)

Thanks
Antonio

------=_Part_3730_30085536.1219999534516
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all,<br>I&#39;m trying to port Xenomai to the new PowerPC-based MPC5121e micro from Freescale. I&#39;m using the toolchain included in the LTIB (Linux Target Image Builder) envirnoment from Freescale. <br>
I&#39;ve got problems when compiling the RTDM xenomai examples. It seems that a &quot;-m64&quot; option is used, which is not supported, but I cannot see how to disable it. I&#39;m not an expert (really a newbie!) so excuse me, maybe this is not an issue at all. The output is:<br>
<br>make -C ../linux-2.6.24 SUBDIRS=/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0 modules<br>make[1]: Entering directory `/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/linux-2.6.24&#39;<br>
&nbsp; CC [M]&nbsp; /home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/heartbeat.o<br>&nbsp; CC [M]&nbsp; /home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut01-skeleton-drv.o<br>&nbsp; CC [M]&nbsp; /home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut02-skeleton-drv.o<br>
cc1: error: unrecognized command line option &quot;-mno-red-zone&quot;<br>cc1: error: unrecognized command line option &quot;-mcmodel=kernel&quot;<br>cc1: error: unrecognized command line option &quot;-maccumulate-outgoing-args&quot;<br>
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/heartbeat.c:1: error: -m64 not supported in this configuration<br>cc1: error: unrecognized command line option &quot;-mno-red-zone&quot;<br>cc1: error: unrecognized command line option &quot;-mcmodel=kernel&quot;<br>
cc1: error: unrecognized command line option &quot;-maccumulate-outgoing-args&quot;<br>/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut02-skeleton-drv.c:1: error: -m64 not supported in this configuration<br>
cc1: error: unrecognized command line option &quot;-mno-red-zone&quot;<br>cc1: error: unrecognized command line option &quot;-mcmodel=kernel&quot;<br>cc1: error: unrecognized command line option &quot;-maccumulate-outgoing-args&quot;<br>
/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut01-skeleton-drv.c:1: error: -m64 not supported in this configuration<br>make[2]: *** [/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/heartbeat.o] Error 1<br>
make[2]: *** Waiting for unfinished jobs....<br>make[2]: *** [/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut02-skeleton-drv.o] Error 1<br>make[2]: *** [/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0/tut01-skeleton-drv.o] Error 1<br>
make[1]: *** [_module_/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.0] Error 2<br>make[1]: Leaving directory `/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/linux-2.6.24&#39;<br>make: *** [all] Error 2<br>
error: Bad exit status from /home/antonio/tools/ltib-mpc5121ads-20080528/tmp/rpm-tmp.55885 (%build)<br><br>Thanks<br>Antonio<br></div>

------=_Part_3730_30085536.1219999534516--

