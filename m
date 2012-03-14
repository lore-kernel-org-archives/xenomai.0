From: Chris Stone <chris.stone@domain.hid>
Date: Wed, 14 Mar 2012 17:59:57 +0000
Message-ID: <623784B6C75D274389918D358E89E8BB0B78EBC6@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_623784B6C75D274389918D358E89E8BB0B78EBC6OPTELIAN5opteli_"
MIME-Version: 1.0
Subject: [Xenomai-help] Should posix threads show up in /proc/xenomai/sched.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_623784B6C75D274389918D358E89E8BB0B78EBC6OPTELIAN5opteli_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Using the "Porting POSIX applications to Xenomai" document I have ported an=
 existing application to Xenomai. We create multiple threads in our applica=
tion and I have the following questions related to posix threads (I could n=
ot find an answer in a search of xenomai-help):

If the threads are running in primary mode, should they be listed in /proc/=
xenomai/sched? My threads show up, with the correct real time priorities, w=
hen I do a top -H, but they are not in /proc/xenomai/sched, so does that me=
an they are all running in secondary mode?

# top -H -b -n 1
top - 17:00:45 up 0 min,  2 users,  load average: 0.04, 0.01, 0.01
Tasks: 104 total,   1 running, 103 sleeping,   0 stopped,   0 zombie
Cpu(s):  3.6%us,  5.0%sy,  0.0%ni, 88.1%id,  2.1%wa,  0.0%hi,  1.1%si,  0.0=
%st
Mem:    254980k total,    58192k used,   196788k free,        0k buffers
Swap:        0k total,        0k used,        0k free,    11908k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 1179 root      20   0  1392  616  424 R  7.4  0.2   0:00.08 top
  992 root     -71   0 46388  44m 6860 S  1.9 17.9   0:00.02 mgt200
    1 root      20   0  1364  432  352 S  0.0  0.2   0:00.99 init
    2 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kthreadd
    4 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kworker/0:0
    5 root      20   0     0    0    0 S  0.0  0.0   0:00.08 kworker/u:0
    6 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 khelper
   91 root      20   0     0    0    0 S  0.0  0.0   0:00.00 sync_supers
   93 root      20   0     0    0    0 S  0.0  0.0   0:00.00 bdi-default
   94 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 kblockd
    3 root      20   0     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
  122 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 rpciod
  123 root      20   0     0    0    0 S  0.0  0.0   0:00.60 kworker/0:1
  186 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 gatekeeper/0
  188 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kswapd0
  189 root      20   0     0    0    0 S  0.0  0.0   0:00.00 fsnotify_mark
  190 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 unionfs_siod
  191 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 nfsiod
  192 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 crypto
    7 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kworker/u:1
  789 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock1
  794 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock2
  799 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock3
  105 root      20   0     0    0    0 S  0.0  0.0   0:00.03 khubd
  814 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock5
  819 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock6
  824 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock7
  829 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock8
  840 root      20   0     0    0    0 S  0.0  0.0   0:00.00 ubi_bgt0d
  843 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock9
  848 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock10
  853 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock11
  858 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock12
  892 root      20   0     0    0    0 S  0.0  0.0   0:00.00 flush-0:13
  900 root      20   0  1348  284  224 S  0.0  0.1   0:00.03 syslogd
  902 root      20   0  1348  272  208 S  0.0  0.1   0:00.06 klogd
  919 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 ff407000.spi
  963 root      20   0  1740  556  424 S  0.0  0.2   0:00.01 ntpd
  966 root      20   0  3072  820  596 S  0.0  0.3   0:00.00 sshd
  968 root      20   0  1372  528  428 S  0.0  0.2   0:00.02 sh
  972 root      -2   0 46388  44m 6860 S  0.0 17.9   0:02.00 mgt200
  973 root      20   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
  974 root     -36   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
  975 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
  977 root      -2   0 46388  44m 6860 S  0.0 17.9   0:00.06 mgt200
  978 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  979 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  980 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  981 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  982 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  983 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  984 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  985 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  986 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  987 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  988 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  989 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  990 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  991 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 canSlotSendThr=
