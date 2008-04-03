Message-ID: <f45855d10804022023n5094eb41g477071cc3a280840@domain.hid>
Date: Wed, 2 Apr 2008 23:23:29 -0400
From: "Vincent Levesque" <levesquev@domain.hid>
In-Reply-To: <18417.53680.5061.752392@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_45_30382516.1207193009369"
References: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
	<18417.28104.771421.524613@domain.hid>
	<f45855d10803311731l1f511448wc7451eee7bbe6959@domain.hid>
	<18417.53680.5061.752392@domain.hid>
Subject: Re: [Xenomai-help] freeze on system() call
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

------=_Part_45_30382516.1207193009369
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,

Thanks for walking me through this. I did as you suggested and grabbed this
more complete screenshot (stitched from two pictures):
http://www.cim.mcgill.ca/~vleves/oops-full.jpg.

Vincent Levesque
vleves@domain.hid

On Tue, Apr 1, 2008 at 2:09 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Vincent Levesque wrote:
>  > Thanks for the tip. I tried and did indeed get error messages.
> Unfortunately
>  > I haven't been able to redirect these errors to a file or to find any
>  > reference to them in /var/log/. The best I could do was to take a
> picture of
>  > the screen: http://www.cim.mcgill.ca/~vleves/oops.jpg<http://www.cim.mcgill.ca/%7Evleves/oops.jpg>
> <http://www.cim.mcgill.ca/%7Evleves/oops.jpg>.
>  > Please let me know if I can do anything else.
>
> At first sight, it looks like you have the same issue with kmap_atomic
> as Tomas. Could you try and increase resolution so that we get the
> beginning of the oops ? Enable "Video mode selection support" in
> "Console display driver support" menu, then pass something like
> vga=0x0F01 on kernel command line. Also enable frame pointers in the
> kernel if they are disabled.
>
> --
>
>
>                                            Gilles.
>

------=_Part_45_30382516.1207193009369
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,<br><br>Thanks for walking me through this. I did as you suggested and grabbed this more complete screenshot (stitched from two pictures): <a href="http://www.cim.mcgill.ca/~vleves/oops-full.jpg">http://www.cim.mcgill.ca/~vleves/oops-full.jpg</a>.<br>
<br>Vincent Levesque<br><a href="mailto:vleves@domain.hid">vleves@domain.hid</a><br><br><div class="gmail_quote">On Tue, Apr 1, 2008 at 2:09 AM, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Vincent Levesque wrote:<br>
&nbsp;&gt; Thanks for the tip. I tried and did indeed get error messages. Unfortunately<br>
&nbsp;&gt; I haven&#39;t been able to redirect these errors to a file or to find any<br>
&nbsp;&gt; reference to them in /var/log/. The best I could do was to take a picture of<br>
</div>&nbsp;&gt; the screen: <a href="http://www.cim.mcgill.ca/%7Evleves/oops.jpg" target="_blank">http://www.cim.mcgill.ca/~vleves/oops.jpg</a>&lt;<a href="http://www.cim.mcgill.ca/%7Evleves/oops.jpg" target="_blank">http://www.cim.mcgill.ca/%7Evleves/oops.jpg</a>&gt;.<br>

<div class="Ih2E3d">&nbsp;&gt; Please let me know if I can do anything else.<br>
<br>
</div>At first sight, it looks like you have the same issue with kmap_atomic<br>
as Tomas. Could you try and increase resolution so that we get the<br>
beginning of the oops ? Enable &quot;Video mode selection support&quot; in<br>
&quot;Console display driver support&quot; menu, then pass something like<br>
vga=0x0F01 on kernel command line. Also enable frame pointers in the<br>
kernel if they are disabled.<br>
<br>
--<br>
<font color="#888888"><br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br>

------=_Part_45_30382516.1207193009369--

