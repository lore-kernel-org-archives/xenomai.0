From: Narasimhaprasad Yedatore Achutha <Narasimhaprasad_A@infosys.com>
Date: Wed, 18 Mar 2015 08:27:06 +0000
Message-ID: <CE26B02160B73D4F82E70632544CC6823D2C3600@chnshlmbx11>
In-Reply-To: <20150317181631.GC16113@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] CAN tx successfullness at Xenomai RT SocketCAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "'gilles.chanteperdrix@xenomai.org'" <gilles.chanteperdrix@xenomai.org>, "'xenomai-owner@xenomai.org'" <xenomai-owner@xenomai.org>, "'xenomai@xenomai.org'" <xenomai@xenomai.org>

Hello All
I'm using RTSocket CAN in my application. Trying figure out how to ensure=
 the CAN message tranmission succesfulness in my function
Previuosly I was able to assess the echoed (recv own msg) message with MS=
G_CONFIRM flag returned by recvmsg() while using just socket CAN function=
alities.
However with RT SOcket CAN, the CAN_RAW_RECV_OWN_MSGS is not supported at=
 rt_dev_setsockopt, and because of this the MSG_CONFIRM isnot being set a=
t msg flags in the received messages.
Could please elaborate how do we make sure the tx message successfulness =
are assesed at RT socket CAN.
Thanks
YA
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

