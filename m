From: "Christopher Stone" <chris@domain.hid>
Subject: RE: [Xenomai-help] Xenomai & RTAI question
Date: Fri, 17 Mar 2006 11:29:48 -0500
Message-ID: <010001c649e0$03ab55a0$a10a10ac@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <5eb4b0650603170807x3a5d3d0oecd9e2ce4ba6a29c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'KC' <kcc1967@domain.hid>, xenomai@xenomai.org


> -----Original Message-----
> From: KC [mailto:kcc1967@domain.hid]
> Sent: March 17, 2006 11:08 AM
> To: xenomai@xenomai.org
> Subject: [Xenomai-help] Xenomai & RTAI question
> 
> Hi,
> 
> Just some simple questions,
> 
> - do I need RTAI to run Xenomai ?
[Christopher Stone] No, you do not.

> - Can I have RTAI and Xenomai installed together ?
[Christopher Stone] I don't think this would be a very good idea. You don't
really want to have a hard real time task running in Xenomai to get
interrupted by a hard real time task in RTAI. 
> - Is Xenomai a real real-time OS or just a emulator ?
[Christopher Stone] Xenomai is a real-time framework for Linux. It makes
Linux into a real-time OS.
> 
> Thanks
> KC
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 




