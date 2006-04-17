From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 17 Apr 2006 10:47:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604171047.51730.niklaus.giger@domain.hid>
Subject: [Xenomai-core] [RFC] collecting xenomai statistics
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

Following a suggestion from Philippe Gerum I propose to collect and prepare 
like this:

a) Make it easy to collect information

add -s/-c option to xeno-test, help text would look like 
-s         send output of xeno-test to xeno-stat@domain.hid
-c <name>  if -s, send also kernel config file to xeno-stat@domain.hid
(May be patch xeno-config to emit also the revision of the svn checkout?)

b) Setup an e-mail account xeno-stat@domain.hid.

c) Add a archiver which generates daily a gzipped tar file of all messages 
ever sent to xeno-stat@domain.hid (e.g. of its mbox). Make it available 
somewhere on the internet.

d) Write a converter the raw messages into more suitable representation, eg. a 
MySQL-DB, a spreadsheet format. Extract the raw message and kernel config and 
store the publicly accessible on the internet. The DB/spreadsheet will 
contain pointers (URLs) to the raw message/kernel config.

e) Write viewers which present interesting statistics. E.g. X/HTML pages to 
present a ordered (by architecture, board, version, etc) view of the 
available  results.

I would like to advance like this:

I am not interested in step a), as it is easy for me just to write a trivial 
script to sent the xeno-test output to any address. Also adding the revision 
of svn checkout is not very difficult.

For point b+c) I am lacking the necessary rights, but it easy for me to setup 
a similar account for my tests here. But I would appreciate, if somebody of 
the core team would help me to get this work done.

For point d+e) I will (after a week of vacation with my son) invest some work. 
But I would be very interested in knowing exactly which kind of information 
the core developers are interested in. How should it be presented? In tabular 
form? Graphs, which ones? And kind of feedback will be evaluated and 
integrated.

Best regards

-- 
Niklaus Giger

