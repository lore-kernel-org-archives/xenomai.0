Message-ID: <4AE858C5.80304@domain.hid>
Date: Wed, 28 Oct 2009 15:44:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid> <4AE82F22.6090203@domain.hid>
	<4AE855A8.2070106@domain.hid>
In-Reply-To: <4AE855A8.2070106@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTnet install problem: Xenomai configuration
	tool not found
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Benjamin Biegel wrote:
> Hej Jan
> 
> Should I ask the whole forum or you directly? If that is ok?

Following up via the mailing lists is preferred (hence, CCed).

> 
> Upon setting up the RTnet i try the loopback test described in http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing. But after running ./rtnet start the PC freezes (except the mouse cursor). The first time i tried it managed to show 'Waiting for slaves' but now it just freezes with no printout.
> 
> My PC uses the e1000 module. I have Xenomai 2.4.9.1 and ubuntu with linux kernel 2.6.28.9.

Check if you have CONFIG_PCI_MSI enabled and, if yes, try running
without it. Not a solution, but maybe a workaround.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