e
  784 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock0
  993 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.01 mgt200
  994 root     -75   0 46388  44m 6860 S  0.0 17.9   0:00.01 mgt200
  995 root     -75   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
  804 root      20   0     0    0    0 S  0.0  0.0   0:00.00 mtdblock4
 1000 root     -54   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1001 root     -55   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1002 root     -59   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1003 root     -36   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1004 root     -45   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1005 root     -45   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1006 root     -45   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1009 root     -43   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1012 root     -43   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1013 root     -36   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1014 root     -46   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1015 root     -46   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1016 root     -46   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1017 root     -57   0 46388  44m 6860 S  0.0 17.9   0:00.00 cliTask
 1018 root     -53   0 46388  44m 6860 S  0.0 17.9   0:00.00 ttyCliInterfac=
e
 1019 root     -57   0 46388  44m 6860 S  0.0 17.9   0:00.00 cliTask
 1020 root     -53   0 46388  44m 6860 S  0.0 17.9   0:00.00 ttyCliInterfac=
e
 1021 root     -57   0 46388  44m 6860 S  0.0 17.9   0:00.00 cliTask
 1022 root     -57   0 46388  44m 6860 S  0.0 17.9   0:00.00 cliTask
 1023 root     -57   0 46388  44m 6860 S  0.0 17.9   0:00.00 cliTask
 1024 root     -57   0 46388  44m 6860 S  0.0 17.9   0:00.00 cliTask
 1025 root     -36   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1026 root     -71   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1027 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.01 SNMPTimerServi=
c
 1028 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 SNMPCntrMon
 1029 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 SNMPGaugeMon
 1030 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 SNMPStringMon
 1031 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 tl1TimerMgmt
 1032 root     -56   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200
 1033 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 SNMPMain
 1034 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 SNMPTrap
 1035 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.04 tl1Server
 1036 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 tl1AsyncClient
 1037 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 tl1AsyncClient
 1038 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 tl1SendMsg
 1039 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 tl1MsgHdlr
 1040 root     -52   0 46388  44m 6860 S  0.0 17.9   0:00.00 tl1AlarmHdlr
 1084 root      20   0  5692 1652 1344 S  0.0  0.6   0:00.07 sshd
 1094 root      20   0  1368  524  428 S  0.0  0.2   0:00.01 sh
  999 root     -58   0 46388  44m 6860 S  0.0 17.9   0:00.00 mgt200

# cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT
  0  972    rt       1      -         master     X          mgt200

If one thread of an application goes into secondary mode, does it drag all =
the other threads with it into secondary mode?

If the main application threads goes into secondary mode, does it drag all =
of the child threads with it into secondary mode?

Cheers,
   Chris.

Chris Stone
Senior Software Engineer
Optelian
1 Brewer Hunt Way
Ottawa, Ontario K2K 2B5

Phone: 613-287-2000 x2106

www.optelian.com<http://www.optelian.com>


--_000_623784B6C75D274389918D358E89E8BB0B78EBC6OPTELIAN5opteli_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Using the &#8220;Porting POSIX applications to Xenom=
ai&#8221; document I have ported an existing application to Xenomai. We cre=
ate multiple threads in our application and I have the following questions =
related to posix threads (I could not find an
 answer in a search of xenomai-help):<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If the threads are running in primary mode, should t=
hey be listed in /proc/xenomai/sched? My threads show up, with the correct =
real time priorities, when I do a top &#8211;H, but they are not in /proc/x=
enomai/sched, so does that mean they are
 all running in secondary mode?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># top -H -b -n 1<o:p></o:p></p>
<p class=3D"MsoNormal">top - 17:00:45 up 0 min,&nbsp; 2 users,&nbsp; load a=
verage: 0.04, 0.01, 0.01<o:p></o:p></p>
<p class=3D"MsoNormal">Tasks: 104 total,&nbsp;&nbsp; 1 running, 103 sleepin=
g,&nbsp;&nbsp; 0 stopped,&nbsp;&nbsp; 0 zombie<o:p></o:p></p>
<p class=3D"MsoNormal">Cpu(s):&nbsp; 3.6%us,&nbsp; 5.0%sy,&nbsp; 0.0%ni, 88=
.1%id,&nbsp; 2.1%wa,&nbsp; 0.0%hi,&nbsp; 1.1%si,&nbsp; 0.0%st<o:p></o:p></p=
>
<p class=3D"MsoNormal">Mem:&nbsp;&nbsp;&nbsp; 254980k total,&nbsp;&nbsp;&nb=
sp; 58192k used,&nbsp;&nbsp; 196788k free,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0k buffers<o:p></o:p></p>
<p class=3D"MsoNormal">Swap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0k t=
otal,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0k used,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0k free,&nbsp;&nbsp;&nbsp; 11908k cached<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; PID USER &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PR&nbs=
p; NI&nbsp; VIRT&nbsp; RES&nbsp; SHR S %CPU %MEM&nbsp;&nbsp;&nbsp; TIME&#43=
;&nbsp; COMMAND&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1179 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20&nbs=
p;&nbsp; 0&nbsp; 1392&nbsp; 616&nbsp; 424 R&nbsp; 7.4&nbsp; 0.2&nbsp;&nbsp;=
 0:00.08 top&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;992 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 1.9 17.9&nbsp;&nbsp; 0:00.02 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;1 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 20&nbsp;&nbsp; 0&nbsp; 1364&nbsp; 432&nbsp; 352 S&nbsp; 0.0&nbsp; =
