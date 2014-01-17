Message-ID: <52D919F7.8020908@siemens.com>
Date: Fri, 17 Jan 2014 12:54:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] forge: make install fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

I guess there is a generated file missing in git:

make[3]: Entering directory `/data/xenomai-forge/build64/doc/asciidoc'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: *** No rule to make target `../../../doc/asciidoc/../generated/html/MIGRATION', needed by `install-htmldocs'.  Stop.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

