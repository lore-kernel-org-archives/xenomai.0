Message-ID: <4445068A.8000008@domain.hid>
Date: Tue, 18 Apr 2006 11:32:26 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <200604171047.51730.niklaus.giger@domain.hid>
	<44444AB2.9020305@domain.hid>
In-Reply-To: <44444AB2.9020305@domain.hid>
Content-Type: multipart/mixed; boundary="------------000207090406040807080509"
Subject: [Xenomai-core] [patch] xeno-test email addition
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000207090406040807080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Cromie wrote:
> Niklaus Giger wrote:
>> Hi
>>
>> Following a suggestion from Philippe Gerum I propose to collect and 
>> prepare like this:
>>
>> a) Make it easy to collect information
>>
>> add -s/-c option to xeno-test, help text would look like -s         
>> send output of xeno-test to xeno-stat@domain.hid
>> -c <name>  if -s, send also kernel config file to xeno-stat@domain.hid
>>   
> attached patch adds new -m -M flags for xeno-test, (-s flag is taken, 
> for statistics)
> former for a fixed addy (to be patched later), latter taking any email 
> as arg.
>
> I didnt add -c <name>, since xeno-test already does something similar;
> if you build with CONFIG_IKCONFIG_PROC=y, xeno-test greps XENO out of 
> /proc/config.gz
> (probably needs a few more grep terms, and perhaps a -verbose mode which
> cats the whole thing.)
>
> The -M option works, since I just received an email Id sent earlier,
> but I also sent one to xenomai-core, and it hasnt shown up yet.
> I suspect that the mail looks like spam, and has been rejected,
> since my hostname is not a real FQDN.
> So Im not so sure that email is the best way here, but it is 
> conceptually simple.



Oof.  Now attached.

--------------000207090406040807080509
Content-Type: text/plain;
 name="patch-mail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mail"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 943)
+++ scripts/xeno-test.in	(working copy)
@@ -17,6 +17,8 @@
   -L	     	writes to logfile (default "test-`uname -r`") (via script)
   -N <name>	same as -L, but prepend "$name-" (without -L, logname="$name-")
 		prepending allows you to give a full path.
+  -m		sends output file to xeno-test@domain.hid
+  -M <email>	sends output file to given addy
 
   # following options are passed thru to latency, klatency
   -s	print statistics of sampled data (default on)
@@ -136,8 +138,11 @@
 logprefix=
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-while getopts 'd:shqT:l:H:B:uLN:w:W:p:' FOO ; do
+email='xeno-test@domain.hid'
+sendit=
 
+while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:' FOO ; do
+
     case $FOO in
 	s|h|q)
 	    pass="$pass -$FOO" ;;
@@ -166,6 +171,11 @@
 	p)
 	    prepost=$OPTARG 
 	    loadpass="$loadpass -p '$OPTARG'"  ;;
+	M)
+	    email=$OPTARG 
+	    sendit=1 ;;
+	m)
+	    sendit=1 ;;
 	?)
 	    myusage ;;
     esac
@@ -179,6 +189,10 @@
     # restart inside a script invocation, passing all
     date=`date +%y%m%d.%H%M%S`
     script -c "./xeno-test $loadpass $pass $*" "$logprefix$logfile-$date"
+    if [ $sendit == 1 ]; then
+	echo "mailing $logprefix$logfile-$date to $email"
+	mail -s 'xeno-test results' $email < "$logprefix$logfile-$date"
+    fi
 else
     if [ "$altwork" != "" ]; then
 	mkload() { exec $altwork; }

--------------000207090406040807080509--

