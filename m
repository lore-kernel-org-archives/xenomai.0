Message-ID: <44444AB2.9020305@domain.hid>
Date: Mon, 17 Apr 2006 22:10:58 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] collecting xenomai statistics
References: <200604171047.51730.niklaus.giger@domain.hid>
In-Reply-To: <200604171047.51730.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
>
> Following a suggestion from Philippe Gerum I propose to collect and prepare 
> like this:
>
> a) Make it easy to collect information
>
> add -s/-c option to xeno-test, help text would look like 
> -s         send output of xeno-test to xeno-stat@domain.hid
> -c <name>  if -s, send also kernel config file to xeno-stat@domain.hid
>   
attached patch adds new -m -M flags for xeno-test, (-s flag is taken, 
for statistics)
former for a fixed addy (to be patched later), latter taking any email 
as arg.

I didnt add -c <name>, since xeno-test already does something similar;
if you build with CONFIG_IKCONFIG_PROC=y, xeno-test greps XENO out of 
/proc/config.gz
(probably needs a few more grep terms, and perhaps a -verbose mode which
cats the whole thing.)

The -M option works, since I just received an email Id sent earlier,
but I also sent one to xenomai-core, and it hasnt shown up yet.
I suspect that the mail looks like spam, and has been rejected,
since my hostname is not a real FQDN.
So Im not so sure that email is the best way here, but it is 
conceptually simple.

( back in Nov, I set up a gmail acct, and tried to fetch mail from it 
with a script.
gmail wants TLS security, and didnt let me in, so I punted/shelved this. )
Niklaus' message brought me back on this topic.


So Im considering poaching code from LiveCD that does url-encoding,
or just using curl to post to some file-upload url.
How would you do this if you only had busybox ??

Anyway, both email and url-upload are suboptimal wrt spam,
latter is also a server support issue.



> (May be patch xeno-config to emit also the revision of the svn checkout?)
>
>   
perhaps as a 4th number on the version, that way xeno-config can stay as is.

[root@domain.hid bin]# ./xeno-config --version
2.1.50
Id like instead:
2.1.50.941

This seems better than pokinh around a filesystem, looking for the 
xenomai svn
(which may be on the build-host, not the run-host)


> b) Setup an e-mail account xeno-stat@domain.hid.
>
>   
getting messages thru the anti-spam filters is the issue here,

> c) Add a archiver which generates daily a gzipped tar file of all messages 
> ever sent to xeno-stat@domain.hid (e.g. of its mbox). Make it available 
> somewhere on the internet.
>   
or a daily/weekly digest/tarball

> d) Write a converter the raw messages into more suitable representation, eg. a 
> MySQL-DB, a spreadsheet format. Extract the raw message and kernel config and 
> store the publicly accessible on the internet. The DB/spreadsheet will 
> contain pointers (URLs) to the raw message/kernel config.
>   
certainly not a bad idea.  Will simplify collection/selection of 
data-sets for various things,
esp more complicated selections (with ands, ors, etc). 

> e) Write viewers which present interesting statistics. E.g. X/HTML pages to 
> present a ordered (by architecture, board, version, etc) view of the 
> available  results.
>
>   

Ive done minimal dabbling with gnuplot, R, both have possibilities.

With gnuplot, I tried graphing the RTD data, failed cuz theres no time 
column
(couldnt figure out how to create/infer a synthetic 'index' column).
It has some capability to select data out of files using awk,etc 
subcommands,
but for complicated data files like xeno-test outputs (multiple 
sections, different formats),
I think it (the selection, reformating capabilities) might be over-matched.


R can apparently manage complex data-sets, and select data out of them.
It sounds tremendously capable (after the learning curve)
That said, Ive not grokked its use yet.



