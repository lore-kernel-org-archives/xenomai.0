From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <616f2bf3-6323-17ae-5dd6-861580c674da@siemens.com>
Date: Mon, 6 Mar 2017 19:21:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] cobalt_call_extension(signal_copyinfo) vs. compat calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

while the put_siginfo callback allows to select an appropriate siginfo
copying handler, cobalt_call_extension(signal_copyinfo) does not get any
information about compat vs. regular calls, right?

What is your preference to extend this interface? Pass a compat flag,
calculated from put_siginfo != signal_put_siginfo? Straightforward but
kind of ugly.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

