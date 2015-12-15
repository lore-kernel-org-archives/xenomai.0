From: Narasimhaprasad Yedatore Achutha <Narasimhaprasad_A@infosys.com>
Date: Tue, 15 Dec 2015 06:01:34 +0000
Message-ID: <1c3f1456271048ed91b95362f9605c1a@CHNSHLMBX32.ad.infosys.com>
References: <f032b1abe1d947cab8a89e20759c07a0@CHNSHLMBX32.ad.infosys.com>
 <20151214224518.GF16627@hermes.click-hack.org>
In-Reply-To: <20151214224518.GF16627@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] CAN Loopback with Recieve own message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Stephen Marshall <Stephen_Marshall@infosys.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Thanks Giles.  Do you have any idea on other three questions 
, if we modify the kernel driver supporting 
> CAN_RAW_RECV_OWN_MSGS, so that we start receiving transmitted message 
> back at the controller, how much an impact happens on
> 
> -          Real time scheduling
> 
> -          Does CAN message missing cases be frequent at high bus
> -          load for real time applications
> 
> -          Any other impact we need to consider?

Thanks and Regards
Prasad

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Tuesday, December 15, 2015 4:15 AM
To: Narasimhaprasad Yedatore Achutha
Cc: Xenomai@xenomai.org
Subject: Re: [Xenomai] CAN Loopback with Recieve own message

On Sat, Dec 12, 2015 at 01:42:01PM +0000, Narasimhaprasad Yedatore Achuth=
a wrote:
> Hello All
> 
> I have a question on RT-Socket not supporting Receive own message 
> option(CAN_RAW_RECV_OWN_MSGS ) with MSG_CONFIRM flag not supported. 
> I'm trying to understand, if we modify the kernel driver supporting 
> CAN_RAW_RECV_OWN_MSGS, so that we start receiving transmitted message 
> back at the controller, how much an impact happens on
> 
> -          Real time scheduling
> 
> -          Does CAN message missing cases be frequent at high bus
> -          load for real time applications
> 
> -          Any other impact we need to consider?
> 
> Please let me know if anybody has any experience on this or any 
> experiments to share?. Any thoughts or advice will be helpful

I do not see any other reason for not having CAN_RAW_RECV_OWN_MSGS than t=
he fact that nobody needed this, so nobody implemented it.

-- 
=09=09=09=09=09    Gilles.
https://click-hack.org

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

