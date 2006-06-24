Message-ID: <d87da8330606232034n259b0fcaka361f60e0497e9de@domain.hid>
Date: Sat, 24 Jun 2006 09:04:17 +0530
From: "Pramode C E" <pramode@domain.hid>
Subject: Re: [Xenomai-help] Nucleus Documentation
In-Reply-To: <1150839249.4417.59.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7656_33338579.1151120057677"
References: <d87da8330606201027m19044b68lfa29d352297fa77a@domain.hid>
	<1150839249.4417.59.camel@domain.hid>
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

------=_Part_7656_33338579.1151120057677
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

PS: if you go for user-space support, take an extreme care to properly
> propagate the -EINTR return code to the user-space caller (see XNBREAK
> condition upon return from xnsynch_sleep_on()), signaling that a Linux
> signal has hit a blocked real-time thread. Doing this properly
> guarantees you a working GDB support for debugging the apps using your
> interface, and above all, participates to the overall stability of the
> system upon signal receipt. Keeping this in mind will spare you a fair
> number of head banging sessions.



Thanks for the hints; let me try my hand at  it once again.

Regards,
Pramode
--------------

------=_Part_7656_33338579.1151120057677
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">PS: if you go for user-space support, take an extreme care to properly<br>propagate the -EINTR return code to the user-space caller (see XNBREAK
<br>condition upon return from xnsynch_sleep_on()), signaling that a Linux<br>signal has hit a blocked real-time thread. Doing this properly<br>guarantees you a working GDB support for debugging the apps using your<br>interface, and above all, participates to the overall stability of the
<br>system upon signal receipt. Keeping this in mind will spare you a fair<br>number of head banging sessions.</blockquote><div><br>
<br>
Thanks for the hints; let me try my hand at&nbsp; it once again.&nbsp; <br>
<br>
Regards,<br>
Pramode<br>
--------------<br>
 </div><br>
</div>

------=_Part_7656_33338579.1151120057677--

