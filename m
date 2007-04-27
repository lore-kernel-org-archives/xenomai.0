Message-ID: <cbe23c50704270932t7475e16dt77e54ab1eebe0883@domain.hid>
Date: Fri, 27 Apr 2007 18:32:44 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <46322259.5080409@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_72671_32031625.1177691564513"
References: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
	<46322259.5080409@domain.hid>
Subject: Re: [Xenomai-help] Core Dump on possibly buggy signal handler
	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_72671_32031625.1177691564513
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/4/27, Jan Kiszka <jan.kiszka@domain.hid>:
> >
> > I mean I know that uninitialized memory have unpredictable consequence
> > but here the bug is persistent after rerun, reboot, power cycle etc...
> >
>
> What is a.sa_flags initialised when it is not initialised? 0? Maybe you
> can nail it down to defined state that causes the core dump reliably.
> Then we can also track down what happens to your sigaction call and
> if/why Xenomai/I-pipe changes the picture in some regard.

I did rerun as you suggest, find the code attached which
consistentely core dump with xenomai kernel and (seems to) do nothing
special with the other kernel.

a.sa_flags = 0xbff81578;


-- 
Erk

------=_Part_72671_32031625.1177691564513
Content-Type: text/x-csrc; name=TimerSigHandler.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f10v4n6o
Content-Disposition: attachment; filename="TimerSigHandler.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHNpZ25h
bC5oPgoKc3RhdGljIGludCBzdG9wID0gMDsKCnZvaWQKU2lnbmFsSGFuZGxlcihpbnQgU2lnbmFs
KSB7CiAgaW50IHBpZCA9IGdldHBpZCgpOwogIHByaW50ZigiUmVjZWl2ZWQgc2lnbmFsICVkLiBT
dG9wcGluZyBwZWFjZWZ1bGx5LlxuIiwgU2lnbmFsKTsKICBzdG9wID0gMTsKfQoKCmludAptYWlu
KCkgewoKICBpbnQgaTsKICBzdHJ1Y3Qgc2lnYWN0aW9uIGEgOwoKICBzaWduYWwoU0lHSU5UICwg
U2lnbmFsSGFuZGxlcik7CiAgc2lnbmFsKFNJR1BJUEUsIFNpZ25hbEhhbmRsZXIpOwogIAogIGEu
c2FfaGFuZGxlciA9IFNpZ25hbEhhbmRsZXIgOwogIHNpZ2VtcHR5c2V0KCZhLnNhX21hc2spOwoj
aWYgZGVmaW5lZChHT09EX1NJR0hBTkRMSU5HKQogIGEuc2FfZmxhZ3MgICAgPSBTQV9SRVNUQVJU
OwojZWxzZQogIGEuc2FfZmxhZ3MgICAgPSAweGJmZjgxNTc4OwojZW5kaWYKICBzaWdhY3Rpb24o
U0lHQUxSTSwgJmEsIE5VTEwpOwoKICBhbGFybSgzKTsKICAgIAogIGZvciAoaT0wO2k8MjAwMCAm
JiAhc3RvcCA7KytpKSB7CgogICAgcHJpbnRmKCIuIik7CiAgICBmZmx1c2goc3Rkb3V0KTsKICAg
IHNsZWVwKDEpOwogIH0KfQoK
------=_Part_72671_32031625.1177691564513--

