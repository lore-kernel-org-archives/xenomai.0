Message-ID: <BLU177-W25E97426D2CEB8930CE73AA07F0@phx.gbl>
From: Rosali Pyun <whimt@hotmail.com>
Date: Wed, 19 Mar 2014 16:50:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Analogy- Using counter with NI m series DAQ card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello to all,
I am using xenomai 2.6.3 with linux kernel 3.5.7 on an ubuntu 12.04.
I am trying to implement counter functionality for NI M series DAQ card (i.=
e. NI PCI 6229).
I was adpated the code from Comedi example on NI general-purpose counter (a=
nd also with the answer from the mailing list http://www.xenomai.org/piperm=
ail/xenomai/2011-April/023204.html), =

but I got the following values even when I did not wire any signals to =

the pins. (Please see the attachment for my code)

At least it increments, and I can arm/disarm the counter.

counter reader : 0x1317252counter reader : 0x26299a1counter reader : 0x393b=
ca6

counter reader : 0x4c4e453counter reader : 0x5f60c1acounter reader : 0x7273=
3c6counter reader : 0x8585540

counter reader : 0x9897b6ccounter reader : 0xabaa1b5counter reader : 0xbebc=
93dcounter reader : 0xd1cef7b


I think there must be a problem how I configured the counter.Could anyone g=
ive me some tips on configuring the counter properly?Also, is there a Analo=
gy documentation that tells which macro variables to configure to load coun=
ter?
(My goal in the end would be using counter for encoder.)


I appreciate any help that I receive.
Best,Rosali 		 	   		  =

-------------- next part --------------
A non-text attachment was scrubbed...
Name: counterPCI6229.cpp
Type: text/x-c
Size: 3887 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140319/f37a5cc=
2/attachment.bin>