0.2&nbsp;&nbsp; 0:00.99 init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;2 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 kthreadd&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;4 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 kworker/0:0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;5 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.08 kworker/u:0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;6 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nb=
sp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 khelper&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;91 root&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nb=
sp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 sync_supers&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;93 root&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nb=
sp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 bdi-default&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;94 root&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 kblockd&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;3 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 ksoftirqd/0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;122 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; =
0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 rpciod&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;123 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.60 kworker/0:1&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;186 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
T&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 gatekeeper/0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;188 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 kswapd0&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;189 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 fsnotify_mark&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;190 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; =
0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 unionfs_siod&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;191 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; =
0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 nfsiod&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;192 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; =
0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 crypto&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;7 root&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 20&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 kworker/u:1&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;789 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock1&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;794 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock2&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;799 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock3&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;105 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.03 khubd&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;814 root&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock5&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;819 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock6&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;824 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock7&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;829 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; &nbsp;0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock8&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;840 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 ubi_bgt0d&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;843 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock9&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;848 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock10&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;853 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock11&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;858 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock12&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;892 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp; &nbsp;0:00.00 flush-0:13&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;900 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp; 1348&nbsp; 284&nbsp; 224 S&nbsp; 0.0&nbsp; 0.1&nbsp;&=
nbsp; 0:00.03 syslogd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;902 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp; 1348&nbsp; 272&nbsp; 208 S&nbsp; 0.0&nbsp; 0.1&nbsp;&=
nbsp; 0:00.06 klogd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;919 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0 -20&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; =
0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 ff407000.spi&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;963 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp; 1740&nbsp; 556&nbsp; 424 S&nbsp; 0.0&nbsp; 0.2&nbsp;&=
nbsp; 0:00.01 ntpd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;966 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp; 3072&nbsp; 820&nbsp; 596 S&nbsp; 0.0&nbsp; 0.3&nbsp;&=
nbsp; 0:00.00 sshd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;968 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp; 1372&nbsp; 528&nbsp; 428 S&nbsp; 0.0&nbsp; 0.2&nbsp;&=
nbsp; 0:00.02 sh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;972 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
2&nbsp;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:02.00 m=
gt200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;973 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 m=
gt200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;974 root&nbsp;&nbsp;&nbsp;&nbsp; -36&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;975 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;977 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
2&nbsp;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.06 m=
gt200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;978 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;979 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;980 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;981 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;982 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;983 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;984 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;985 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;986 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;987 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;988 root&nbsp;&nbsp; &nbsp;&nbsp;-71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;989 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;990 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;991 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 canSlo=
tSendThre&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;784 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock0&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;993 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.01 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;994 root&nbsp;&nbsp;&nbsp;&nbsp; -75&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.01 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;995 root&nbsp;&nbsp;&nbsp;&nbsp; -75&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;804 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp; 0 S&nbsp; 0.0&nbsp; 0.0&nbsp;&nbsp; 0:00.00 mtdblock4&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1000 root&nbsp;&nbsp;&nbsp;&nbsp; -54&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp; &nbsp;0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1001 root&nbsp;&nbsp;&nbsp;&nbsp; -55&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1002 root&nbsp;&nbsp;&nbsp;&nbsp; -59&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1003 root&nbsp;&nbsp;&nbsp;&nbsp; -36&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1004 root&nbsp;&nbsp;&nbsp;&nbsp; -45&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1005 root&nbsp;&nbsp;&nbsp;&nbsp; -45&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1006 root&nbsp;&nbsp;&nbsp;&nbsp; -45&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;1009 root&nbsp;&nbsp;&nbsp;&nbsp; -43&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1012 root&nbsp;&nbsp;&nbsp;&nbsp; -43&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1013 root&nbsp;&nbsp;&nbsp;&nbsp; -36&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1014 root&nbsp;&nbsp;&nbsp;&nbsp; -46&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1015 root&nbsp;&nbsp;&nbsp;&nbsp; -46&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1016 root&nbsp;&nbsp;&nbsp;&nbsp; -46&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1017 root&nbsp;&nbsp;&nbsp;&nbsp; -57&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 cliTask&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1018 root&nbsp;&nbsp;&nbsp;&nbsp; -53&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 ttyCliInter=
face&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1019 root&nbsp;&nbsp;&nbsp;&nbsp; -57&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 cliTask&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1020 root&nbsp;&nbsp;&nbsp;&nbsp; -53&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 ttyCliInter=
face&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1021 root&nbsp;&nbsp;&nbsp;&nbsp; -57&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 cliTask&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1022 root&nbsp;&nbsp;&nbsp;&nbsp; -57&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 cliTask&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1023 root&nbsp;&nbsp; &nbsp;&nbsp;-57&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 cliTask&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1024 root&nbsp;&nbsp;&nbsp;&nbsp; -57&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 cliTask&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1025 root&nbsp;&nbsp;&nbsp;&nbsp; -36&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1026 root&nbsp;&nbsp;&nbsp;&nbsp; -71&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1027 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.01 SNMPTimerSe=
rvic&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1028 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 SNMPCntrMon=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1029 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 SNMPGaugeMo=
n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1030 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 SNMPStringM=
on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1031 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 tl1TimerMgm=
t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1032 root&nbsp;&nbsp;&nbsp;&nbsp; -56&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp; &nbsp;0:00.00 mgt200&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1033 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 SNMPMain&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1034 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 SNMPTrap&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1035 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.04 tl1Server&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1036 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 tl1AsyncCli=
ent&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1037 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 tl1AsyncCli=
ent&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1038 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 tl1SendMsg&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1039 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 tl1MsgHdlr&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1040 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nb=
sp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 tl1AlarmHdl=
r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1084 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20&nbs=
p;&nbsp; 0&nbsp; 5692 1652 1344 S&nbsp; 0.0&nbsp; 0.6&nbsp;&nbsp; 0:00.07 s=
shd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;1094 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20&nbs=
p;&nbsp; 0&nbsp; 1368&nbsp; 524&nbsp; 428 S&nbsp; 0.0&nbsp; 0.2&nbsp;&nbsp;=
 0:00.01 sh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;999 root&nbsp;&nbsp;&nbsp;&nbsp; -58&nbs=
