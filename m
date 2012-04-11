Message-ID: <4F854D1E.7010200@domain.hid>
Date: Wed, 11 Apr 2012 11:21:34 +0200
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
References: <4F85479F.1060305@domain.hid> <4F854B8E.7050803@domain.hid>
In-Reply-To: <4F854B8E.7050803@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------090001090504080609080809"
Subject: Re: [Xenomai-help] kernel panic unload xeno_nucleus module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--------------090001090504080609080809
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

On 04/11/2012 11:14 AM, Philippe Gerum wrote:
> On 04/11/2012 10:58 AM, Alessio Margan @ IIT wrote:
>> Hi all,
>>
>> when I try to unload xeno_nucleus module I get a kernel panic and on the
>> next power on the bios system date is reset.
>> when configure xenomai nucleus built into the kernel I can reboot correc=
tly.
>>
> Kernel panic log would help.
>
I'll try to get it
>> In the bios I disabled HPET and most of the things regarding PM and ACPI.
>>
>> Here attached same info about system and kernel config.
>>
>> If possible, I prefer have xenomai configured as modules, is there
>> anything wrong about my system configuration ?
>>
> This should not be a configuration issue. Either some kernel-based
> Xenomai threads (e.g. RTDM driver thread) are still running when
> attempting to unload the nucleus, or a real-time IRQ is still hooked to
> a handler being unmapped, or there is a nucleus bug.
>
after boot the only thing I do is load nucleus and unload it, no other=20
xenomai modules are loaded
>
Thanks
Alessio

--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova=20
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The=20
information is intended for the use of the addressee only. If you are=20
not the addressee we would appreciate your notification in this respect.=20
Please note that any disclosure, copy, distribution or use of the=20
contents of this message is prohibited and may be unlawful. We have=20
taken every reasonable precaution to ensure that any kind of attachment=20
to this e-mail has been swept for viruses. However, we cannot accept=20
liability for any damage sustained as a result of software viruses and=20
would advise you to carry out your own virus checks before opening any=20
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai=20
soli destinatari. Qualora  veniate in possesso di tali informazioni=20
senza essere definito come destinatario vi reghiamo di leggere le=20
seguenti note. Ogni apertura, copia, distribuzione del contenuto del=20
messaggio e dei suoi allegati =E8 proibito e potrebbe violare le presenti=20
leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per=20
assicurare che gli allegati non contengano virus. Comunque non=20
assumeremo alcuna responsabilit=E0 per ogni eventuale danno causato da=20
virus software e simili in quanto =E8 onere del destinatario verificarne=20
l=92assenza in ogni allegato attuando propri indipendenti controlli.


--------------090001090504080609080809
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#ffffff" text=3D"#000000">
    On 04/11/2012 11:14 AM, Philippe Gerum wrote:
    <blockquote cite=3D"mid:4F854B8E.7050803@domain.hid" type=3D"cite">
      <pre wrap=3D"">On 04/11/2012 10:58 AM, Alessio Margan @ IIT wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Hi all,

when I try to unload xeno_nucleus module I get a kernel panic and on the
next power on the bios system date is reset.
when configure xenomai nucleus built into the kernel I can reboot correctly.

</pre>
      </blockquote>
      <pre wrap=3D"">
Kernel panic log would help.

</pre>
    </blockquote>
    I'll try to get it<br>
    <blockquote cite=3D"mid:4F854B8E.7050803@domain.hid" type=3D"cite">
      <pre wrap=3D""></pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">In the bios I disabled HPET and most of the things r=
egarding PM and ACPI.

Here attached same info about system and kernel config.

If possible, I prefer have xenomai configured as modules, is there
anything wrong about my system configuration ?

</pre>
      </blockquote>
      <pre wrap=3D"">
This should not be a configuration issue. Either some kernel-based=20
Xenomai threads (e.g. RTDM driver thread) are still running when=20
attempting to unload the nucleus, or a real-time IRQ is still hooked to=20
a handler being unmapped, or there is a nucleus bug.

</pre>
    </blockquote>
    after boot the only thing I do is load nucleus and unload it, no
    other xenomai modules are loaded<br>
    <blockquote cite=3D"mid:4F854B8E.7050803@domain.hid" type=3D"cite"><br>
      <pre wrap=3D"">
</pre>
    </blockquote>
    Thanks<br>
    Alessio<br>
    <br>
    <div class=3D"moz-signature">-- <br>
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <title>Untitled Document</title>
      <style type=3D"text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12pt;
}
.style8 {
	font-size: 11px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style10 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
}
.style12 {font-size: 14px}
.style15 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
      <p><span class=3D"style8">ISTITUTO ITALIANO<br>
          DI TECNOLOGIA</span></p>
      <p class=3D"style10">Alessio Margan<br>
        <em>Senior Technician</em><br>
        <a href=3D"mailto:alessio.margan@domain.hid">mail me</a></p>
      <p class=3D"style10"><a
href=3D"http://maps.google.com/maps?f=3Dq&amp;hl=3Den&amp;geocode=3D&amp;q=
=3Dvia+morego,+30+genova&amp;sll=3D37.0625,-95.677068&amp;sspn=3D85.420533,=
191.601563&amp;ie=3DUTF8&amp;ll=3D44.474913,8.907037&amp;spn=3D0.004685,0.0=
11652&amp;t=3Dh&amp;z=3D17&amp;iwloc=3Daddr">Via
          Morego, 30 16163 Genova</a><br>
      </p>
      <p class=3D"style1"><span class=3D"style12"><a
            href=3D"http://www.iit.it">www.iit.it</a></span></p>
      <p class=3D"style15"><strong>Legal Disclaimer</strong><br>
        This electronic message contains information that is
        confidential. The information is intended for the use of the
        addressee only. If you are not the addressee we would appreciate
        your notification in this respect. Please note that any
        disclosure, copy, distribution or use of the contents of this
        message is prohibited and may be unlawful. We have taken every
        reasonable precaution to ensure that any kind of attachment to
        this e-mail has been swept for viruses. However, we cannot
        accept liability for any damage sustained as a result of
        software viruses and would advise you to carry out your own
        virus checks before opening any attachment.=A0=A0=A0=A0=A0<br>
        <strong>Avvertenza legale</strong><br>
        Questo messaggio Email contiene informazioni confidenziali
        riservate ai soli destinatari. Qualora=A0 veniate in possesso di
        tali informazioni senza essere definito come destinatario vi
        reghiamo di leggere le seguenti note. Ogni apertura, copia,
        distribuzione del contenuto del messaggio e dei suoi allegati =E8
        proibito e potrebbe violare le presenti leggi. Abbiamo attivato
        ogni possibile e ragionevole precauzione per assicurare che gli
        allegati non contengano virus. Comunque non assumeremo alcuna
        responsabilit=E0 per ogni eventuale danno causato da virus
        software e simili in quanto =E8 onere del destinatario verificarne
        l=92assenza in ogni allegato attuando propri indipendenti
        controlli.</p>
    </div>
  </body>
</html>

--------------090001090504080609080809--

