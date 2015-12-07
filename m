From: Umair Ali <ali.umair@tut.fi>
Date: Mon, 7 Dec 2015 11:06:29 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A70DADE@mb2010-1.intra.tut.fi>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Linking static libraries using wrap-link.sh script
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello there,

I have read that if you want to create a POSIX application by compiling it =
with Xenomai POSIX skin then the script "wrap-link.sh" is used. Do i have u=
nderstand it correctly  or it means that if you want to use static library =
(compiled for POSIX skin) with Xenomai POSIX application then in order to l=
ink that static library with real time application "wrap-link.sh" script sh=
ould be used. I am little confused. Please make it clear.
Moreover I want to use the static libpcap which is compiled for the POSIX s=
kin to make an application on Xenomai POSIX skin to read pcap files. If i u=
se the the static libpcap file to read to pcap files along with mlockall,, =
can reading of pcap file will switch to secondary mode with this library.  =
 The slackspot output file is attached for reference.

I am very grateful for the xenomai team and especially Gilles for helping m=
e and answering my stupid and redundant questions.

Regards
Ali
-------------- next part --------------
A non-text attachment was scrubbed...
Name: slackspot_output
Type: application/octet-stream
Size: 23194 bytes
Desc: slackspot_output
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151207/d56ff166/at=
tachment.obj>
