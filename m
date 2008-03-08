Message-ID: <e39c9190803081255i6888ce44yd0a14f0b90e57b0b@domain.hid>
Date: Sat, 8 Mar 2008 21:55:14 +0100
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <18386.63663.282453.578916@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_33159_27443294.1205009714410"
References: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
	<47D27C0A.2010507@domain.hid>
	<e39c9190803080624sf49293bwff20317788ad28f7@domain.hid>
	<e39c9190803080942k302e66a6m75ed94dccd55aaac@domain.hid>
	<47D2D537.7020106@domain.hid>
	<e39c9190803081026s88acfe1h7dbef2f26ec7acc5@domain.hid>
	<18386.63663.282453.578916@domain.hid>
Subject: Re: [Xenomai-help] Posix skin and message queues operation mode
	misunderstanding
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_33159_27443294.1205009714410
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Xenomai posix skin signals cause the target thread to switch to
>
secondary mode, so, it may not be a good idea to use them.
>                                            Gilles Chanteperdrix.


I understand that since the first callback instruction up to call the
mq_receive xenomai system call, isn't it ?

We were thinking to customize the real-time operative passing some
parameters only under a controlled application state. So at same time we
need to connect the real time operative to any "secondary" object, maybe
other approaches are preferred..

If the mq_receive returns to the primary domain we can assume the hole along
the configuration process timing.

Best Regards

------=_Part_33159_27443294.1205009714410
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">Xenomai posix skin signals cause the target thread to switch to<br></blockquote><div class="gmail_quote">
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
secondary mode, so, it may not be a good idea to use them.<br>
<font color="#888888">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; Gilles Chanteperdrix.</font></blockquote><div>&nbsp;</div></div>I understand that since the first callback instruction up to call the mq_receive xenomai system call, isn&#39;t it ?<br>
<br>We were thinking to customize the real-time operative passing some parameters only under a controlled application state. So at same time we need to connect the real time operative to any &quot;secondary&quot; object, maybe other approaches are preferred..<br>
<br>If the mq_receive returns to the primary domain we can assume the hole along the configuration process timing. <br><br>Best Regards<br>

------=_Part_33159_27443294.1205009714410--

