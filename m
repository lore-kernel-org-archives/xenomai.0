Message-ID: <4EBA66DE.5020307@domain.hid>
Date: Wed, 09 Nov 2011 12:41:18 +0100
From: Olivier Reynet <olivier.reynet@domain.hid>
MIME-Version: 1.0
References: <51962.81.220.196.189.1320786408.squirrel@domain.hid>
	<4EB9C562.9040107@domain.hid> <4EBA5585.8050807@domain.hid>
	<4EBA5DE2.3060307@domain.hid>
In-Reply-To: <4EBA5DE2.3060307@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------000400070005020608080003"
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and Round Robin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000400070005020608080003
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

ok, sorry for misunderstanding.

RTIME quantum=3D3;
is working.

/quantum/ 	The round-robin quantum for the task expressed in ticks (see=20
note).

Howewer, there is no link to the mentioned note. It will help to understa=
nd the tick concept.

Best regards,
Olivier


Le 09/11/2011 12:02, Gilles Chanteperdrix a =C3=A9crit :
> RTIME quantum=3Drt_timer_ns2tsc(3*SPINTIME);


--------------000400070005020608080003
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    ok, sorry for misunderstanding. <br>
    <pre wrap=3D"">RTIME quantum=3D3;=20
is working.=20
</pre>
    <table style=3D"font-family: Geneva, Arial, Helvetica, sans-serif;
      letter-spacing: normal; orphans: 2; text-indent: 0px;
      text-transform: none; widows: 2; word-spacing: 0px;
      -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
      background-color: rgb(238, 243, 245); " border=3D"0" cellpadding=3D=
"0"
      cellspacing=3D"2">
      <tbody>
        <tr>
          <td style=3D"font-family: Geneva, Arial, Helvetica, sans-serif;
            font-size: 15px; " valign=3D"top"><em>quantum</em>=C2=A0</td>
          <td style=3D"font-family: Geneva, Arial, Helvetica, sans-serif;
            font-size: 15px; ">The round-robin quantum for the task
            expressed in ticks (see note).</td>
        </tr>
      </tbody>
    </table>
    <pre wrap=3D""><span class=3D"Apple-style-span" style=3D"color: rgb(0=
, 0, 0); font-family: 'Lucida Grande', Verdana, Geneva, Arial, sans-serif=
; font-size: 12px; font-style: normal; font-variant: normal; font-weight:=
 normal; letter-spacing: normal; line-height: normal; orphans: 2; text-al=
ign: -webkit-auto; text-indent: 0px; text-transform: none; white-space: n=
ormal; widows: 2; word-spacing: 0px; -webkit-text-size-adjust: auto; -web=
kit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display=
: inline !important; float: none; ">Howewer, there is no link to the ment=
ioned note. It will help to understand the tick concept.=20
=C2=A0
</span>Best regards,
Olivier
</pre>
    <br>
    Le 09/11/2011 12:02, Gilles Chanteperdrix a =C3=A9crit=C2=A0:
    <blockquote cite=3D"mid:4EBA5DE2.3060307@domain.hid" type=3D"cite">
      <pre wrap=3D"">RTIME quantum=3Drt_timer_ns2tsc(3*SPINTIME);</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000400070005020608080003--


