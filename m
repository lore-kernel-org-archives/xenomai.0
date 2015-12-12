From: Narasimhaprasad Yedatore Achutha <Narasimhaprasad_A@infosys.com>
Date: Sat, 12 Dec 2015 13:42:01 +0000
Message-ID: <f032b1abe1d947cab8a89e20759c07a0@CHNSHLMBX32.ad.infosys.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] CAN Loopback with Recieve own message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hello All

I have a question on RT-Socket not supporting Receive own message option(=
CAN_RAW_RECV_OWN_MSGS ) with MSG_CONFIRM flag not supported. I'm trying t=
o understand, if we modify the kernel driver supporting  CAN_RAW_RECV_OWN=
_MSGS, so that we start receiving transmitted message back at the control=
ler, how much an impact happens  on

-          Real time scheduling

-          Does CAN message missing  cases be frequent at high bus load f=
or real time applications

-          Any other impact we need to consider?

Please let me know if anybody has any experience on this or any  experime=
nts  to share?. Any thoughts or advice will be helpful

Thanks and Regards
Prasad

**************** CAUTION - Disclaimer *****************
This e-mail contains PRIVILEGED AND CONFIDENTIAL INFORMATION intended sol=
ely 
for the use of the addressee(s). If you are not the intended recipient, p=
lease 
notify the sender by e-mail and delete the original message. Further, you=
 are not 
to copy, disclose, or distribute this e-mail or its contents to any other=
 person and 
any such actions are unlawful. This e-mail may contain viruses. Infosys h=
as taken 
every reasonable precaution to minimize this risk, but is not liable for =
any damage 
you may sustain as a result of any virus in this e-mail. You should carry=
 out your 
own virus checks before opening the e-mail or attachment. Infosys reserve=
s the 
right to monitor and review the content of all messages sent to or from t=
his e-mail 
address. Messages sent to or from this e-mail address may be stored on th=
e 
Infosys e-mail system.
***INFOSYS******** End of Disclaimer ********INFOSYS***