p;&nbsp; 0 46388&nbsp; 44m 6860 S&nbsp; 0.0 17.9&nbsp;&nbsp; 0:00.00 mgt200=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># cat /proc/xenomai/sched<o:p></o:p></p>
<p class=3D"MsoNormal">CPU&nbsp; PID&nbsp;&nbsp;&nbsp; CLASS&nbsp; PRI&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp;&nbsp; TIMEBASE&nbsp;&nbsp; STAT&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle&=
nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; master&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ROOT<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; 0&nbsp; 972&nbsp;&nbsp;&nbsp; rt&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; master&nbsp;&nbsp;&nbsp;&nbsp; X&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgt200<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If one thread of an application goes into secondary =
mode, does it drag all the other threads with it into secondary mode?<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If the main application threads goes into secondary =
mode, does it drag all of the child threads with it into secondary mode?<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Cheers,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; Chris.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Verdana&quot;,&quot;sans-serif&quot;;color:#00568D">Chris Stone<o:p></o:p>=
</span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Senior Software Engineer<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Optelian<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">1 Brewer Hunt Way<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Ottawa, Ontario K2K 2B5<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;">Phone: 613-287-2000 x2106<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ver=
dana&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><u><span style=3D"font-size:8.0pt;font-family:&quot;=
Verdana&quot;,&quot;sans-serif&quot;;color:#00568D"><a href=3D"http://www.o=
ptelian.com"><span style=3D"color:blue">www.optelian.com</span></a></span><=
/u><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_623784B6C75D274389918D358E89E8BB0B78EBC6OPTELIAN5opteli_--

