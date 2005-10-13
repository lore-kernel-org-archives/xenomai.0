Message-ID: <40871.193.52.24.125.1129216395.squirrel@domain.hid>
Date: Thu, 13 Oct 2005 17:13:15 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Recipe for dummies
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

Hi everybody !

thanks at all the Xeno people for the fast and accurate answers. This is my
"quick recipe for Dummies Like Me (TM)":

- dowload a vaililla kernel from www.kernel.org (I used 2.6.13.4 with VERY
good results);

- download latest SVN source tree using [svn] (Subversion) following the
instruction and examples on the page
https://gna.org/svn/?group=xenomai
If you are unlucky people like me, eg. you live behind a bastard proxi,
dowload the daily snapshot (look in bottom of the page) and unpack the file

- unpack the kernel

- patch the kernel with the adeos patch

- configure, compile and install the kernel

- reboot the machine

- configure, compile and install Xenomai

- run the tests in [testsuite].

In this configuration everything looks good. I think that the only important
missed step was the SNV or daily snapshot dowload of Xenomai.
After this precisation, everything looks more clear, documentation included:
there is NOT Fusion documentation because Fusion is "XenoAssimilated" TM :).

Simone









