Message-ID: <2b490f270809010608m4b9bf58ej9e63f2784e61bae4@domain.hid>
Date: Mon, 1 Sep 2008 15:08:04 +0200
From: "Dehann Fourie" <dehann.fourie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9743_8565231.1220274484357"
Subject: [Xenomai-help] Compile and run problem
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

------=_Part_9743_8565231.1220274484357
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm having trouble compiling a code fragment. After running the makefile, I
try to run the program wich then gives the the following error?

dehann:/home/dehann/workspace/rtPP_AD# make
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-L/usr/xenomai/lib -lpthread -lnative main.o -o main -lm
dehann:/home/dehann/workspace/rtPP_AD# ./main
./main: error while loading shared libraries: libnative.so.1: cannot open
shared object file: No such file or directory

the libnative.so.1 file is in the /usr/xenomai/ directory. Thanks in
advance!

Dehann

------=_Part_9743_8565231.1220274484357
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>I&#39;m having trouble compiling a code fragment. After running the makefile, I try to run the program wich then gives the the following error?<br><br>dehann:/home/dehann/workspace/rtPP_AD# make<br>
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -L/usr/xenomai/lib -lpthread -lnative main.o -o main -lm<br>dehann:/home/dehann/workspace/rtPP_AD# ./main<br>./main: error while loading shared libraries: libnative.so.1: cannot open shared object file: No such file or directory<br>
<br>the libnative.so.1 file is in the /usr/xenomai/ directory. Thanks in advance!<br><br>Dehann<br><br></div>

------=_Part_9743_8565231.1220274484357--

