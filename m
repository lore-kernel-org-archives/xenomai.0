Message-ID: <CE14215C87EAAF4B9AD862BB49625057048E821C@ssdd-cluster.ds.amrdec.army.mil>
From: "Reynolds, Terry (Contractor-SIMTECH)" <terry.reynolds2@domain.hid>
Date: Tue, 18 Jan 2005 14:03:27 -0600
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Adeos-main] porting adeos
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "'adeos-main@gna.org'" <adeos-main@gna.org>

Hi all,
 
 
I'm working on porting Adeos to a ppc64 kernel.  I'm going through the
latest patch file and have a few questions:
 
The Adeos porting guide say's generic.c and ppc.c should go in
drivers/adeos, the patch file has them going into a /adeos directory, along
with one of the adeos.c files.  The Makefile for that directory makes
adeos.o generic.o and ppc.o.  Generic.o goes into adeos-objs which is an
object I can't find used anywhere else. 
 
There are two adeos.c files in the patch file.  One goes into /kernel, and
the other goes to /arch/ppc/kernel.  There isn't one that goes to either
/driver/adeos or /adeos!
 
So I'm confused.  Where should these three files end up: generic.c ppc.c and
adeos.c, and which one of the adeos.c files should be in that directory?
 
Why does generic.o end up as adeos-objs which doesn't seem to be used in any
other Makefile?
 
I'm sorry if these are stupid questions, I'm not very familiar with patch
files.


TIA!
 
Terry Reynolds

 

