Message-ID: <437D976B.3040502@domain.hid>
Date: Fri, 18 Nov 2005 09:57:15 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <437C8299.3010503@domain.hid>	<200511171855.15588.dmitry.adamushko@domain.hid>	<17276.55104.956181.681355@domain.hid>
	<200511172045.43942.dmitry.adamushko@domain.hid>
In-Reply-To: <200511172045.43942.dmitry.adamushko@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Blocking reads from pipes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>


>Exactly, I have just found out that and posted actually a long mail just 
>before getting this mail from you :o)
>
>Yep, and before getting blocked, read() increments the counter as well, that's 
>why we don't have a xnpipe_realease() called as a result of close().
>So everything is correct.
>  
>
Fine. Though then my problem is not related to xenomai, any suggestions
on how to force read() to return? (without writing anything to the other
end of the pipe)

